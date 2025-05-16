import 'package:connectivity_plus/connectivity_plus.dart';

enum NetworkStatus { online, offline }

class NetworkInfo {
  final Connectivity _connectivity = Connectivity();

  // Stream to listen to connectivity changes
  Stream<NetworkStatus> get statusStream =>
      _connectivity.onConnectivityChanged.map((result) {
        if (result is List<ConnectivityResult>) {
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
        } else {
          return _getNetworkStatus(result as ConnectivityResult);
        }
      });

  // Get current network status
  Future<NetworkStatus> get currentStatus async {
    final connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult is List<ConnectivityResult>) {
      // If it's a list, check if any are online
      if (connectivityResult.any(
        (result) =>
            result == ConnectivityResult.mobile ||
            result == ConnectivityResult.wifi ||
            result == ConnectivityResult.ethernet ||
            result == ConnectivityResult.vpn,
      )) {
        return NetworkStatus.online;
      } else {
        return NetworkStatus.offline;
      }
    } else {
      return _getNetworkStatus(connectivityResult as ConnectivityResult);
    }
  }

  // Check if device is connected to the internet
  Future<bool> isConnected() async {
    final status = await currentStatus;
    return status == NetworkStatus.online;
  }

  NetworkStatus _getNetworkStatus(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.mobile:
      case ConnectivityResult.wifi:
      case ConnectivityResult.ethernet:
      case ConnectivityResult.vpn:
        return NetworkStatus.online;
      case ConnectivityResult.bluetooth:
      case ConnectivityResult.none:
      case ConnectivityResult.other:
        return NetworkStatus.offline;
    }
  }
}
