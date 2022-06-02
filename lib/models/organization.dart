import 'package:cloud_firestore/cloud_firestore.dart';

class OrganizationModel{
    late String? uid ;
    late String? address;
    late String? creation_datetime;
    late String? orgName;
    late List<String?>? admins_uid;


    OrganizationModel({
      this.uid,
      this.address,
      this.creation_datetime,
      this.orgName,
      this.admins_uid
    });

    OrganizationModel.fromDocumentSnapshot({DocumentSnapshot? documentSnapshot}) {
      uid = documentSnapshot!["Uid"];
      address = documentSnapshot!["address"];
      creation_datetime = documentSnapshot["creation_datetime"];
      orgName = documentSnapshot["orgName"];
      admins_uid = documentSnapshot["admins_uid"];

    }
}