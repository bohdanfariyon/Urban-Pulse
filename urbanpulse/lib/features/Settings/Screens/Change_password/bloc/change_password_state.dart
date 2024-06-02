part of 'change_password_bloc.dart';

@immutable
sealed class ChangePasswordState extends Equatable{}

final class ChangePasswordInitial extends ChangePasswordState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ErrorEnterNewPassword extends ChangePasswordState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ErrorEnterCurrentPassword extends ChangePasswordState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class PasswordChangedSuccessful extends ChangePasswordState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class Loading extends ChangePasswordState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

