import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:velocityx/models/user.dart';

class UserDb {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("Users");

  Future<bool> createNewUser(UserModel user) async {
    try {
      await _firestore.collection("Users").doc(user.id).set({
        "id": user.id,
        "f_name": user.f_name,
        "l_name": user.l_name,
        "phone": user.phone,
        "email": user.email,
        "organization_emp_no": user.organization_emp_no,
        "organization_no": user.organization_no,
        "designation": user.designation,
        "joining_date": user.joining_date,
      });
      print("Adding Data to Database");
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<List> getAllUsers() async {
    QuerySnapshot querySnapshot =
        await userCollection.get() as QuerySnapshot<Object?>;
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    return allData;
  }

  Future<List> getUsersByOrganizationNo(String organizationNo) async {
    QuerySnapshot querySnapshot = await userCollection
        .where("organization_no", isEqualTo: organizationNo)
        .get() as QuerySnapshot<Object?>;
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    return allData;
  }

  Future<UserModel> getUser(String docID) async {
    // QuerySnapshot querySnapshot =
    //     await userCollection.doc(docID).get() as QuerySnapshot<Object?>;
    // final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    // for (var snapshot in querySnapshot.docs) {
    //   var documentID = snapshot.id;
    //   print(documentID.runtimeType);// <-- Document ID
    // }
    try {
      DocumentSnapshot _doc =
          await _firestore.collection("users").doc(docID).get();

      return UserModel.fromDocumentSnapshot(documentSnapshot: _doc);
    } catch (e) {
      print(e);
      rethrow;
    }

    // return allData;
  }
}
