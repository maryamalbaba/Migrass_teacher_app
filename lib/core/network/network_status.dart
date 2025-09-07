import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkStatus {
  static final NetworkStatus instance = NetworkStatus._internal();

  factory NetworkStatus() => instance;

  NetworkStatus._internal() {
    _init();
  }

  bool _isConnected = false;

  // دالة لبدء فحص الاتصال
  Future<void> _init() async {
    _isConnected = await _checkInternetConnection();
    Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) async {
      _updateConnectionStatus(result);
    });
  }

  Future<bool> _checkInternetConnection() async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    return _evaluateConnectivity(connectivityResult);
  }

  bool _evaluateConnectivity(List<ConnectivityResult> connectivityResult) {
    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi) ||
        connectivityResult.contains(ConnectivityResult.ethernet) ||
        connectivityResult.contains(ConnectivityResult.vpn) ||
        connectivityResult.contains(ConnectivityResult.bluetooth) ||
        connectivityResult.contains(ConnectivityResult.other)) {
      return true;
    } else {
      return false;
    }
  }

  void _updateConnectionStatus(List<ConnectivityResult> result) {
    _isConnected = _evaluateConnectivity(result);
    print("=====================================");
    print(_isConnected);
  }

  // Getter للحصول على حالة الاتصال
  bool get isConnected => _isConnected;

  // Dispose method to close any resources if needed
  void dispose() {
    // No resources to dispose in this version
  }
}
