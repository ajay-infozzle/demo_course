import 'dart:developer';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InternetCubit extends Cubit<bool> {
  InternetCubit() : super(true) {
    Connectivity().onConnectivityChanged.listen((result) async{
      bool hasInternet = await _checkInternetAccess(); //~ Check actual internet access

      if ((result.contains(ConnectivityResult.wifi) ||
           result.contains(ConnectivityResult.mobile) ||
           result.contains(ConnectivityResult.ethernet) ||
           result.contains(ConnectivityResult.vpn)) 
           && hasInternet) {
        log("Internet-Connection: true", name:"InternetCubit");
        emit(true); 
      } else {
        log("Internet-Connection: false", name:"InternetCubit");
        emit(false);
      }
    });
  }

  Future<bool> _checkInternetAccess() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      log("Google-Ping-Result: $result", name:"InternetCubit");
      return result.isNotEmpty && result.first.rawAddress.isNotEmpty;
    } catch (e) {
      return false;
    }
  }
}
