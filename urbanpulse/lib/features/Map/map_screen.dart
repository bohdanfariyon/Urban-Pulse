import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map_supercluster/flutter_map_supercluster.dart';
import 'package:urbanpulse/features/ConnectionError/connection_error_screen.dart';
import 'package:urbanpulse/features/Map/bloc/map_bloc.dart';

LatLng currentLocation = LatLng(0, 122);

dynamic markerLocation;


class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  
  
  
  @override
  Widget build(BuildContext context) {
    
    return BlocProvider(
      create: (_) => MapBloc(context)..add(LoadMarkers()),
      child: Scaffold(
        body: BlocBuilder<MapBloc, MapState>(
          builder: (context, state) {
            if (state is MapLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is MapLoaded) {
              return FlutterMap(
                options: MapOptions(
                  center: state.currentLocation,
                  zoom: 14.0,
                  interactionOptions: InteractionOptions(
                    pinchZoomWinGestures: MultiFingerGesture.pinchZoom,
                  ),
                ),
                children: [
                  TileLayer(
                    urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  ),
                  MarkerLayer(
                    markers: [state.userLocation],
                  ),
                  SuperclusterLayer.immutable(
                    initialMarkers: state.markers,
                    indexBuilder: IndexBuilders.rootIsolate,
                    builder: (context, position, markerCount, extraClusterData) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.black,
                      ),
                      child: Center(
                        child: Text(
                          markerCount.toString(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else if (state is MapError) {
              return ListView(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height -
                              kToolbarHeight,
                          child: Center(child: ConnectionErrorScreen()),
                        ),
                      ],
                    );
            }
            return Container();
          },
        ),
      ),
    );
  }

  
  
}
