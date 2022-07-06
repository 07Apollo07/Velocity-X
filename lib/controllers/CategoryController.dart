import 'package:get/get.dart';
import 'package:velocityx/models/files.dart';

class CategoryController extends GetxController {
  final List<dynamic> Ids;
  CategoryController(this.Ids);

  Rx<List<dynamic>> categoryFilesIds =
      Rx<List<dynamic>>(List.empty(growable: true));
  Rx<List<FilesModel>> categoryFilesList =
      Rx<List<FilesModel>>(List.empty(growable: true));

  List<FilesModel> get categoryFiles => categoryFilesList.value;
  List<dynamic> get categoryFilesId => categoryFilesIds.value;

  @override
  void onInit() {
    super.onInit();
  }
}
