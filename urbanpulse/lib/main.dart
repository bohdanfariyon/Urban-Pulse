import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urbanpulse/repositories/locations/abstract_locations_reposity.dart';
import 'package:urbanpulse/repositories/locations/locations_reposity.dart';
import 'package:urbanpulse/repositories/repositories.dart';
import 'package:urbanpulse/urbanpulse.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final talker = TalkerFlutter.init();
  
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  final dio = Dio();
  
  dio.interceptors.add(
    TalkerDioLogger(
      talker: talker,
      settings: const TalkerDioLoggerSettings(
        printResponseData: false,
      ),
    ),
  );
  
  GetIt.I.registerSingleton(talker);
  GetIt.I.registerSingleton(dio);
  GetIt.I.registerLazySingleton<AbstractUserReposity>(() => UserReposity());
  await GetIt.I<AbstractUserReposity>().init(); // Викликайте init() перед реєстрацією репозиторія у GetIt
  
  Bloc.observer = TalkerBlocObserver(
    talker: talker,
    settings: const TalkerBlocLoggerSettings(
      printStateFullData: false,
      printEventFullData: false, 
    ),
  );

  GetIt.I.registerLazySingleton<AbstractLocationsReposity>(() => LocationsReposity());
  FlutterError.onError = (details) => GetIt.I<Talker>().handle(details.exception, details.stack);

  WidgetsFlutterBinding.ensureInitialized();
  

  runZonedGuarded(() => runApp(const UrbanPulse()), (e, st) {
    GetIt.I<Talker>().handle(e, st);
  });
}




