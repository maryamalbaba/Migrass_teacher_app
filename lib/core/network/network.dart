// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:connectivity_plus/connectivity_plus.dart';
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

class NetworkConnection2{
  final Connectivity _connectivity;

  NetworkConnection2({Connectivity? connectivity})
      : _connectivity = connectivity ?? Connectivity();

  Future<bool> get is_connected async {
    var result = await _connectivity.checkConnectivity();
    return result != ConnectivityResult.none;
  }
}