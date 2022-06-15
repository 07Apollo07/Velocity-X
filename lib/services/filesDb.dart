import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:velocityx/controllers/authController.dart';
import 'package:velocityx/controllers/userController.dart';
import 'package:velocityx/models/file_stats.dart';
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
      }).then((value) async {
        await CreateStarterStats(FileRef.id, file);
      });

      print("Adding File information in File Collection");
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> CreateStarterStats(String fileId, FilesModel file) async {
    try {
      List<dynamic> tracking = [
        {
          "Operation": "Creation",
          "By": file.creator_uid,
          "Time": Timestamp.now(),
        }
      ];
      if (file.assigned_person_uid[0] != "") {
        file.assigned_person_uid.forEach((newId) async {
          print("adding to tracking");
          tracking.add({
            "Operation": "Transfer",
            "From": file.creator_uid,
            "To": newId,
            "Time": Timestamp.now(),
          });
        });
      }
      if (file.final_approver != "No Final Approver") {
        tracking.add({
          "Operation": "Added",
          "From": file.creator_uid,
          "To": file.final_approver,
          "Time": Timestamp.now(),
        });
      }
      print("makig Subcollection");
      _firestore
          .collection("Files")
          .doc(fileId)
          .collection("File_Stats")
          .doc("Stats")
          .set({
        "tracking": tracking,
        "fileLastOpenedDateTime": Timestamp.now(),
        "fileModifiedDateTime": Timestamp.now(),
      });
      print("Added COllection ");
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<FileStatsModel> GetStats(String fileId) async {
    try {
      FileStatsModel _fileStat = FileStatsModel();
      await _firestore
          .collection("Files")
          .doc(fileId)
          .collection("File_Stats")
          .doc("Stats")
          .get()
          .then(
        (DocumentSnapshot doc) {
          _fileStat =
              FileStatsModel.fromDocumentSnapshot(documentSnapshot: doc);
          print(_fileStat.fileModifiedDateTime);
          print(_fileStat.fileLastOpenedDateTime);
          // print(_fileStat.file_transfers);
          print(_fileStat.tracking);
        },
      );
      return _fileStat;
    } catch (e) {
      print(e.toString());
      return FileStatsModel();
    }
  }

  Future<bool> UpdateFile(String fileId, FilesModel file) async {
    try {
      await _firestore.collection("Files").doc(fileId).update({
        "final_approver": file.final_approver,
        "name": file.name,
        "storage_link": file.storage_link,
        "assigned_person_uid": file.assigned_person_uid,
        "download": file.download,
        "final_approver_set": file.final_approver_set
      }).then((value) => print("File Updated"));
      print("Updating File information in File Collection");
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> UpdateTransferStats(FilesModel file,
      List<String> newAssignedList, bool RemoveYourself) async {
    try {
      bool Remove = RemoveYourself;
      int length = newAssignedList.length;
      int CurrentCount = 0;
      newAssignedList.forEach((newId) async {
        CurrentCount = CurrentCount + 1;
        print("adding to tracking");
        List<Map> tracking = ([
          {
            "Operation": "Transfer",
            "From": Get.find<UserController>().user.id,
            "To": newId,
            "Time": Timestamp.now(),
          }
        ]);
        if (CurrentCount == length && Remove == true) {
          tracking.add({
            "Operation": "RemoveSelf",
            "User": Get.find<UserController>().user.id,
            "Time": Timestamp.now(),
          });
          Remove = false;
        }
        print(tracking);
        await _firestore
            .collection("Files")
            .doc(file.files_uniqueId)
            .collection("File_Stats")
            .doc("Stats")
            .update({
          "tracking": FieldValue.arrayUnion(tracking),
        });
      });

      print("Update Sicessful");
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> UpdateOpenedStats(String fileId, String uid) async {
    try {
      List<dynamic> tracking = [
        {
          "Operation": "Opened",
          "User": uid,
          "Time": Timestamp.now(),
        }
      ];
      await _firestore
          .collection("Files")
          .doc(fileId)
          .collection("File_Stats")
          .doc("Stats")
          .update({
        "tracking": FieldValue.arrayUnion(tracking),
      });
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> ForwardFile(
      String fileId,
      FilesModel file,
      List<String> newAssignedList,
      FilesModel FullFile,
      bool RemoveYourself) async {
    try {
      await _firestore.collection("Files").doc(fileId).update({
        "assigned_person_uid": file.assigned_person_uid,
      }).then((value) =>
          UpdateTransferStats(FullFile, newAssignedList, RemoveYourself));
      print("Updating File information in File Collection");
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> DeleteFile(String fileId) async {
    try {
      await _firestore
          .collection("Files")
          .doc(fileId)
          .collection("File_Stats")
          .doc("Stats")
          .delete()
          .then((value) async => await _firestore
              .collection("Files")
              .doc(fileId)
              .delete()
              .then((value) =>
                  print("Delete File information in File Collection")));
      print("Delete File information in File Collection");

      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
