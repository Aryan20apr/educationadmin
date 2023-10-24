import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class NetworkChecker
{
  Future<bool> checkConnectivity() async
  {
    final connectivityResult = await (Connectivity().checkConnectivity());
      if(connectivityResult!=ConnectivityResult.wifi&&connectivityResult!=ConnectivityResult.mobile)
      {
        
        return false;
      }
      else
      return true;
  }
}