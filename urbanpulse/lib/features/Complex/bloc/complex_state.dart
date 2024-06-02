part of 'complex_bloc.dart';

@immutable
sealed class ComplexState extends Equatable{}

final class ComplexInitial extends ComplexState {
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class Loading extends ComplexState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class LoadedDetailedInformation  extends ComplexState{
  final DetailedLocationInformation data;

  LoadedDetailedInformation({required this.data});
  
  @override
  // TODO: implement props
  List<Object?> get props => [data];
  
}

class ErrorLoaded extends ComplexState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class ErrorOpenGoogleMap extends ComplexState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class ErrorAccessToGeolocation extends ComplexState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}