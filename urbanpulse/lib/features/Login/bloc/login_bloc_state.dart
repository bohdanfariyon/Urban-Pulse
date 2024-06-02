part of 'login_bloc_bloc.dart';

sealed class LoginBlocState extends Equatable {
  const LoginBlocState();
  
  @override
  List<Object> get props => [];
}

final class LoginBlocInitial extends LoginBlocState {}

class IncorrectlyEntered extends LoginBlocState{
  final String errorMessage='Incorrectly entered login or password';
  @override
  List<Object> get props => [errorMessage];
}

class IsSuccessfulAuthorization extends LoginBlocState{
  final bool isLogin;

  const IsSuccessfulAuthorization({required this.isLogin});
  @override
  List<Object> get props => [isLogin];
}
class Loading extends LoginBlocState{}