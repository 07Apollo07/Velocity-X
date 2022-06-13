import 'package:ai_barcode/ai_barcode.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScannerV2Controller extends GetxController {
  String Code = "";
  String qrResult = 'Scanned data will appear here!';

  void setCode(String code) {
    Code = code;
    update();
  }

  void setResult(String code) {
    qrResult = code;
    update();
  }
}
