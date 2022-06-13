import 'dart:html';

import 'package:ai_barcode/ai_barcode.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:velocityx/controllers/userController.dart';
import 'package:velocityx/models/files.dart';
import 'package:velocityx/models/user.dart';
import 'package:velocityx/services/filesDb.dart';

class MetaDataController extends GetxController {
  bool initialized = false;
  bool removeYourself = false;
  CreatorController? creatorController;

  List<UserModel> userList = Get.find<UserController>().users;

  Rx<List<UserModel>> assignedUserList =
      Rx<List<UserModel>>(List.empty(growable: true));

  Rx<List<String?>> assignedUserIdList =
      Rx<List<String?>>(List.empty(growable: true));

  Rx<List<UserModel>> newUserList =
      Rx<List<UserModel>>(List.empty(growable: true));

  Rx<List<String?>> newUserIdList =
      Rx<List<String?>>(List.empty(growable: true));

  List<UserModel> get assignedList => assignedUserList.value;
  List<String?> get assignedIdList => assignedUserIdList.value;
  List<UserModel> get newList => newUserList.value;
  List<String?> get newIdList => newUserIdList.value;

  var isAssignedPressed = false.obs;

  String getDateFromTimeStamp(String timestamp) {
    int time = int.parse(timestamp);
    DateTime date = DateTime.fromMillisecondsSinceEpoch(time * 1000);
    String formattedDate = DateFormat('M/d/y -- E -- HH:mm:ss a ').format(date);
    return formattedDate;
  }

  void changeIsAssignedPressed() {
    isAssignedPressed.value = !isAssignedPressed.value;
    update();
  }

  void removeYourselfPresed() {
    removeYourself = !removeYourself;
    update();
  }

  void initializeAssignedList(String uid) {
    print("initializing Assigned List");
    if (userList.length > 0) {
      print(uid.trim());
      print("there are items in userList");
      for (var user in userList) {
        if (user.id == uid.trim()) {
          print("eligible to go in");
          assignedUserList.value.add(user);
          assignedUserIdList.value.add(user.id);
          update();
          print(user);
        }
      }
      print("initialization done");
    }
  }

  void addToNewList(String creator_id, String email) async {
    print("Adding to New List");
    if (userList.length > 0) {
      UserModel _eligibleUser = userList.firstWhere(
        (user) => ((user.email == email) && (user.id != creator_id)),
        orElse: () {
          UserModel dummy = UserModel();
          Get.snackbar("Fail", "Massive Fail");
          return dummy;
        },
      );
      bool inAssignedList = assignedUserList.value
          .any((user) => (user.email == _eligibleUser.email));
      bool inNewList =
          newUserList.value.any((user) => (user.email == _eligibleUser.email));

      if (!inAssignedList &&
          !inNewList &&
          _eligibleUser.email != "Email Not Set") {
        newUserList.value.add(_eligibleUser);
        newUserIdList.value.add(_eligibleUser.id);
        update();
        print("Added to List");
      } else {
        Get.snackbar("Failure", "Cant Add User");
      }
    } else
      (Get.snackbar("Empty List", "userList empty"));
  }

  void addToAssignedList(String email) async {
    print("reached here to add");
    if (userList.length > 0) {
      print("there are items in userList");
      UserModel _eligibleUser = userList.firstWhere(
        (user) => ((user.email == email)),
        orElse: () {
          UserModel dummy = UserModel();
          Get.snackbar("Fail", "Massive Fail");
          return dummy;
        },
      );
      bool duplicateUser =
          assignedList.any((user) => (user.email == _eligibleUser.email));
      if (!duplicateUser && _eligibleUser.email != "Email Not Set") {
        assignedUserList.value.add(_eligibleUser);
        assignedUserIdList.value.add(_eligibleUser.id);
        update();
        print("Added to List");
      } else {
        Get.snackbar("Failure", "Cant Add User");
      }
    } else
      (Get.snackbar("Empty List", "userList empty"));
  }

  void removePersonFromNewList(String email) {
    if (newList.length > 0) {
      for (var user in newList) {
        if (user.email == email.trim()) {
          newUserList.value.remove(user);
          newUserIdList.value.remove(user.id);
          update();
          break;
        } else {
          print("Cant Remove");
        }
      }
    }
  }

  String getCreatorEmail(String id) {
    UserModel _user = userList.firstWhere((element) => element.id == id);
    return _user.email ?? "Email Not Set";
  }

  void updateDocument(String fileId, String userId) async {
    List<String> _assignedIdList = List.from(assignedIdList);
    List<String> _newIdList = List.from(newIdList);
    _assignedIdList.addAll(_newIdList);
    if (removeYourself) {
      _assignedIdList.remove(userId);
    }
    FilesModel _file = FilesModel(
      assigned_person_uid: _assignedIdList.length > 0 ? _assignedIdList : [""],
    );
    print(fileId);
    print(_file.assigned_person_uid);

    if (await FilesDb().ForwardFile(fileId, _file)) {
      update();
      Get.snackbar("Success", "File Updated");
    }
    print(_file.toString());
  }

  @override
  void onInit() {
    super.onInit();
    creatorController = CreatorController();
    initialized = false;
  }

  void clear() {
    assignedUserList.value = [];
  }

  @override
  void dispose() {
    super.dispose();
    creatorController = null;
    assignedUserList.value = [];
    assignedUserIdList.value = [];
  }
}
