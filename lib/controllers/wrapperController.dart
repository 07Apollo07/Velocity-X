import 'package:get/get.dart';

class WrapperController extends GetxController {
  var tabIndex = 0;
  var floatingActive = false;
  void changeTabIndex(int index) {
    tabIndex = index;
    update();
  }

  void changeFloatingActive(bool Active) {
    floatingActive = Active;
    update();
  }
}
