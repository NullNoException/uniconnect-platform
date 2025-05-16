import 'package:connectivity_plus/connectivity_plus.dart';

enum NetworkStatus { online, offline }

class NetworkInfo {
  final Connectivity _connectivity = Connectivity();

  // Stream to listen to connectivity changes
  Stream<NetworkStatus> get statusStream =>
      _connectivity.onConnectivityChanged.map((result) {
        return _getStatus(result);
      });

  // Get current network status
  Future<NetworkStatus> get currentStatus async {
    final connectivityResult = await _connectivity.checkConnectivity();
    return _getStatus(connectivityResult);
  }

  // Check if device is connected to the internet
  Future<bool> isConnected() async {
    final status = await currentStatus;
    return status == NetworkStatus.online;
  }

  NetworkStatus _getStatus(List<ConnectivityResult> result) {
    if (result.any(
      (r) =>
          r == ConnectivityResult.mobile ||
          r == ConnectivityResult.wifi ||
          r == ConnectivityResult.ethernet ||
          r == ConnectivityResult.vpn,
    )) {
      return NetworkStatus.online;
    } else {
      return NetworkStatus.offline;
    }
  }
}
