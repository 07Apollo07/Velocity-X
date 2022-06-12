import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  late String? id;
  late String f_name = "Default";
  late String l_name = "Default";
  int phone = 0000000000;
  late String? email = "Email Not Set";
  String organization_emp_id = "No Organization";
  String organization_no = "00";
  String designation = "No Designation";
  late Timestamp? joining_date;

  UserModel(
      {this.id,
      this.f_name = "Default",
      this.l_name = "Default",
      this.phone = 0000000000,
      this.email,
      this.organization_emp_id = "No Organization",
      this.organization_no = "00",
      this.designation = "No Designation",
      this.joining_date}); // UserModel();

  UserModel.fromDocumentSnapshot({DocumentSnapshot? documentSnapshot}) {
    id = documentSnapshot!.id;
    f_name = documentSnapshot["f_name"];
    l_name = documentSnapshot["l_name"];
    phone = documentSnapshot["phone"];
    email = documentSnapshot["email"];
    organization_emp_id = documentSnapshot["organization_emp_id"];
    organization_no = documentSnapshot["organization_no"];
    designation = documentSnapshot["designation"];
    joining_date = documentSnapshot["joining_date"] as Timestamp;
  }
}
