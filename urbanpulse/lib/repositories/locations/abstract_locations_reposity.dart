import 'package:urbanpulse/repositories/locations/models/detailed_location_information.dart';
import 'package:urbanpulse/repositories/locations/models/location.dart';

abstract class AbstractLocationsReposity{
  List<Location> locations=[];
  Future<void> downloadLocations();
  Future<DetailedLocationInformation> getDetailedInformationAboutLocations(int id);
}