import 'package:cloud_firestore/cloud_firestore.dart';

class FilesModel {
  late String creator_uid;
  late String designation;
  late Timestamp? creation_datetime;
  late String files_uniqueId;
  late String final_approver;
  late String name;
  late String organization_no;
  late String storage_link;
  late List<dynamic> assigned_person_uid;
  late String creator_name;
  late bool download;
  late bool final_approver_set;
  late Timestamp? fileModifiedDateTime;

  FilesModel(
      {this.creator_uid = "Not Set",
      this.designation = "Not Set",
      this.creation_datetime,
      this.files_uniqueId = "Not Set",
      this.final_approver = "Not Set",
      this.name = "Not Set",
      this.organization_no = "Not Set",
      this.storage_link = "Not Set",
      this.assigned_person_uid = const [0],
      this.creator_name = "Not Set",
      this.download = false,
      this.final_approver_set = false,
      this.fileModifiedDateTime});

  FilesModel.fromDocumentSnapshot({DocumentSnapshot? documentSnapshot}) {
    creator_uid = documentSnapshot!.data().toString().contains("creator_uid")
        ? documentSnapshot["creator_uid"]
        : "Not Creator Uid";
    designation = documentSnapshot.data().toString().contains("designation")
        ? documentSnapshot["designation"]
        : "No Designation";
    creation_datetime =
        documentSnapshot.data().toString().contains("creation_datetime")
            ? documentSnapshot["creation_datetime"] as Timestamp
            : Timestamp(0, 0);
    files_uniqueId =
        documentSnapshot.data().toString().contains("files_uniqueId")
            ? documentSnapshot["files_uniqueId"]
            : "No File Unique ID";
    final_approver =
        documentSnapshot.data().toString().contains("final_approver")
            ? documentSnapshot["final_approver"]
            : "No Final Approver";
    name = documentSnapshot.data().toString().contains("name")
        ? documentSnapshot["name"]
        : "No Name";
    organization_no =
        documentSnapshot.data().toString().contains("organization_no")
            ? documentSnapshot["organization_no"]
            : "No Organization Name";
    storage_link = documentSnapshot.data().toString().contains("storage_link")
        ? documentSnapshot["storage_link"]
        : "No Storage Link";
    assigned_person_uid =
        documentSnapshot.data().toString().contains("assigned_person_uid")
            ? documentSnapshot["assigned_person_uid"]
            : "No Assigned Person Uid";
    creator_name = documentSnapshot.data().toString().contains("creator_name")
        ? documentSnapshot["creator_name"]
        : "No Creator Name";
    download = documentSnapshot.data().toString().contains("download")
        ? documentSnapshot["download"]
        : false;
    final_approver_set =
        documentSnapshot.data().toString().contains("final_approver_set")
            ? documentSnapshot["final_approver_set"]
            : false;
    fileModifiedDateTime =
        documentSnapshot.data().toString().contains("fileModifiedDateTime")
            ? documentSnapshot["creation_datetime"] as Timestamp
            : Timestamp(0, 0);
  }
}
