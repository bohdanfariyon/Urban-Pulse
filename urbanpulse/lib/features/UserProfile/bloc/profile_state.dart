part of 'profile_bloc.dart';

@immutable
sealed class ProfileState extends Equatable{}

final class ProfileInitial extends ProfileState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class Loading extends ProfileState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class LoadedData extends ProfileState {
  final firstname;
  final lastname;
  LoadedData({
    required this.firstname,
    required this.lastname,
  });
  
  @override
  // TODO: implement props
  List<Object?> get props => [firstname, lastname];

}

