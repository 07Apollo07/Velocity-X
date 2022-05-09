import 'package:cloud_firestore/cloud_firestore.dart';

class OrganiztionDb{
  final CollectionReference userCollection = FirebaseFirestore.instance.collection("Organization");


  Future<List> getAllOrganizations() async{

    QuerySnapshot querySnapshot =await userCollection.get() as QuerySnapshot<Object?>;
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    return allData;
  }

  Future<List> getOrganizationByUID(String uid) async{

    QuerySnapshot querySnapshot =await userCollection.where("Uid", isEqualTo: uid).get() as QuerySnapshot<Object?>;
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    return allData;
  }

  Future<List> getOrganizationByName(String name) async{

    QuerySnapshot querySnapshot =await userCollection.where("orgName", isEqualTo: name).get() as QuerySnapshot<Object?>;
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    return allData;
  }




}