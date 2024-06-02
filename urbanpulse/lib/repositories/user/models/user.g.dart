// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 0;

  @override
  User read(BinaryReader reader) {
    return User(
      reader.readString(),
      reader.readString(),
      reader.readString(),
      reader.readString(),
      reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer.writeString(obj.username);
    writer.writeString(obj.firstname);
    writer.writeString(obj.lastname);
    writer.writeString(obj.state);
    writer.writeString(obj.country);
  }
}
