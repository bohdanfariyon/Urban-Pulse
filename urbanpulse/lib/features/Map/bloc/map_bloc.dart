import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:latlong2/latlong.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:urbanpulse/features/Map/widgets/custom_market.dart';
import 'package:equatable/equatable.dart';
import 'package:urbanpulse/features/Map/widgets/marker_user_location.dart';
import 'package:urbanpulse/repositories/locations/abstract_locations_reposity.dart';
import 'package:urbanpulse/repositories/locations/models/location.dart';
import 'package:urbanpulse/repositories/repositories.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final BuildContext context;
  MapBloc(this.context) : super(MapInitial()) {
    on<LoadMarkers>((event, emit) async {
      emit(MapLoading());
    try {
      LatLng currentLocation=LatLng(0, 0);
      try {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        currentLocation = LatLng(position.latitude, position.longitude);
      }catch (e) {
        final user=GetIt.I<AbstractUserReposity>().getUser();
        final String Url="https://nominatim.openstreetmap.org/search.php?q=${user?.state}&format=jsonv2";
        final response = await await GetIt.I<Dio>().get(Url);  
        
        if (response.statusCode == 200) {
          
          final List<dynamic> data = response.data;
          if (data.isNotEmpty) {
            final Map<String, dynamic> firstResult = data[0];
            double latitude=double.parse(firstResult['lat']) ;
            double longitude=double.parse(firstResult['lon']) ;
            currentLocation=LatLng(latitude, longitude);
          }
        } 
      }

      

      final userLoaction=MarkerUserLocation(currentLocation);
      try {
        if(GetIt.I<AbstractLocationsReposity>().locations.length==0){
          await GetIt.I<AbstractLocationsReposity>().downloadLocations();
        }
        
      } catch (e) {
        GetIt.I<Talker>().handle(e);
        emit(MapError());
        return;
      }
      List<Location> data=GetIt.I<AbstractLocationsReposity>().locations;
      
      
      List<Marker> markers = [];
      for (var item in data) {
        final marker = await addMarker(
          item.id,
          LatLng(item.lat, item.lon),
          item.businessName,
          item.category,
        );
        markers.add(marker);
      }

      emit( MapLoaded(currentLocation: currentLocation, markers: markers, userLocation: userLoaction));
    } catch (_) {
      emit( MapError());
    }
    });
  }
  Future<Marker> addMarker(int id, LatLng location, String title, String category) async {
    CustomMarker customMarker = CustomMarker(
      id: id,
      location: location,
      title: title,
      category: category,
    );
    return await customMarker.createCustomMarker(context);
  }
}


  

