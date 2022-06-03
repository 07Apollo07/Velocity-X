import 'package:cloud_firestore/cloud_firestore.dart';

class FileStatsModel {
  late Timestamp? fileLastOpenedDateTime;
  late Timestamp? fileModifiedDateTime;
  // late List<String?>? admins_uid;

  FileStatsModel({
    this.fileLastOpenedDateTime,
    this.fileModifiedDateTime,
  });

  FileStatsModel.fromDocumentSnapshot({DocumentSnapshot? documentSnapshot}) {
    fileLastOpenedDateTime = documentSnapshot!["fileLastOpenedDateTime"];
    fileModifiedDateTime = documentSnapshot!["fileModifiedDateTime"];
  }
}
