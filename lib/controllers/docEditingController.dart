import 'package:ai_barcode/ai_barcode.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocityx/controllers/authController.dart';
import 'package:velocityx/controllers/userController.dart';
import 'package:velocityx/models/files.dart';
import 'package:velocityx/models/user.dart';
import 'package:velocityx/services/filesDb.dart';

class DocEditingController extends GetxController {
  CreatorController? creatorController;
  bool initialized = false;
  TextEditingController documentNameController = TextEditingController();
  TextEditingController assignedPersonNameController = TextEditingController();
  TextEditingController finalApproverController = TextEditingController();

  var downloadDocument = false;
  var finalApprover = false;

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

  void initializeAssignedList(String uid) {
    if (userList.length > 0) {
      print(uid.trim());
      print("there are items in userList");
      for (var user in userList) {
        print(user.id);
        if (user.id == uid.trim()) {
          print("eligible to go in");
          assignedList.add(user);
          assignedIdList.add(user.id);
          update();
          print(user);
        }
      }
    }
  }

  void setFinalApproverFromId(String id) {
    if (userList.length > 0) {
      for (var user in userList) {
        if (user.id == id.trim()) {
          setFinalApprover(user.email ?? "Email Not Set");
          update();
        }
      }
    }
  }

  void setFinalApprover(String email) async {
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

  void addToAssignedList(String email) async {
    print("reached here to add");
    if (userList.length > 0) {
      print(email.trim());
      print("there are items in userList");
      for (var user in userList) {
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

  void removePersonFromAssignedPerson(String email) {
    if (assignedList.length > 0) {
      for (var user in assignedList) {
        if (user.email == email.trim()) {
          assignedList.remove(user);
          assignedIdList.remove(user.email);
          update();
        } else {
          print("Cant Remove");
        }
      }
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

  @override
  void onInit() {
    super.onInit();
    creatorController = CreatorController();
  }

  @override
  void dispose() {
    super.dispose();
    creatorController = null;
  }

  void updateDocument(
      String fileId,
      String docName,
      List<String?> assignedPerson,
      bool download,
      bool finalApprover,
      List<String?> finalApproverNameId) async {
    FilesModel _file = FilesModel(
      name: docName,
      assigned_person_uid: assignedPerson,
      download: download,
      final_approver_set: finalApprover,
      final_approver: finalApproverNameId.last ?? "Not Final Approver",
      storage_link: "",
    );

    if (await FilesDb().UpdateFile(fileId, _file)) {
      update();
      Get.snackbar("Success", "File Updated");
    }
    print(_file.toString());
  }
}
