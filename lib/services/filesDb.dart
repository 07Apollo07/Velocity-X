import 'package:cloud_firestore/cloud_firestore.dart';

class FilesDb{
  final CollectionReference userCollection = FirebaseFirestore.instance.collection("Files");


  Future<List> getAllFiles() async{

    QuerySnapshot querySnapshot =await userCollection.get() as QuerySnapshot<Object?>;
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    return allData;
  }

  Future<List> getAllFilesOrganizationNoWise(String organizationNo) async{

    QuerySnapshot querySnapshot =await userCollection.where("organization_no", isEqualTo: organizationNo).get() as QuerySnapshot<Object?>;
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    return allData;
  }

  Future<List> getAllFilesCreatorWise(String creatorUID) async{

    QuerySnapshot querySnapshot =await userCollection.where("creator_uid", isEqualTo: creatorUID).get() as QuerySnapshot<Object?>;
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    return allData;
  }




}