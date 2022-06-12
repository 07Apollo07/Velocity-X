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

  Future<bool> createNewFile(FilesModel file) async {
    try {
      final FileRef = _firestore.collection("Files").doc();
      await FileRef.set({
        "creator_uid": file.creator_uid,
        "designation": file.designation,
        "creation_datetime": file.creation_datetime,
        "files_uniqueId": FileRef.id,
        "final_approver": file.final_approver,
        "name": file.name,
        "organization_no": file.organization_no,
        "storage_link": file.storage_link,
        "assigned_person_uid": file.assigned_person_uid,
        "creator_name": file.creator_name,
        "download": file.download,
        "final_approver_set": file.final_approver_set
      });
      print("Adding File information in File Collection");
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> UpdateFile(String fileId, FilesModel file) async {
    try {
      final FileRef = _firestore.collection("Files").doc(fileId);
      await FileRef.update({
        "final_approver": file.final_approver,
        "name": file.name,
        "storage_link": file.storage_link,
        "assigned_person_uid": file.assigned_person_uid,
        "download": file.download,
        "final_approver_set": file.final_approver_set
      });
      print("Updating File information in File Collection");
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
