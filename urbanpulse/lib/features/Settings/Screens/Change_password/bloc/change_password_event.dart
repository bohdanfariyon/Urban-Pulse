part of 'change_password_bloc.dart';

@immutable
sealed class ChangePasswordEvent extends Equatable {}

class OnChangePassword extends ChangePasswordEvent{
  final String new_password;
  final String new_password_again;
  final String current_password;

  OnChangePassword({required this.new_password, required this.new_password_again, required this.current_password});
  
  @override
  // TODO: implement props
  List<Object?> get props => [new_password, new_password_again, current_password];

}
