import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityUtil {
  static Future<bool> checkConnectivity() async {
    final List<ConnectivityResult> connectivityResult = await Connectivity().checkConnectivity();

    // Check if the list contains either Wi-Fi or Mobile
    return connectivityResult.contains(ConnectivityResult.wifi) ||
        connectivityResult.contains(ConnectivityResult.mobile);
  }
}
