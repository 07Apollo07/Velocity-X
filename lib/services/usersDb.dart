import 'package:cloud_firestore/cloud_firestore.dart';

class UserDb{
  final CollectionReference userCollection = FirebaseFirestore.instance.collection("Users");


  Future<List> getAllUsers() async{

    QuerySnapshot querySnapshot =await userCollection.get() as QuerySnapshot<Object?>;
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    return allData;
  }

  Future<List> getUsersByOrganizationNo(String organizationNo) async{

    QuerySnapshot querySnapshot =await userCollection.where("organization_no", isEqualTo: organizationNo).get() as QuerySnapshot<Object?>;
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    return allData;
  }

  Future<List> getUser(String docID) async{

    QuerySnapshot querySnapshot =await userCollection.doc(docID).get() as QuerySnapshot<Object?>;
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    // for (var snapshot in querySnapshot.docs) {
    //   var documentID = snapshot.id;
    //   print(documentID.runtimeType);// <-- Document ID
    // }

    return allData;
  }




}