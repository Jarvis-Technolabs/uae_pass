import 'package:connectivity_plus/connectivity_plus.dart';

import 'network_info.dart';

class NetworkInfoImpl implements NetworkInfo {
  NetworkInfoImpl(this.connectivity);

  final Connectivity connectivity;

  @override
  Future<bool> get isConnected async {
    bool result = false;
    List<ConnectivityResult> connectivityResults =
        await connectivity.checkConnectivity();
    for (int index = 0; index < connectivityResults.length; index++) {
      if (connectivityResults[index] == ConnectivityResult.mobile ||
          connectivityResults[index] == ConnectivityResult.wifi) {
        result = true;
        return result;
      }
    }
    return result;
  }
}
