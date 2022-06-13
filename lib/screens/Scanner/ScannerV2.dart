import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocityx/controllers/scannerController.dart';
import 'package:velocityx/screens/Scanner/app_barcode_scanner_widget.dart';

///
/// FullScreenScannerPage

class ScannerV2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ScannerV2Controller>(
        init: Get.find<ScannerV2Controller>(),
        builder: (controller) {
          if (controller != null) {
            return Scaffold(
              appBar: AppBar(
                leading: BackButton(),
                title: Text(controller.Code),
              ),
              body: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(controller.Code),
                    ],
                  ),
                  Expanded(
                    child: AppBarcodeScannerWidget.defaultStyle(
                      resultCallback: (String code) {
                        controller.setCode(code);
                        controller.setResult(code);
                        print(controller.Code);
                        Get.back();
                      },
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
