import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:hive/hive.dart';
import 'package:urbanpulse/repositories/database_utils.dart';
import 'package:urbanpulse/repositories/user/abstract_user_reposity.dart';
import 'package:urbanpulse/repositories/user/models/user.dart';



class UserReposity extends AbstractUserReposity {
  Box<User>? _userBox;
  User? _user;
  @override
  Future<void> init() async {
    _userBox = await Hive.openBox<User>('userBox');
    _user = _userBox?.get('currentUser');
    
  }

  @override
  Future<bool> login(String username, String password) async {
    try {
      final response = await database_utils(
        'CALL user_login(?, ?)',
        [username, password],
      );
      _user = User(
        response.first["username"],
        response.first["firstname"],
        response.first["lastname"],
        response.first["state"],
        response.first["country"],
      );
      _userBox?.put('currentUser', _user!);
      return true;
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);
      return false;
    }
  }

  @override
  User? getUser() {
    return _user;
  }

  @override
  Future<bool> registerUser(String firstname, String lastname, String username, String password) async {
    _user = User(username, firstname, lastname, '', '');
    final response = await database_utils(
      'CALL register_user(?, ?, ?, ?, ?, ?)',
      [username, password, firstname, lastname, '', ''],
    );
    if (response.first["Result"] == 1) {
      _userBox?.put('currentUser', _user!);
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<void> setUserLocationInformation(String newState, String newCountry) async {
    try {
      final response = await database_utils(
        'CALL update_user_location(?, ?, ?)',
        [_user!.username, newState, newCountry],
      );
      _user?.country = newCountry;
      _user?.state = newState;
      _userBox?.put('currentUser', _user!);
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);
    }
  }

  @override
  Future<void> logOut() async {
    _user = null;
    await _userBox?.delete('currentUser');
  }

  @override
  Future<bool> upgradeUserInfo(String newFirstname, String newLastname) async {
    try {
      final response = await database_utils(
        'CALL update_user_information(?, ?, ?)',
        [_user!.username, newFirstname, newLastname],
      );
      _user?.firstname = newFirstname;
      _user?.lastname = newLastname;
      _userBox?.put('currentUser', _user!);
      return true;
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);
      return false;
    }
  }

  @override
  Future<bool> changePasswordRequest(String currentPassword, String newPassword) async {
    try {
      final response = await database_utils(
        'CALL change_user_password(?, ?, ?)',
        [_user!.username, currentPassword, newPassword],
      );
      if (response.first["Result"] == 1) {
        return true;
      } else {
        return false;
      }
    } catch (e, st) {
      GetIt.I<Talker>().handle(e, st);
      return false;
    }
  }
}
