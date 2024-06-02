part of 'edit_user_profile_bloc.dart';

@immutable
sealed class EditUserProfileState extends Equatable{}

final class EditUserProfileInitial extends EditUserProfileState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ErrorNoCorrectData extends EditUserProfileState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class ErrorNoConnection extends EditUserProfileState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class UpdataUserDataSuccessfull extends EditUserProfileState{
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class Loading extends EditUserProfileState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

