part of "sign_up_bloc.dart";
abstract class SignUpEvent extends Equatable{}
class OnVerifyEmail extends SignUpEvent{
  final int code;
  final String email;

  OnVerifyEmail(this.code, this.email);
  
  @override
  List<Object> get props => [];
}

class OnRegister extends SignUpEvent{
  
  final String firstname;
  final String lastname;
  final String username;
  final String password;
  final int code;
  final int codeInput;

  OnRegister({required this.firstname, required this.lastname, required this.username, required this.password, required this.code, required this.codeInput});
  @override
  List<Object> get props => [firstname, lastname, username, password, code, codeInput];
}