import 'package:cloud_firestore/cloud_firestore.dart';

class FileStatsModel{
  late String? fileLastOpenedDateTime;
  late String? fileModifiedDateTime;
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