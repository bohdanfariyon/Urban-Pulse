part of 'map_bloc.dart';

abstract class MapState extends Equatable {
  const MapState();

  @override
  List<Object> get props => [];
}

class MapInitial extends MapState {}

class MapLoading extends MapState {}

class MapLoaded extends MapState {
  final Marker userLocation;
  final List<Marker> markers;
  final LatLng currentLocation;

  const MapLoaded({required this.currentLocation, required this.markers,required this.userLocation});

  @override
  List<Object> get props => [currentLocation, markers];
}

class MapError extends MapState {}
