import 'package:equatable/equatable.dart';
class Location extends Equatable{
  final int id;
  final String businessName;
  final String category;
  final double lat;
  final double lon;

  Location({required this.id, required this.businessName, required this.category, required this.lat, required this.lon});

  
  
  @override
  // TODO: implement props
  List<Object?> get props => [id, businessName, category, lat, lon];
}