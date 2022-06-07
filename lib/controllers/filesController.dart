import 'package:get/get.dart';
import 'package:velocityx/controllers/authController.dart';
import 'package:velocityx/models/files.dart';
import 'package:velocityx/services/filesDb.dart';

class FilesController extends GetxController {
  Rx<List<FilesModel>> filesList =
      Rx<List<FilesModel>>(List.empty(growable: true));

  List<FilesModel> get files => filesList.value;

  @override
  void onInit() {
    String uid = Get.find<AuthController>().user!.uid;
    print("Accessing FilesStream on init");
    filesList
        .bindStream(FilesDb().filesStream(uid)); //stream coming from firebase
  }
}
