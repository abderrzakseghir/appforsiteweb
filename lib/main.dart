import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'Screens/lost_connection_page.dart';
import 'Screens/web_view_page.dart';
import 'controller/network_controller.dart';
import 'dependancy_injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Pour éviter les erreurs liées à l'initialisation de plugins avant l'appel de `runApp()`
  DependencyInjection
      .init(); // Initialisez les dépendances avant de lancer l'application
  runApp(MyApp());
  ConnectivityResult connectivityResult;
}

class MyApp extends StatelessWidget {
  MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Obx(() {
            // Utilisation de l'Obx pour observer l'état de la connectivité
            final networkController = Get.find<NetworkController>();
            if (networkController.hasConnection.value) {
              // Si la connexion est présente, j'affiche la WebViewPage
              networkController.checkConnection();
              if (Get.isSnackbarOpen) {
                Get.closeCurrentSnackbar();
                print('LE SNACK IL A ETE FERME DEPUIS LE MAIN');
              }
              return WebViewPage();
            } else {
              // Si la connexion est absente, j'affiche la page d'erreur
              return NoConnectionPage();
            }
          }),
        ),
      ),
    );
  }
}
