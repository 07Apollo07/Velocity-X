import 'package:ai_barcode/ai_barcode.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QrController extends GetxController {
  CreatorController? creatorController;
  TextEditingController? textEditingController;

  @override
  void onInit() {
    super.onInit();
    creatorController = CreatorController();
    textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    creatorController = null;
    textEditingController = null;
  }
}
