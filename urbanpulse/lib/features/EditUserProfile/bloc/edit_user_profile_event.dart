part of 'edit_user_profile_bloc.dart';

@immutable
sealed class EditUserProfileEvent extends Equatable{}

class OnSave extends EditUserProfileEvent{
  final String newFirstname;
  final String newLastname;

  OnSave({required this.newFirstname, required this.newLastname});
  
  @override
  // TODO: implement props
  List<Object?> get props => [newFirstname, newLastname];
}