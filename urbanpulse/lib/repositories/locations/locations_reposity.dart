import 'package:get_it/get_it.dart';
import 'package:urbanpulse/repositories/locations/abstract_locations_reposity.dart';
import 'package:urbanpulse/repositories/locations/models/detailed_location_information.dart';
import 'package:urbanpulse/repositories/locations/models/location.dart';
import 'package:urbanpulse/repositories/repositories.dart';

class LocationsReposity extends AbstractLocationsReposity{
  @override
  Future<void> downloadLocations() async{
  final user = await GetIt.I<AbstractUserReposity>().getUser();
  List<Map<String, dynamic>> rows = [];
  final result = await database_utils('CALL get_partners_list(?)', [user!.state]);
  locations=[];
  for (var row in result) {
    rows.add(row.fields);
  }
  

  for (var row in rows) {
    Location location=Location(id: row['idLocations'], businessName: row['name'], category: row['amenity'], lat: double.parse(row['lat']), lon: double.parse(row['lon']));
    locations.add(location);
  }
  }
  @override
  Future<DetailedLocationInformation> getDetailedInformationAboutLocations(int id)async{
    final data=await database_utils('CALL get_location_by_id(?)', [id]);
    
    return DetailedLocationInformation(name: data.first['name'], category: data.first['amenity'], city: data.first['City'], openingHours: data.first['opening_hours'],phone: data.first['phone'],website: data.first['website'],lat: double.parse(data.first['lat']),lon: double.parse(data.first['lon']));
    
  }
}