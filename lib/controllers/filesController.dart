import 'package:get/get.dart';
import 'package:velocityx/controllers/authController.dart';
import 'package:velocityx/models/files.dart';
import 'package:velocityx/services/filesDb.dart';

class FilesController extends GetxController {
  Rx<List<FilesModel>> assignedFilesList =
      Rx<List<FilesModel>>(List.empty(growable: true));
  Rx<List<FilesModel>> createdFilesList =
      Rx<List<FilesModel>>(List.empty(growable: true));

  List<FilesModel> get assignedFiles => assignedFilesList.value;
  List<FilesModel> get createdFiles => createdFilesList.value;

  @override
  void onInit() {
    String uid = Get.find<AuthController>().user!.uid;
    print("Accessing FilesStream on init");
    assignedFilesList.bindStream(
        FilesDb().assignedFilesStream(uid)); //stream coming from firebase
    createdFilesList.bindStream(FilesDb().createdFilesStream(uid));
  }
}
