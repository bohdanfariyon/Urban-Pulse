part of 'complex_bloc.dart';

@immutable
sealed class ComplexEvent extends Equatable{}

class OnLoadDetailInformation extends ComplexEvent{
  final int id;

  OnLoadDetailInformation({required this.id});
  
  @override
  // TODO: implement props
  List<Object?> get props => [id];

}

class OnBuildARoute extends ComplexEvent{
  final double lat;
  final double lon;

  OnBuildARoute({required this.lat, required this.lon});
  @override
  // TODO: implement props
  List<Object?> get props => [];

}