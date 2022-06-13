import 'package:get/get.dart';
import 'package:velocityx/controllers/authController.dart';
import 'package:velocityx/controllers/docCreationController.dart';
import 'package:velocityx/controllers/filesController.dart';
import 'package:velocityx/controllers/metaDataController.dart';
import 'package:velocityx/controllers/scannerController.dart';
import 'package:velocityx/controllers/userController.dart';
import 'package:velocityx/controllers/wrapperController.dart';

class StoreBindings extends Bindings {
  @override
  void dependencies() {
    // Get.put<AuthController>(AuthController(), permanent: true);
    Get.lazyPut<UserController>(() => UserController());
    Get.lazyPut<FilesController>(() => FilesController());
    Get.put<WrapperController>(WrapperController(), permanent: true);
    Get.put<ScannerV2Controller>(ScannerV2Controller());
    Get.put<MetaDataController>(MetaDataController());
  }
}
