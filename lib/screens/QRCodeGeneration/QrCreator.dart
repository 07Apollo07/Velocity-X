import 'package:flutter/material.dart';
import 'package:ai_barcode/ai_barcode.dart';
import 'package:get/get.dart';
import 'package:velocityx/controllers/QrController.dart';

///
/// CreatorPage
/// 生成：二维码

class QrCreator extends GetWidget<QrController> {
  final qrCodeOfInput;
  const QrCreator({Key? key, required this.qrCodeOfInput}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QrController>(
        init: Get.put<QrController>(QrController()),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Qr Code"),
            ),
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 10,
                  ),
                  Column(
                    children: <Widget>[
                      //TODO Remove this
                      Text("$qrCodeOfInput"),
                      Container(
                        width: 300,
                        height: 300,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Colors.blue,
                              width: 15,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                        margin: EdgeInsets.all(40),
                        child: PlatformAiBarcodeCreatorWidget(
                          creatorController: controller.creatorController!,
                          initialValue: "$qrCodeOfInput",
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
