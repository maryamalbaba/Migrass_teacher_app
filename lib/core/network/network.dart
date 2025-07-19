// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:internet_connection_checker/internet_connection_checker.dart';

class NetworkConnection {
  InternetConnectionChecker connection;
  NetworkConnection({
    required this.connection,
  });
  Future<bool> get is_connected async {
    return await connection.hasConnection;
  }
}
