import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocityx/controllers/ScannerArchiverController.dart';
import 'package:velocityx/controllers/scannerController.dart';
import 'package:velocityx/models/files.dart';
import 'package:velocityx/screens/Scanner/ScannerLoad.dart';
import 'package:velocityx/screens/Scanner/app_barcode_scanner_widget.dart';
import 'package:velocityx/screens/metadata/meta_data.dart';
import 'package:velocityx/services/filesDb.dart';

///
/// FullScreenScannerPage

class ScannerArchiver extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ScannerArchiverController>(
        init: Get.find<ScannerArchiverController>(),
        builder: (controller) {
          if (controller != null) {
            return Scaffold(
              appBar: AppBar(
                leading: BackButton(),
                title: Text("Scan Archival and Document Code"),
              ),
              body: Column(
                children: [
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Text(controller.Code),
                  //   ],
                  // ),
                  Expanded(
                    child: AppBarcodeScannerWidget.defaultStyle(
                      resultCallback: (String code) async {
                        controller.setArchiverCode(code);
                        controller.setResult(code);
                        print(controller.ArchiverCode);
                        Get.off(ScannerLoad());
                      },
                      openManual: false,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
