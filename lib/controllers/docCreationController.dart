import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocityx/controllers/authController.dart';
import 'package:velocityx/controllers/userController.dart';
import 'package:velocityx/models/files.dart';
import 'package:velocityx/models/user.dart';
import 'package:velocityx/services/filesDb.dart';

class DocCreationController extends GetxController {
  var downloadDocument = false;
  var finalApprover = false;

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

  void setFinalApprover(String email) async {
    print("reached here to add");
    List<UserModel> _userList = Get.find<UserController>().users;
    if (_userList.length > 0) {
      print(email.trim());
      print("there are items in userList");
      for (var user in _userList) {
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

  void addToAssignedList(String email) async {
    print("reached here to add");
    List<UserModel> _userList = Get.find<UserController>().users;
    if (_userList.length > 0) {
      print(email.trim());
      print("there are items in userList");
      for (var user in _userList) {
        print(user.email);
        if (user.email == email.trim()) {
          print("eligible to go in");
          // assignedList.addIf(assignedList.any((element) {
          //   if (element.email == email.trim()) {
          //     return false;
          //   } else
          //     return true;
          // }), user);
          //TODO Duplicate Users can be added here;
          assignedList.add(user);
          assignedIdList.add(user.id);
          update();
          print(user);
        }
      }
    } else
      (Get.snackbar("title", "userList empty"));
    print(assignedList.toString());
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

  void createDocument(
      String docName,
      List<String?> assignedPerson,
      bool download,
      bool finalApprover,
      List<String?> finalApproverNameId) async {
    UserModel _user = Get.find<UserController>().user;
    FilesModel _file = FilesModel(
      name: docName,
      assigned_person_uid: assignedPerson,
      creation_datetime: Timestamp.fromDate(DateTime.now()),
      creator_name: _user.f_name + " " + _user.l_name,
      creator_uid: Get.find<AuthController>().user!.uid,
      designation: _user.designation,
      download: download,
      final_approver_set: finalApprover,
      final_approver: finalApproverNameId.last ?? "Not Final Approver",
      organization_no: _user.organization_no,
      storage_link: "",
      files_uniqueId: docName +
          "_" +
          Timestamp.fromDate(DateTime.now()).toString() +
          "_" +
          _user.organization_no,
    );

    if (await FilesDb().createNewFile(_file)) {
      finApproverList.clear();
      finApproverIdList.clear();
      assignedList.clear();
      assignedIdList.clear();
      update();
      Get.snackbar("Success", "File Created");
    }
    print(_file.toString());
  }
}
