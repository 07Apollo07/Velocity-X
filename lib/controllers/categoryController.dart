import 'dart:io';

import 'package:get/get.dart';
import 'package:velocityx/controllers/filesController.dart';
import 'package:velocityx/models/files.dart';
import 'package:velocityx/models/user_categories.dart';

class CategoryController extends GetxController {
  bool initialized = false;
  Rx<List<dynamic>> categoryFilesIds =
      Rx<List<dynamic>>(List.empty(growable: true));
  Rx<List<FilesModel>> categoryFilesList =
      Rx<List<FilesModel>>(List.empty(growable: true));
  List<FilesModel> get categoryFiles => categoryFilesList.value;
  List<dynamic> get categoryFilesId => categoryFilesIds.value;

  List<FilesModel> _files = Get.find<FilesController>().assignedFiles;

  void changeInitialized(bool value) {
    print("initialization : ${value}");
    initialized = value;
    update();
  }

  void initialize(CategoryModel category) {
    if (category.ids!.length > 0) {
      categoryFilesIds.value = category.ids ?? [];
      getFileModelsFromIds(category.ids ?? []);
    }
  }

  void initializeCategoryFileList(String id) {
    if (_files.length > 0) {
      for (var file in _files) {
        if (file.files_uniqueId == id) {
          // print(id);
          categoryFilesList.value.add(file);
        }
      }
    }
  }

  void getFileModelsFromIds(List<dynamic> ids) {
    ids.forEach((id) {
      print(id);
      print(Get.find<FilesController>().assignedFiles.length);
      categoryFilesList.value.add(Get.find<FilesController>()
          .assignedFiles
          .firstWhere((file) => file.files_uniqueId == id));
    });
    print(categoryFilesId.length);
    print(categoryFiles.length);
  }
}
