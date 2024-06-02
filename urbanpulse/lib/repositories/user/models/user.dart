import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User extends Equatable {
  @HiveField(0)
  String username;
  @HiveField(1)
  String firstname;
  @HiveField(2)
  String lastname;
  @HiveField(3)
  String state;
  @HiveField(4)
  String country;

  User(this.username, this.firstname, this.lastname, this.state, this.country);

  @override      
  List<Object?> get props => [username, firstname, lastname, state, country];

  factory User.fromJson(Map<String, dynamic> json) => User(
    json['username'],
    json['firstname'],
    json['lastname'],
    json['state'],
    json['country'],
  );
}
