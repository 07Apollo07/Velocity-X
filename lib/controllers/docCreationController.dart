import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocityx/controllers/authController.dart';
import 'package:velocityx/controllers/userController.dart';
import 'package:velocityx/models/files.dart';
import 'package:velocityx/models/user.dart';
import 'package:velocityx/services/filesDb.dart';
import 'package:file_picker/file_picker.dart';

class DocCreationController extends GetxController {
  var downloadDocument = false;
  var finalApprover = false;
  PlatformFile? pickedFile;
  bool isFilePicked = false;
  String storageLink = "";

  List<UserModel> userList = Get.find<UserController>().users;

  Rx<List<UserModel>> assignedUserList =
      Rx<List<UserModel>>(List.empty(growable: true));

  Rx<List<String?>> assignedUserIdList =
      Rx<List<String?>>(List.empty(growable: true));

  Rx<List<UserModel>> finalApproverList =
      Rx<List<UserModel>>(List.empty(growable: true));

  Rx<List<String?>> finalApproverIdList =
      Rx<List<String?>>(List.empty(growable: true));

  List<UserModel> get assignedList => assignedUserList.value;
  List<String?> get assignedIdList => assignedUserIdList.value;
  List<UserModel> get finApproverList => finalApproverList.value;
  List<String?> get finApproverIdList => finalApproverIdList.value;

  void updatePickedFile(var result) {
    if (pickedFile == null) {
      pickedFile = result.files.first;
      isFilePicked = true;
      update();
      Get.snackbar("Success", "File Picked");
    } else {
      Get.snackbar("Error", "File Already Picked, Remove the Selected File");
    }
  }

  void removePickedFile() {
    pickedFile = null;
    isFilePicked = false;
    update();
    Get.snackbar("Success", "File Removed");
  }

  void addToAssignedList(String creator_id, String email) {
    if (userList.length > 0) {
      UserModel _eligibleUser = userList.firstWhere(
        (user) => ((user.email == email) && (user.id != creator_id)),
        orElse: () {
          UserModel dummy = UserModel();
          return dummy;
        },
      );
      bool inAssignedList = assignedUserList.value
          .any((user) => (user.email == _eligibleUser.email));
      if (!inAssignedList && _eligibleUser.email != "Email Not Set") {
        assignedUserList.value.add(_eligibleUser);
        assignedUserIdList.value.add(_eligibleUser.id);
        update();
        print("Added to List");
      } else {
        Get.snackbar("Not Allowed", "You are Not allowed to add this User");
      }
    } else {
      (Get.snackbar("Empty List", "userList empty"));
    }
  }

  void removePersonFromAssignedPerson(String email) {
    if (assignedList.length > 0) {
      for (var user in assignedList) {
        if (user.email == email.trim()) {
          assignedUserList.value.remove(user);
          assignedUserIdList.value.remove(user.email);
          update();
        } else {
          print("Cant Remove");
        }
      }
    }
  }

  void setFinalApprover(String email) async {
    print("reached here to add");
    if (userList.length > 0) {
      print(email.trim());
      print("there are items in userList");
      for (var user in userList) {
        print(user.email);
        if (user.email == email.trim()) {
          print("eligible to go in");
          if (finApproverList.length > 0) {
            finApproverList.removeLast();
            finApproverList.add(user);
            finApproverIdList.removeLast();
            finApproverIdList.add(user.id);
          } else {
            finApproverList.add(user);
            finApproverIdList.add(user.id);
          }
          print("added");
          update();
          print(user);
        }
      }
    } else {
      (Get.snackbar("title", "userList empty"));
      print(finApproverList.toString());
    }
  }

  void removePersonFromFinalApprover(String email) {
    if (finApproverList.length > 0) {
      for (var user in finApproverList) {
        if (user.email == email.trim()) {
          finApproverList.remove(user);
          finApproverIdList.remove(user.email);
          update();
        }
      }
    }
  }

  void clear() {
    assignedUserList.value = [];
  }

  void changeDownloadDocumentCheck(bool value) {
    downloadDocument = value;
    update();
  }

  void changeFinalApproverCheck(bool value) {
    finalApprover = value;
    update();
  }

  Future<bool> createDocument(
      String docName,
      List<String?> assignedPerson,
      bool download,
      bool finalApprover,
      List<String?> finalApproverNameId,
      String StorageLink) async {
    UserModel _user = Get.find<UserController>().user;
    try {
      print("inside FileModel to create file");
      print("controller storagrLink is ${storageLink}");
      FilesModel _file = FilesModel(
        name: docName,
        assigned_person_uid: assignedPerson.length > 0 ? assignedPerson : [""],
        creation_datetime: Timestamp.fromDate(DateTime.now()),
        creator_name: _user.f_name + " " + _user.l_name,
        creator_uid: Get.find<AuthController>().user!.uid,
        designation: _user.designation,
        download: download,
        final_approver_set: finalApprover,
        final_approver: finalApproverNameId.length > 0
            ? finalApproverNameId.last ?? "No Final Approver"
            : "No Final Approver",
        organization_no: _user.organization_no,
        storage_link: StorageLink,
      );
      if (await FilesDb().createNewFile(_file)) {
        finApproverList.clear();
        finApproverIdList.clear();
        assignedList.clear();
        assignedIdList.clear();
        downloadDocument = false;
        finalApprover = false;
        pickedFile = null;
        isFilePicked = false;
        update();
        Get.snackbar("Success", "File Created");
      }
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<String> updateStorageLink() async {
    print("inside storage function in controller");
    UserModel _user = Get.find<UserController>().user;

    final path = "${_user.organization_no}/${pickedFile!.name}";
    final file = File(pickedFile!.path!);

    String StorageLink = await FilesDb().UploadFileInStorage(path, file);
    print("recieved storage link");
    storageLink = StorageLink;
    print(StorageLink);

    return StorageLink;

    // await FilesDb().UpdateStorageLinkInFile()
  }
}
