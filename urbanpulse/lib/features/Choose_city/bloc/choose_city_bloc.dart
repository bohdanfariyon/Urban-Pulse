import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:urbanpulse/repositories/locations/abstract_locations_reposity.dart';
import 'package:urbanpulse/repositories/repositories.dart';

part 'choose_city_event.dart';
part 'choose_city_state.dart';

class ChooseCityBloc extends Bloc<ChooseCityEvent, ChooseCityState> {
  ChooseCityBloc() : super(ChooseCityInitial()) {
    on<OnSelect>((event, emit) async {
      emit(LoadingBySelect());
      final String apiUrl =
        'https://nominatim.openstreetmap.org/search.php?q=${event.location}&format=jsonv2&accept-language=ua';

    try {
      final response = await GetIt.I<Dio>().get(apiUrl);
      
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        if (data.isNotEmpty) {
          List<dynamic> boundingBox = List<String>.from(data[0]['boundingbox']);
          double latMid =
              (double.parse(boundingBox[0]) + double.parse(boundingBox[1])) / 2;
          double lonMid =
              (double.parse(boundingBox[2]) + double.parse(boundingBox[3])) / 2;

          try {
            List<String> datalocation= await findNearestCity(latMid, lonMid);
            if(datalocation.length==2){
              await GetIt.I<AbstractUserReposity>().setUserLocationInformation(datalocation[0], datalocation[1]);
              await GetIt.I<AbstractLocationsReposity>().downloadLocations();
              emit(SelectedRegionSuccess());
            }else{
              emit(ErrorSelectedRegion());
            }
          } on Exception catch (e,st) {
            GetIt.I<Talker>().handle(e,st);
            emit(ErrorSelectedRegion());
          }
        } else {
          GetIt.I<Talker>().error('No data found for the selected location');
          emit(ErrorSelectedRegion());
        }
      }
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);
    }
    });

    on<OnSelectByGeolocation>((event, emit) async {
      emit(LoadingByGeolocation());
      var status = await Permission.location.request();

    if (status == PermissionStatus.granted) {
      try {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );

        double latitude = position.latitude;
        double longitude = position.longitude;

        
        final List<String> datalocation= await findNearestCity(latitude, longitude);
          if(datalocation.length==2){
            await GetIt.I<AbstractUserReposity>().setUserLocationInformation(datalocation[0], datalocation[1]);
            await GetIt.I<AbstractLocationsReposity>().downloadLocations();
            emit(SelectedRegionSuccess());
          }else{
            emit(ErrorSelectedRegion());
          }
      } catch (e,st) {
        
        GetIt.I<Talker>().handle(e,st);
        emit(ErrorSelectedRegion());
      }
    } else {
      emit(ErrorSelecedRegionByGeolocation());
      
    }
    });
  }
}
  Future<List<String>> getRegionSuggestions(String query) async {
    final String apiUrl =
        'https://nominatim.openstreetmap.org/search.php?q=$query&format=jsonv2&accept-language=ua';

    try {
      final response = await GetIt.I<Dio>().get(apiUrl);

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map<String>((item) => item['display_name']).toList();
      } else {
        return [];
      }
    } catch (error) {
      return [];
    }
  }


  Future<List<String>> findNearestCity(double latitude, double longitude) async {
    final String apiUrl =
        'https://nominatim.openstreetmap.org/reverse?format=json&lat=$latitude&lon=$longitude&zoom=6&accept-language=ua';
      List<String> stateAndCounty=[];
    try {
      final response = await GetIt.I<Dio>().get(apiUrl);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        final String stateData = data['address']['state'];
        final String countryData = data['address']['country'];
        stateAndCounty.add(stateData);
        stateAndCounty.add(countryData);
      } else {
        GetIt.I<Talker>().error("Error getting location data: ${response.statusCode}");
        
      }
    } catch (error, st) {
      GetIt.I<Talker>().handle(error, st);
    }finally{
      return stateAndCounty;
    }
  }

  

