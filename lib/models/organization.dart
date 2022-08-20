import 'package:cloud_firestore/cloud_firestore.dart';

class OrganizationModel {
  late String? uid;
  late String address = "Not Set";
  late Timestamp? creation_datetime;
  late String orgName = "Not Set";
  late List<dynamic>? admins_uid = [];

  OrganizationModel(
      {this.uid,
      this.address = "Not Set",
      this.creation_datetime,
      this.orgName = "Not Set",
      this.admins_uid});

  OrganizationModel.fromDocumentSnapshot({DocumentSnapshot? documentSnapshot}) {
    uid = documentSnapshot!["Uid"];
    address = documentSnapshot["address"];
    creation_datetime = documentSnapshot["creation_datetime"];
    orgName = documentSnapshot["orgName"];
    admins_uid = documentSnapshot["admin_uid"];
  }
}
