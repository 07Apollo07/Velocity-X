import 'package:cloud_firestore/cloud_firestore.dart';

class FilesModel {
  late String creator_uid;
  late String designation;
  late Timestamp? creation_datetime;
  late String? files_uniqueId;
  late String? final_approver;
  late String name;
  late String? organization_no;
  late String? storage_link;
  late List<dynamic>? assigned_person_uid;

  FilesModel(
      {this.creator_uid = "No Uid",
      this.designation = "No Designation",
      this.creation_datetime,
      this.files_uniqueId,
      this.final_approver,
      this.name = "No Name",
      this.organization_no,
      this.storage_link,
      this.assigned_person_uid});

  FilesModel.fromDocumentSnapshot({DocumentSnapshot? documentSnapshot}) {
    creator_uid = documentSnapshot!["creator_uid"];
    designation = documentSnapshot["designation"];
    creation_datetime = documentSnapshot["creation_datetime"] as Timestamp;
    files_uniqueId = documentSnapshot["files_uniqueId"];
    final_approver = documentSnapshot["final_approver"];
    name = documentSnapshot["name"];
    organization_no = documentSnapshot["organization_no"];
    storage_link = documentSnapshot["storage_link"];
    assigned_person_uid = documentSnapshot["assigned_person_uid"];
  }
}
