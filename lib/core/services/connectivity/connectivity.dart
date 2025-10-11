

import 'package:connectivity_plus/connectivity_plus.dart';

class CheckConnectivity{

  static Future<bool> checkConnectivity()async{

    final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult.contains(ConnectivityResult.mobile)) {
       return true;
    } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
       return true;
    } else if (connectivityResult.contains(ConnectivityResult.vpn)) {
      return true;
    } else {
       return false;
    }
  }

}