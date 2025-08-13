import 'package:connectivity_plus/connectivity_plus.dart';

class InternetChecker {
  static Future<bool> isConnectedToInternet() async {
    final List<ConnectivityResult> connectivityResult = await (Connectivity()
        .checkConnectivity());

    if (connectivityResult.contains(ConnectivityResult.none)) {
      return false;
    } else {
      return true;
    }
  }
}
