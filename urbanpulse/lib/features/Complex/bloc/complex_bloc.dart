import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:urbanpulse/repositories/locations/abstract_locations_reposity.dart';
import 'package:urbanpulse/repositories/locations/models/detailed_location_information.dart';
import 'package:url_launcher/url_launcher.dart';
part 'complex_event.dart';
part 'complex_state.dart';

class ComplexBloc extends Bloc<ComplexEvent, ComplexState> {
  ComplexBloc() : super(ComplexInitial()) {
    on<OnLoadDetailInformation>((event, emit) async{
      emit(Loading());
      try {
        final data= await GetIt.I<AbstractLocationsReposity>().getDetailedInformationAboutLocations(event.id);
        emit(LoadedDetailedInformation(data: data));
      } catch (e,st) {
        GetIt.I<Talker>().handle(e,st);
        emit(ErrorLoaded());
      }
      
    });
    on<OnBuildARoute>((event, emit) async{
      try {
        Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high,);
        try {
          openGoogleMaps(position.latitude, position.longitude, event.lat, event.lon);
        } catch (e,st) {
          GetIt.I<Talker>().handle(e,st);
          emit(ErrorOpenGoogleMap());
        }
      } catch (e,st) {
        GetIt.I<Talker>().handle(e,st);
        emit(ErrorAccessToGeolocation());
      }
    });
  }
}
void openGoogleMaps(double startLat, double startLng, double endLat, double endLng) async {
    String googleUrl = 'https://www.google.com/maps/dir/?api=1&origin=$startLat,$startLng&destination=$endLat,$endLng&travelmode=driving';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl); 
    } else {
      throw 'Could not open the map.';
    }
  }