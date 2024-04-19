import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();
  var hasConnection = true.obs;
  bool isLoading = true;
  void setIsLoading(bool value) {
    isLoading = value;
    print('value set: $value');
    update();
  }

  bool getIsLoadingValue() {
    print('value got : ${this.isLoading}}');
    return this.isLoading;
  }

  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen(updateConnectionStatus);
    checkConnection();
  }

  void updateConnectionStatus(ConnectivityResult connectivityResult) {
    if (connectivityResult == ConnectivityResult.none) {
      hasConnection(false);
      Get.rawSnackbar(
          messageText: const Text('Veuillez vérifier votre connexion Internet',
              style: TextStyle(color: Colors.white, fontSize: 14)),
          isDismissible: false,
          duration: const Duration(days: 1),
          backgroundColor: Colors.red[400]!,
          icon: const Icon(
            Icons.wifi_off,
            color: Colors.white,
            size: 35,
          ),
          margin: EdgeInsets.zero,
          snackStyle: SnackStyle.GROUNDED);
      print('opened opend opened opend opened opend opened opend');
    } else {
      hasConnection(true);

      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
        print('closed closed closed closed closed closed');
      }
    }
  }

  // Fonction pour vérifier la connexion au démarrage de l'application
  Future<void> checkConnection() async {
    var connectivityResult = await _connectivity.checkConnectivity();
    updateConnectionStatus(connectivityResult);
    print('44444444444444444444444444');
  }
}
