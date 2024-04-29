import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../controller/network_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class WebViewPage extends StatefulWidget {
  const WebViewPage({Key? key}) : super(key: key);

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  bool _isLoading = true;
  final _key = UniqueKey(); // Permet de forcer le rechargement du WebView
  late WebViewController _webViewController;
  NetworkController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            WillPopScope(
              onWillPop: () async {
                if (await _webViewController.canGoBack()) {
                  _webViewController.goBack();
                  print('going back from retour');
                  return false;
                } else {
                  print('CANNOT go back from retour');
                  return true;
                }
              },
              child: WebView(
                  zoomEnabled: false,
                  key: _key,
                  initialUrl: 'https://comiteplus.fr/bienvenue/',
                  javascriptMode: JavascriptMode.unrestricted,
                  onPageFinished: (_) {
                    if (mounted) {
                      controller.setIsLoading(false);

                      setState(() {
                        _isLoading = false;
                      });
                    }
                    ;
                  },
                  onPageStarted: (_) {
                    if (mounted) {
                      controller.setIsLoading(true);
                      setState(() {
                        if (Get.isSnackbarOpen) {
                          Get.closeCurrentSnackbar();
                          print(
                              'LE SNACK IL A ETE FERME DEPUIS LE WEB VIEW----------------');
                        }

                        _isLoading = true;
                      });
                    }
                    ;
                  },
                  onWebResourceError: (error) {
                    if (mounted) {
                      controller.setIsLoading(false);
                      setState(() {
                        _isLoading = false;
                      });
                      // Afficher un message d'erreur en cas d'échec de chargement
                      // Vous pouvez également gérer d'autres types d'erreurs ici
                      showDialog(
                          context: context,
                          builder: (_) {
                            if (Navigator.canPop(context)) {
                              Navigator.pop(context);
                            }
                            return AlertDialog(
                              title: Text('Erreur de chargement'),
                              content: Text('Impossible de charger l'
                                  'application, Fermez l'
                                  'application et reouvrez la.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          });
                    }
                  },
                  navigationDelegate: (NavigationRequest request) {
                    if (request.url.startsWith('tel:')) {
                      launch(request.url);
                      print(
                          'cest ca  ce qui a ete lancheeeeeeeeeeeeeer ${request.url}');
                      return NavigationDecision.prevent;
                    }
                    return NavigationDecision.navigate;
                  },
                  onWebViewCreated: (controller) {
                    _webViewController = controller;
                    print('-----------------------------------------');

//                     _webViewController.runJavascriptReturningResult("""
//   var elements = document.getElementsByClassName('menu-link');
//   for(var i=0; i < elements.length; i++) {
//     elements[i].addEventListener('click', function(event) {
//       // Empêcher le comportement par défaut de l'hyperlien
//       event.preventDefault();
//       // Récupérer le numéro de téléphone à partir du lien href
//       var phoneNumber = this.getAttribute('href').replace('tel:', '');
//       // Appeler la méthode Flutter pour ouvrir l'application téléphonique avec le numéro de téléphone
//       window.flutter_inappwebview.callHandler('openPhoneApp', phoneNumber);
//     });
//   }
// """);
                  }),
            ),
            if (_isLoading) Center(child: CircularProgressIndicator())
          ],
        ),
      ),
    );
  }
}
