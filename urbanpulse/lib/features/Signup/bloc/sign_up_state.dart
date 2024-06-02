part of "sign_up_bloc.dart";
abstract class SignUpState extends Equatable{}

class SignUpInitial extends SignUpState{
  @override
  
  List<Object?> get props =>[];
  
}

class IncorectEmail extends SignUpState{
  final String content='Будь ласка, введіть коректну електронну адресу.';
  final String title='Помилка';

  @override
  List<Object> get props => [content, title];
}
class ErrorEmailSend extends SignUpState{
  
  ErrorEmailSend({required this.email});
  final String email;
  String get content => 'Не вдалося надіслати лист на $email.';
  final String title='Помилка';
  @override
  List<Object> get props => [email, content, title];
  
}

class SentEmailSuccessfully extends SignUpState{
  final String email;

  SentEmailSuccessfully({required this.email});

  String get content => 'Лист з верифікацією було надіслано на $email';
  final String title='Успіх';
  @override
  List<Object> get props => [email, content, title];
}

class PleaseInputCode extends SignUpState{
  final String errorMessage="Incorrectly entered email code";
  @override
  List<Object> get props => [errorMessage];
}

class PleaseFillFields extends SignUpState{
  final String errorMessage='Please fill in the fields';
  @override
  List<Object> get props => [errorMessage];
}

class SuccessfullyRegistered extends SignUpState{
  final String message="The account is registered";
  @override
  List<Object> get props => [message];
}

class AlreadyExists extends SignUpState{
  final String errorMessage="Such an account already exists";
  @override
  List<Object> get props => [errorMessage];
}
class LoadingVerify extends SignUpState{
  @override
  List<Object> get props => [];
}
class LoadingSignUp extends SignUpState{
  @override
  List<Object> get props => [];
}