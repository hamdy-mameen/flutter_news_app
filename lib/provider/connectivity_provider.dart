import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityProvider with ChangeNotifier {
  var _isConnected = false;
  bool get isConnected => _isConnected;

  ConnectivityProvider() {
    Connectivity connectivity = Connectivity();
    connectivity.onConnectivityChanged.listen((state) {
      if (state == ConnectivityResult.none) {
        _isConnected = false;
        notifyListeners();
      } else {
        _isConnected = true;
        notifyListeners();
      }
    });
  }
}
