import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:velocityx/models/user.dart';
import 'package:velocityx/models/user_categories.dart';

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
        "organization_emp_id": user.organization_emp_id,
        "organization_no": user.organization_no,
        "designation": user.designation,
        "joining_date": user.joining_date as Timestamp,
      });
      print("Adding User information in User Collection");
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

  Stream<UserModel> userStream(String uid) {
    print("Accessing Current Signed in user Stream");
    return _firestore
        .collection("Users")
        .doc(uid)
        .snapshots()
        .map((DocumentSnapshot query) {
      return UserModel.fromDocumentSnapshot(documentSnapshot: query);
    });
  }

  Stream<List<CategoryModel>> userCategoryStream(String uid) {
    print("Accessing Current Signed in user category Stream");
    return _firestore
        .collection("Users")
        .doc(uid)
        .collection("Categories")
        .doc("Categories")
        .snapshots()
        .map((DocumentSnapshot query) {
      List<CategoryModel> retVal = List.empty(growable: true);
      UserCategoryModel userCategoryModel =
          UserCategoryModel.fromDocumentSnapshot(documentSnapshot: query);
      userCategoryModel.category?.forEach((element) {
        print(element.toString());
        retVal.add(CategoryModel(name: element["name"], ids: element["ids"]));
      });
      return retVal;
    });
  }

  Stream<List<UserModel>> userListStream(String organizationNo) {
    print("Accessing UserList Stream in UserDb");
    return _firestore
        .collection("Users")
        //TODO change array Contains value to logged in users's Uid
        .where('organization_no', isEqualTo: organizationNo)
        // .orderBy("name", descending: true)
        .snapshots()
        .map((QuerySnapshot query) {
      print(query.docs);
      List<UserModel> retVal = List.empty(growable: true);
      query.docs.forEach((element) {
        print(element.data());
        retVal.add(UserModel.fromDocumentSnapshot(documentSnapshot: element));
      });
      return retVal;
    });
  }
}
