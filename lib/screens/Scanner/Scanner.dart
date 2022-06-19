import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:velocityx/assets/custom_icons_icons.dart';
import 'package:velocityx/controllers/authController.dart';
import 'package:velocityx/controllers/scannerController.dart';
import 'package:velocityx/screens/Scanner/ScannerV2.dart';
import 'package:velocityx/screens/Scanner/qr_scan_page.dart';

class Scanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ScannerV2Controller>(
        init: Get.put<ScannerV2Controller>(ScannerV2Controller()),
        builder: (controller) {
          return SafeArea(
            child: Container(
              child: Scaffold(
                appBar: AppBar(
                  title: Text(
                    "QR Scanner",
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  elevation: 0.0,
                  actions: <Widget>[
                    Container(
                        margin: EdgeInsets.only(right: 15.0),
                        decoration: BoxDecoration(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context).primaryColor,
                                blurRadius: 5.0,
                              ),
                            ]),
                        child: IconButton(
                            onPressed: () {
                              // Navigator.pushNamed(context, '/MetaData');
                            },
                            icon: Icon(CustomIcons.search_1),
                            color: Theme.of(context).primaryColor)),
                    Container(
                      margin: EdgeInsets.only(right: 15.0),
                      decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context).primaryColor,
                              blurRadius: 5.0,
                            ),
                          ]),
                      child: IconButton(
                          onPressed: () {
                            AuthController.instance.signOut();
                          },
                          icon: Icon(CustomIcons.bell),
                          color: Theme.of(context).primaryColor),
                    ),
                  ],
                ),
                // backgroundColor: Color.fromRGBO(36, 36, 36, 1.0),
                body: Column(
                  children: [
                    // Text(controller.qrResult, style: TextStyle(color: Colors.white)),
                    ElevatedButton(
                        onPressed: () {
                          Get.to(() => ScannerV2());
                        },
                        child: Text("Scan Code")),
                    // ElevatedButton(
                    //     onPressed: () {
                    //       controller
                    //           .setResult("Scanned data will appear here!");
                    //     },
                    //     child: Text("Reset")),
                    Row(
                      // mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Container(
                            margin: EdgeInsets.all(15.0),
                            decoration: const BoxDecoration(
                                color: Color.fromRGBO(36, 36, 36, 1.0),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blue,
                                    blurRadius: 5.0,
                                  ),
                                ]),
                            child: IconButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ScanQRCode()));
                              },
                              icon: Icon(Icons.supervised_user_circle),
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Container(
                            margin: EdgeInsets.only(right: 15.0),
                            decoration: const BoxDecoration(
                                color: Color.fromRGBO(36, 36, 36, 1.0),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blue,
                                    blurRadius: 5.0,
                                  ),
                                ]),
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.note_alt),
                              color: Colors.blue,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Container(
                            margin: EdgeInsets.only(right: 15.0),
                            decoration: const BoxDecoration(
                                color: Color.fromRGBO(36, 36, 36, 1.0),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blue,
                                    blurRadius: 5.0,
                                  ),
                                ]),
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.notes_sharp),
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
