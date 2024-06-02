import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:urbanpulse/features/Partners/components/business_widget.dart';
import 'package:equatable/equatable.dart';
import 'package:urbanpulse/repositories/locations/abstract_locations_reposity.dart';
part 'partners_event.dart';
part 'partners_state.dart';

class PartnersBloc extends Bloc<PartnersEvent, PartnersState> {
  List<BusinessWidget> _allBusinesses = [];

  String _selectedFilter = 'all';
  String _selectedSortOption = 'By Name';
  String _selectedSortDirection = 'Ascending';
  String _searchQuery = '';

  PartnersBloc() : super(PartnersInitial()) {
    on<LoadPartners>(_onLoadPartners);
    on<UpdateFilter>(_onUpdateFilter);
    on<UpdateSearchQuery>(_onUpdateSearchQuery);
  }

  void _onLoadPartners(LoadPartners event, Emitter<PartnersState> emit) async {
    emit(PartnersLoading());
    if(event.isDownload){
      GetIt.I<AbstractLocationsReposity>().locations=[];
      try {
      await GetIt.I<AbstractLocationsReposity>().downloadLocations();
    } catch (e) {
      GetIt.I<Talker>().handle(e);
      emit(PartnersError());
      return;
    }
    }else{
      try {
        if(GetIt.I<AbstractLocationsReposity>().locations.length==0){
          await GetIt.I<AbstractLocationsReposity>().downloadLocations();
        }
        
      } catch (e) {
        GetIt.I<Talker>().handle(e);
        emit(PartnersError());
        return;
      }
    }
    
    
    
    bool flag = true;
    double latitude=0;
    double longitude=0;
    var status = await Permission.location.request();
    if (status == PermissionStatus.granted) {
      try {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );

        latitude = position.latitude;
        longitude = position.longitude;      
      } catch (e, st) {
        GetIt.I<Talker>().handle(e,st);
        flag=false;
      }
    } else {
      flag=false;
    }
    try {
      _allBusinesses=[];
      for (var location in GetIt.I<AbstractLocationsReposity>().locations) {
        BusinessWidget businessWidget = BusinessWidget(
          id: location.id,
          businessName: location.businessName,
          category: location.category,
          distance: flag ? calculateDistance(latitude, longitude, location.lat, location.lon) : 0,
        );
        _allBusinesses.add(businessWidget);
      }
      _filterSortAndSearch(emit);
    } catch (e,st) {
      GetIt.I<Talker>().handle(e,st);
      emit(PartnersError());
    }
  }

  void _onUpdateFilter(UpdateFilter event, Emitter<PartnersState> emit) {
    _selectedFilter = event.filter;
    _selectedSortOption = event.sortOption;
    _selectedSortDirection = event.sortDirection;
    _filterSortAndSearch(emit);
  }

  void _onUpdateSearchQuery(UpdateSearchQuery event, Emitter<PartnersState> emit) {
    _searchQuery = event.searchQuery;
    _filterSortAndSearch(emit);
  }

  void _filterSortAndSearch(Emitter<PartnersState> emit) {
    List<BusinessWidget> filteredBusinesses = _allBusinesses
        .where((business) => _selectedFilter == 'all' ||
            business.category.toLowerCase() == _selectedFilter.toLowerCase())
        .where((business) => business.businessName.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    filteredBusinesses.sort((a, b) {
      if (_selectedSortOption == 'By Name') {
        return _selectedSortDirection == 'Ascending'
            ? a.businessName.compareTo(b.businessName)
            : b.businessName.compareTo(a.businessName);
      } else {
        return _selectedSortDirection == 'Ascending'
            ? a.distance.compareTo(b.distance)
            : b.distance.compareTo(a.distance);
      }
    });

    emit(PartnersLoaded(businesses: filteredBusinesses,selectedFilter: _selectedFilter,selectedSortOption: _selectedSortOption,selectedSortDirection: _selectedSortDirection));
  }
}
double degreesToRadians(double degrees) {
  return degrees * pi / 180;
}

int calculateDistance(double lat1, double lon1, double lat2, double lon2) {
  const double earthRadius = 6371000.0; 


  double lat1Rad = degreesToRadians(lat1);
  double lon1Rad = degreesToRadians(lon1);
  double lat2Rad = degreesToRadians(lat2);
  double lon2Rad = degreesToRadians(lon2);


  double dLat = lat2Rad - lat1Rad;
  double dLon = lon2Rad - lon1Rad;


  double a = pow(sin(dLat / 2), 2) +
      pow(sin(dLon / 2), 2) * cos(lat1Rad) * cos(lat2Rad);
  double c = 2 * asin(sqrt(a));
  double distanceInMeters = (earthRadius * c);
  int distance=distanceInMeters.round();
  return distance;
}