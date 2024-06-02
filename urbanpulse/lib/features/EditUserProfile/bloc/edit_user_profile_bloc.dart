import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:urbanpulse/repositories/repositories.dart';
part 'edit_user_profile_event.dart';
part 'edit_user_profile_state.dart';

class EditUserProfileBloc extends Bloc<EditUserProfileEvent, EditUserProfileState> {
  EditUserProfileBloc() : super(EditUserProfileInitial()) {
    on<OnSave>((event, emit) async{
      String newFirstname=event.newFirstname.replaceAll(" ", "");
      String newLastname=event.newLastname.replaceAll(" ", "");
      if(newLastname.length==0 || newFirstname.length==0){
        emit(ErrorNoCorrectData());
      }else{

        try {
          emit(Loading());
          final bool isUpgrade =await GetIt.I<AbstractUserReposity>().upgradeUserInfo(newFirstname, newLastname);
          if(isUpgrade){
            emit(UpdataUserDataSuccessfull());
          }else{
            emit(ErrorNoConnection());
          }
          
        } catch (e,st) {
          GetIt.I<Talker>().handle(e,st);
          emit(ErrorNoConnection());
        }
      }
    });
  }
}
