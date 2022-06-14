import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:velocityx/models/file_stats.dart';

class FileInformationController extends GetxController {
  late FileStatsModel FilesModel;
  bool initialized = false;
  late Timestamp? fileLastOpenedDateTime;
  late Timestamp? fileModifiedDateTime;
  late List<dynamic>? tracking = [];
  // late List<dynamic>? NewTracking = [];

  void initializeFilesModel(FileStatsModel FileModel) {
    print("here");
    FilesModel = FileModel;
    getFileLastOpenedDateTime();
    getFileModifiedDateTime();
    getTracking();
  }

  void getFileLastOpenedDateTime() {
    fileLastOpenedDateTime = FilesModel.fileLastOpenedDateTime;
    print("got opening date");
  }

  void getFileModifiedDateTime() {
    fileModifiedDateTime = FilesModel.fileModifiedDateTime;
    print("got Modified Time");
  }

  void getTracking() {
    print("mapping");
    tracking = FilesModel.tracking;
  }

  @override
  void onInit() {
    super.onInit();
    initialized = false;
  }
}
