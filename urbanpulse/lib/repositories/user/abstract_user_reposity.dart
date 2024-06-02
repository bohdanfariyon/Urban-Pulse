import 'package:urbanpulse/repositories/user/user.dart';

abstract class AbstractUserReposity {
  Future<void> init();
  Future<bool> login(String username, String password);
  User? getUser();
  Future<bool> registerUser(String firstname, String lastname, String username, String password);
  Future<void> setUserLocationInformation(String newState, String newCountry);
  Future<void> logOut();
  Future<bool> upgradeUserInfo(String newFirstname, String newLastname);
  Future<bool> changePasswordRequest(String currentPassword, String newPassword);
  
}