part of 'login_bloc_bloc.dart';

sealed class LoginBlocEvent extends Equatable {
  const LoginBlocEvent();

  @override
  List<Object> get props => [];
}

class OnLogin extends LoginBlocEvent{
  final String email;
  final String password;

  const OnLogin({required this.email, required this.password});
}