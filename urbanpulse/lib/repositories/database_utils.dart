import 'package:dart_mysql/dart_mysql.dart';
import 'package:urbanpulse/config/app_config.dart';
Future<Results> database_utils(String sqlQuery, List<dynamic> params) async {
  final MySqlConnection connection = await MySqlConnection.connect(ConnectionSettings(
    host: AppConfig.HOSTNAME,
    port: AppConfig.PORT,
    user: AppConfig.USER,
    db: AppConfig.DATABASENAME,
    password: AppConfig.PASSWORD,
  ));

  try {
    Results results = await connection.query(sqlQuery, params);
    return results;
  } finally {
    await connection.close();
  }
}