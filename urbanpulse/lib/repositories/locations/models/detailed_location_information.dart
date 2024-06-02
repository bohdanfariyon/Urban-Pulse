import 'package:equatable/equatable.dart';
class DetailedLocationInformation extends Equatable{
  final String name;
  final String category;
  final String city;
  final String openingHours;
  final String phone;
  final String website;
  final double lat;
  final double lon;

  DetailedLocationInformation({required this.name, required this.category, required this.city, required this.openingHours, required this.phone, required this.website, required this.lat, required this.lon});
  
  @override
  // TODO: implement props
  List<Object?> get props => [name, category, city, openingHours, phone, website, lat, lon];
}