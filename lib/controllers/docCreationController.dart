import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pointycastle/api.dart';
import 'package:velocityx/controllers/authController.dart';
import 'package:velocityx/controllers/userController.dart';
import 'package:velocityx/models/files.dart';
import 'package:velocityx/models/user.dart';
import 'package:velocityx/services/filesDb.dart';
import 'package:file_picker/file_picker.dart';
import 'package:velocityx/services/crypto.dart';

class DocCreationController extends GetxController {
  // final TextEditingController documentNameController = TextEditingController();
  // final TextEditingController assignedPersonNameController =
  // TextEditingController();
  // final TextEditingController finalApproverController = TextEditingController();

  TextEditingController documentNameController = TextEditingController();
  TextEditingController assignedPersonNameController = TextEditingController();
  TextEditingController finalApproverController = TextEditingController();

  var downloadDocument = false;
  bool onlineDocument = false;
  var finalApprover = false;
  PlatformFile? pickedFile;
  bool isFilePicked = false;
  Rx<String> storageLink = Rx<String>("");
  bool loading = false;

  String get storageLinkValue => storageLink.value;

  var name = ''.obs;
  var assignedDocument = ''.obs;
  var finalApproverText = ''.obs;

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

  void Reset() {
    documentNameController.text = "";
    assignedPersonNameController.text = "";
    finalApproverController.text = "";
    downloadDocument = false;
    onlineDocument = false;
    finalApprover = false;
    pickedFile = null;
    isFilePicked = false;
    storageLink.value = "";
    assignedList.clear();
    assignedIdList.clear();
    finApproverList.clear();
    finApproverIdList.clear();
    print("onReset storage link is ${storageLinkValue}");
    update();
  }

  void changeLoading(bool load) {
    loading = load;
    update();
  }

  void changeOnlineDocument(bool load) {
    onlineDocument = load;
    downloadDocument = false;
    if (isFilePicked) {
      removePickedFile();
    }
    update();
  }

  void updateDocName(var docName) {
    name.value = docName;
    print(name.value);
    update();
  }

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
        fileModifiedDateTime: Timestamp.fromDate(DateTime.now()),
        storageName: isFilePicked ? pickedFile!.name : "",
      );
      if (await FilesDb().createNewFile(_file)) {
        Reset();
        update();
        Get.snackbar("Success", "File Created");
      }
      changeLoading(false);
      return true;
    } catch (e) {
      changeLoading(false);
      print(e.toString());
      return false;
    }
  }

  Future<String> updateStorageLink() async {
    print("inside storage function in controller");
    UserModel _user = Get.find<UserController>().user;

    String StorageLink = "";
    if (isFilePicked) {
      final storagePath = "${_user.organization_no}/${pickedFile!.name}";
      if (await FilesDb().CheckIfFileExistsInStorage(storagePath)) {
        Get.snackbar("Duplicate", "This File Already Exists");
        print("detected file exists");
        return StorageLink = "";
      } else {
        print("duplicate doesnt exist");
        // Uint8List hash = await Crypto().Keccack512kDigest(pickedFile?.bytes);
        // print('SHA-256: $hash');
        String extension = GetExtension(pickedFile!);
        File file = File("");
        if (kIsWeb) {
          file = File("");
        } else {
          file = File(pickedFile!.path!);
        }
        Uint8List key = getKey(_user.id);
        Uint8List iv = getiv(_user.email);
        Uint8List plainText = getPlainText(pickedFile?.bytes ?? Uint8List(256));
        // Encryption
        Uint8List CipherBlock = Crypto().aesCbcEncrypt(key, iv, plainText);
        // final fileBytes = pickedFile?.bytes;

        StorageLink = await FilesDb().UploadFileInStorage(
            storagePath,
            file,
            CipherBlock,
            extension,
            await compute(Crypto.Keccack512kDigest, pickedFile?.bytes));
        print("recieved storage link");
        storageLink.value = StorageLink;
        print(StorageLink);
        return StorageLink;
        // await FilesDb().UpdateStorageLinkInFile()
      }
    } else {
      return StorageLink = "";
    }
  }

  Uint8List getKey(String? id) {
    List<int> list = utf8.encode(id ?? "");
    Uint8List bytes = Uint8List.fromList(list);
    Uint8List key = Crypto().Keccack256kDigest(bytes);
    return key;
  }

  Uint8List getiv(String? email) {
    List<int> list = utf8.encode(email ?? "");
    Uint8List bytes = Uint8List.fromList(list);
    Uint8List key = Crypto().ripemd128Digest(bytes);
    return key;
  }

  Uint8List getPlainText(Uint8List bytes) {
    print("Before padding = ${bytes.length}");
    Uint8List plainText = Crypto().pad(bytes, 128);
    print("padded plaintext = ${plainText.length}");
    return plainText;
  }

  String GetExtension(PlatformFile pickedFile) {
    String extension = "";
    switch (pickedFile.extension) {
      case "pdf":
        extension = "pdf";
        break;
      case "doc":
        extension =
            "vnd.openxmlformats-officedocument.wordprocessingml.document";
        break;
      case "docx":
        extension =
            "vnd.openxmlformats-officedocument.wordprocessingml.document";
        break;
      case "xls":
        extension = "vnd.openxmlformats-officedocument.spreadsheetml.sheet";
        break;
      case "xlsx":
        extension = "vnd.openxmlformats-officedocument.spreadsheetml.sheet";
        break;
      case "csv":
        extension = "vnd.openxmlformats-officedocument.spreadsheetml.sheet";
        break;
      case "ppt":
        extension =
            "vnd.openxmlformats-officedocument.presentationml.presentation";
        break;
      case "pptx":
        extension =
            "vnd.openxmlformats-officedocument.presentationml.presentation";
        break;
      case "zip":
        extension = "x-zip-compressed";
        break;
      default:
        {
          print("Invalid");
        }
        break;
    }
    return extension;
  }
}
