import 'package:get/get.dart';
import 'package:velocityx/controllers/authController.dart';
import 'package:velocityx/controllers/userController.dart';
import 'package:velocityx/controllers/wrapperController.dart';

class StoreBindings extends Bindings {
  @override
  void dependencies() {
    // Get.put<AuthController>(AuthController(), permanent: true);
    Get.lazyPut<UserController>(() => UserController());
    Get.put<WrapperController>(WrapperController(), permanent: true);
  }
}
