import 'package:cloud_firestore/cloud_firestore.dart';

class UserFilesModel {
  late List<String?>? assigned_files;
  late List<String?>? created_files;

  UserFilesModel({
    this.assigned_files,
    this.created_files,
  });

  UserFilesModel.fromDocumentSnapshot({DocumentSnapshot? documentSnapshot}) {
    assigned_files = documentSnapshot!["Assigned_files"];
    created_files = documentSnapshot!["Created_files"];
  }
}
