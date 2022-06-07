import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MetaDataController extends GetxController {
  // Rx<FilesModel> file = Rx<FilesModel>(FilesModel());
  // String fileId = " ";

  String getDateFromTimeStamp(String timestamp) {
    int time = int.parse(timestamp);
    DateTime date = DateTime.fromMillisecondsSinceEpoch(time * 1000);
    String formattedDate = DateFormat('M/d/y -- E -- HH:mm:ss a ').format(date);
    return formattedDate;
  }
}
