import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:velocityx/models/files.dart';

class FilesDb {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("Files");

  Future<List> getAllFiles() async {
    QuerySnapshot querySnapshot =
        await userCollection.get() as QuerySnapshot<Object?>;
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    return allData;
  }

  Future<List> getAllFilesOrganizationNoWise(String organizationNo) async {
    QuerySnapshot querySnapshot = await userCollection
        .where("organization_no", isEqualTo: organizationNo)
        .get() as QuerySnapshot<Object?>;
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    return allData;
  }

  Future<List> getAllFilesCreatorWise(String creatorUID) async {
    QuerySnapshot querySnapshot = await userCollection
        .where("creator_uid", isEqualTo: creatorUID)
        .get() as QuerySnapshot<Object?>;
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    return allData;
  }

  Stream<List<FilesModel>> assignedFilesStream(String uid) {
    print("Accessing Files Stream method in FilesDb");
    return _firestore
        .collection("Files")
        //TODO change array Contains value to logged in users's Uid
        .where('assigned_person_uid', arrayContains: uid)
        // .orderBy("name", descending: true)
        .snapshots()
        .map((QuerySnapshot query) {
      print(query.docs);
      List<FilesModel> retVal = List.empty(growable: true);
      query.docs.forEach((element) {
        print(element.data());
        retVal.add(FilesModel.fromDocumentSnapshot(documentSnapshot: element));
      });
      return retVal;
    });
  }

  Stream<List<FilesModel>> createdFilesStream(String uid) {
    print("Accessing Files Stream method in FilesDb");
    return _firestore
        .collection("Files")
        //TODO change array Contains value to logged in users's Uid
        .where('creator_uid', isEqualTo: uid)
        // .orderBy("name", descending: true)
        .snapshots()
        .map((QuerySnapshot query) {
      print(query.docs);
      List<FilesModel> retVal = List.empty(growable: true);
      query.docs.forEach((element) {
        print(element.data());
        retVal.add(FilesModel.fromDocumentSnapshot(documentSnapshot: element));
      });
      return retVal;
    });
  }
}
