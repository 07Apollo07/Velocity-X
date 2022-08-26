import 'package:ai_barcode/ai_barcode.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScannerArchiverController extends GetxController {
  String DocCode = "";
  String ArchiverCode = "";
  String qrResult = 'Scanned data will appear here!';
  bool Scanned = false;

  void setDocCode(String code) {
    DocCode = code;
    // update();
  }

  void setArchiverCode(String code) {
    ArchiverCode = code;
    // update();
  }

  void setResult(String code) {
    qrResult = code;
    // update();
  }
}
