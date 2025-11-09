import 'package:connectivity_plus/connectivity_plus.dart';

/// Abstract class that defines network connectivity information.
///
/// Provides a method to check whether the device is currently connected to the internet.
abstract class NetworkInfo {
  /// A future that returns `true` if the device is connected to the internet, otherwise `false`.
  Future<bool> get isConnected;
}

/// Implementation of [NetworkInfo] that uses the [Connectivity] package to check network connectivity.
class NetworkInfoImpl implements NetworkInfo {
  
  NetworkInfoImpl(this.connectivity);

  final Connectivity connectivity;

  /// Checks if the device is connected to the internet.
  @override
  Future<bool> get isConnected async {
    final connectivityResult = await connectivity.checkConnectivity();
    return !connectivityResult.contains(ConnectivityResult.none);
  }
}
