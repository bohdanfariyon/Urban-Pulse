import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:urbanpulse/repositories/repositories.dart';
part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<OnLoadData>((event, emit) async{
      emit(Loading());
      final user =await GetIt.I<AbstractUserReposity>().getUser();
      emit(LoadedData(firstname: user?.firstname, lastname: user?.lastname));
    });
  }
}
