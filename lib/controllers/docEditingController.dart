import 'package:ai_barcode/ai_barcode.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocityx/controllers/userController.dart';
import 'package:velocityx/models/files.dart';
import 'package:velocityx/models/user.dart';
import 'package:velocityx/services/filesDb.dart';
import 'package:velocityx/shared/constants.dart';

class DocEditingController extends GetxController {
  var downloadDocument = false;
  var finalApprover = false;
  bool initialized = false;

  CreatorController? creatorController;
  TextEditingController documentNameController = TextEditingController();
  TextEditingController assignedPersonNameController = TextEditingController();
  TextEditingController finalApproverController = TextEditingController();

  List<UserModel> userList = Get.find<UserController>().users;

  Rx<List<UserModel>> assignedUserList =
      Rx<List<UserModel>>(List.empty(growable: true));

  Rx<List<String?>> assignedUserIdList =
      Rx<List<String?>>(List.empty(growable: true));

  Rx<List<UserModel>> oldUserList =
      Rx<List<UserModel>>(List.empty(growable: true));

  Rx<List<String?>> oldUserIdList =
      Rx<List<String?>>(List.empty(growable: true));

  Rx<List<UserModel>> newUserList =
      Rx<List<UserModel>>(List.empty(growable: true));

  Rx<List<String?>> newUserIdList =
      Rx<List<String?>>(List.empty(growable: true));

  Rx<List<UserModel>> finalApproverList =
      Rx<List<UserModel>>(List.empty(growable: true));

  Rx<List<String?>> finalApproverIdList =
      Rx<List<String?>>(List.empty(growable: true));

  List<UserModel> get assignedList => assignedUserList.value;
  List<String?> get assignedIdList => assignedUserIdList.value;
  List<UserModel> get oldList => oldUserList.value;
  List<String?> get oldIdList => oldUserIdList.value;
  List<UserModel> get newList => newUserList.value;
  List<String?> get newIdList => newUserIdList.value;
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
          assignedUserList.value.add(user);
          assignedUserIdList.value.add(user.id);
          oldUserList.value.add(user);
          oldUserIdList.value.add(user.id);
          update();
          print(user);
        }
      }
    }
  }

  void addToAssignedList(String email) async {
    print("reached here to add");
    if (userList.length > 0) {
      UserModel _eligibleUser = userList.firstWhere(
        (user) => ((user.email == email) &&
            (user.id != Get.find<UserController>().user.id)),
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
        // newUserList.value.add(_eligibleUser);
        // newUserIdList.value.add(_eligibleUser.id);
        update();
        print("Added to List");
      } else {
        Get.snackbar("Not Allowed", "You are Not allowed to add this User");
      }
    } else
      (Get.snackbar("title", "userList empty"));
    print(assignedList.toString());
  }

  void removePersonFromAssignedPerson(String email) {
    if (assignedList.length > 0) {
      UserModel _eligibleUser = assignedList.firstWhere(
        (user) => ((user.email == email)),
        orElse: () {
          UserModel dummy = UserModel();
          return dummy;
        },
      );
      assignedUserList.value.remove(_eligibleUser);
      assignedUserIdList.value.remove(_eligibleUser.id);
      update();
      // if (oldIdList.contains(_eligibleUser.id)) {
      //   assignedUserList.value.remove(_eligibleUser);
      //   assignedUserIdList.value.remove(_eligibleUser.id);
      //   oldUserList.value.remove(_eligibleUser);
      //   oldUserIdList.value.remove(_eligibleUser.id);
      //   update();
      // } else {
      //   assignedUserList.value.remove(_eligibleUser);
      //   assignedUserIdList.value.remove(_eligibleUser.id);
      //   newUserIdList.value.remove(_eligibleUser);
      //   newUserIdList.value.remove(_eligibleUser.id);
      //   update();
      // }
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

  void removePersonFromFinalApprover(String email) {
    if (finApproverList.length > 0) {
      for (var user in finApproverList) {
        if (user.email == email.trim()) {
          finApproverList.remove(user);
          finApproverIdList.remove(user.id);
          print(finalApproverIdList);
          update();
        }
      }
    }
  }

  void deleteFile(String fileId) async {
    if (await FilesDb().DeleteFile(fileId)) {
      Get.back();
      Get.snackbar("File Deleted", "Success");
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
      assigned_person_uid: assignedPerson.length > 0 ? assignedPerson : [""],
      download: download,
      final_approver_set: finalApprover,
      final_approver: finalApproverNameId.length > 0
          ? finalApproverNameId.last ?? "No Final Approver"
          : "No Final Approver",
      storage_link: "",
    );
    print(fileId);
    print(_file.assigned_person_uid);

    List<String> deletedUsersId = [];
    oldIdList.forEach((olduserId) {
      if (assignedIdList.contains(olduserId)) {
      } else {
        deletedUsersId.add(olduserId!);
      }
      ;
    });
    List<String> newUserListId = [];
    assignedIdList.forEach((user) {
      if (oldList.contains(user)) {
      } else {
        newUserListId.add(user!);
      }
    });

    if (await FilesDb()
        .UpdateFile(fileId, _file, deletedUsersId, newUserListId)) {
      update();
      Get.back(id: Constants.profileId);
      Get.snackbar("Success", "File Updated");
    }
    print(_file.toString());
  }
}
