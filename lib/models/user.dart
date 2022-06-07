import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  late String? id;
  late String f_name = "Default";
  late String l_name = "Default";
  int phone = 0000000000;
  late String? email = "null@null.com";
  String organization_emp_no = "No Organization";
  String organization_no = "00";
  String designation = "No Designation";
  String joining_date = "No Joining Date";

  UserModel(
      {this.id,
      this.f_name = "Default",
      this.l_name = "Default",
      int phone = 0000000000,
      this.email,
      String organization_emp_no = "No Organization",
      String organization_no = "00",
      String designation = "No Designation",
      String joining_date = "No Joining Date"}); // UserModel();

  UserModel.fromDocumentSnapshot({DocumentSnapshot? documentSnapshot}) {
    id = documentSnapshot!.id;
    f_name = documentSnapshot["f_name"];
    l_name = documentSnapshot["l_name"];
    phone = documentSnapshot["phone"];
    email = documentSnapshot["email"];
    organization_emp_no = documentSnapshot["organization_emp_no"];
    organization_no = documentSnapshot["organization_no"];
    designation = documentSnapshot["designation"];
    joining_date = documentSnapshot["joining_date"];
  }
}
