import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;
import 'package:velocityx/controllers/docCreationController.dart';

class WrapperController extends GetxController {
  bool isDarkMode = true;

  void toggleDarkMode() {
    print("trying to change");
    isDarkMode = !isDarkMode;
    if (isDarkMode) {
      Get.changeTheme(ThemeData.dark());
    } else {
      Get.changeTheme(ThemeData.light());
    }
    update();
  }

  var tabIndex = 0;
  var floatingActive = false;

  void changeTabIndex(int index) {
    tabIndex = index;
    print(tabIndex);
    if (Get.mediaQuery.size.width <= 800) {
      if (tabIndex == 2) {
        Get.delete<DocCreationController>();
      }
    } else {
      if (tabIndex == 3) {
        Get.delete<DocCreationController>();
      }
    }
    update();
  }

  void changeFloatingActive(bool Active) {
    floatingActive = Active;
    update();
  }
}
