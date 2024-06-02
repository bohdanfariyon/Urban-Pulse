import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:urbanpulse/repositories/repositories.dart';
part 'change_password_event.dart';
part 'change_password_state.dart';

class ChangePasswordBloc extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  ChangePasswordBloc() : super(ChangePasswordInitial()) {
    on<OnChangePassword>((event, emit)async {
      if (event.new_password == event.new_password_again && event.new_password.isNotEmpty){
        emit(Loading());
        final bool request = await GetIt.I<AbstractUserReposity>().changePasswordRequest(event.current_password, event.new_password);
        if(request){
          emit(PasswordChangedSuccessful());

        } else {
          emit(ErrorEnterCurrentPassword());
        }
      } else {
        emit(ErrorEnterNewPassword());
      }
    });
  }
}
