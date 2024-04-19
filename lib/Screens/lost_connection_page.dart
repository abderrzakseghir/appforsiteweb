import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controller/network_controller.dart';

class NoConnectionPage extends StatefulWidget {
  const NoConnectionPage({super.key});

  @override
  State<NoConnectionPage> createState() => _NoConnectionPageState();
}

class _NoConnectionPageState extends State<NoConnectionPage> {
  NetworkController controller = Get.find();
  late ConnectivityResult connectivityResult;

  bool _showButton =
      true; // Pour afficher le bouton Refresh ou le CircularProgressIndicator
  bool _showProgress =
      false; // Pour afficher ou masquer le CircularProgressIndicator

  void _showProgressIndicator() {
    setState(() {
      _showButton = false; // Cacher le bouton Refresh
      _showProgress = true; // Afficher le CircularProgressIndicator
    });

    Timer(Duration(seconds: 5), () {
      setState(() {
        _showButton =
            true; // Afficher à nouveau le bouton Refresh après 5 secondes
        _showProgress =
            false; // Cacher le CircularProgressIndicator après 5 secondes
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            _showButton
                ? IconButton(
                    icon: Icon(Icons.refresh),
                    onPressed: () {
                      // Lorsque l'utilisateur appuie sur le bouton, afficher le CircularProgressIndicator pendant 5 secondes
                      _showProgressIndicator();
                      // Ensuite, appeler la fonction checkConnection()
                      controller.checkConnection();
                      print('appyer sur refresh');
                    },
                  )
                : SizedBox(), // Afficher un SizedBox() si _showButton est faux
            _showProgress
                ? CircularProgressIndicator()
                : SizedBox(), // Afficher le CircularProgressIndicator si _showProgress est vrai
            const SizedBox(height: 10), // Espacement entre les éléments
            const Text(
              'Veuillez vérifier votre connexion Internet',
              style: TextStyle(color: Colors.red),
            ),
          ]),
        ),
      ),
    );
  }
}
/*
* git remote add origin https://github.com/abderrzakseghir/ipa_testing.git
git branch -M main
git push -u origin main
*
*
*
*
*
* */
