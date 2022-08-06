import 'dart:io';
import 'dart:typed_data';
import 'dart:html' as html;
import 'dart:js' as js;

import 'package:ai_barcode/ai_barcode.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocityx/controllers/userController.dart';
import 'package:velocityx/models/files.dart';
import 'package:velocityx/models/user.dart';
import 'package:velocityx/services/crypto.dart';
import 'package:velocityx/services/filesDb.dart';
import 'package:velocityx/shared/constants.dart';
import 'package:dio/dio.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class DocEditingController extends GetxController {
  var downloadDocument = false;
  var finalApprover = false;
  bool initialized = false;
  PlatformFile? pickedFile;
  bool isFilePicked = false;
  String uploadedFileName = "";
  bool loading = false;
  String storageLink = "";

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

  Rx<List<UserModel>> oldfinalApproverList =
      Rx<List<UserModel>>(List.empty(growable: true));

  Rx<List<String?>> oldfinalApproverIdList =
      Rx<List<String?>>(List.empty(growable: true));

  List<UserModel> get assignedList => assignedUserList.value;
  List<String?> get assignedIdList => assignedUserIdList.value;
  List<UserModel> get oldList => oldUserList.value;
  List<String?> get oldIdList => oldUserIdList.value;
  List<UserModel> get newList => newUserList.value;
  List<String?> get newIdList => newUserIdList.value;
  List<UserModel> get finApproverList => finalApproverList.value;
  List<String?> get finApproverIdList => finalApproverIdList.value;
  List<UserModel> get oldfinApproverList => oldfinalApproverList.value;
  List<String?> get oldfinApproverIdList => oldfinalApproverIdList.value;

  void changeLoading(bool load) {
    loading = load;
    update();
  }

  void initializeUploadedFile(String fileName, String oldstorageLink) {
    uploadedFileName = fileName;
    storageLink = oldstorageLink;
  }

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
            finalApproverList.value.removeLast();
            finalApproverList.value.add(user);
            finalApproverIdList.value.removeLast();
            finalApproverIdList.value.add(user.id);
          } else {
            finApproverList.add(user);
            finApproverIdList.add(user.id);
            if (initialized == false) {
              oldfinalApproverList.value.add(user);
              oldfinalApproverIdList.value.add(user.id);
            }
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

  void updatePickedFile(var result) {
    if (pickedFile == null) {
      pickedFile = result.files.first;
      if (pickedFile!.name == uploadedFileName) {
        isFilePicked = true;
        update();
        Get.snackbar("Success", "File Picked");
      } else {
        pickedFile = null;
        isFilePicked = false;
        update();
        Get.snackbar("Error",
            "Please upload only the modified version of the initially uploaded file");
      }
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

  void deleteFile(FilesModel file) async {
    if (await FilesDb().DeleteFile(file)) {
      Get.back(id: Constants.profileId);
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
      List<String?> finalApproverNameId,
      String storageLink) async {
    FilesModel _file = FilesModel(
      name: docName,
      assigned_person_uid: assignedPerson.length > 0 ? assignedPerson : [""],
      download: download,
      final_approver_set: finalApprover,
      final_approver: finalApproverNameId.length > 0
          ? finalApproverNameId.last ?? "No Final Approver"
          : "No Final Approver",
      storage_link: storageLink,
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
      if (oldIdList.contains(user)) {
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

  void OpenedDocument(String fileId, String userId) async {
    await FilesDb().UpdateOpenedStats(fileId, userId);
  }

  Future<void> download({required String url, required String fileName}) async {
    // requests permission for downloading the file
    bool hasPermission = await _requestWritePermission();
    if (!hasPermission) return;

    // gets the directory where we will download the file.
    var dir = await getApplicationDocumentsDirectory();

    // You should put the name you want for the file here.
    // Take in account the extension.
    // String fileName = '${fileName}';

    // downloads the file
    Dio dio = Dio();
    await dio.download(url, "${dir.path}/$fileName");

    // opens the file
    OpenFile.open("${dir.path}/$fileName", type: 'application/pdf');
  }

  // requests storage permission
  Future<bool> _requestWritePermission() async {
    await Permission.storage.request();
    return await Permission.storage.request().isGranted;
  }

  Future<String> updateStorageLink() async {
    print("inside storage function in controller");
    UserModel _user = Get.find<UserController>().user;
    if (isFilePicked) {
      final storagePath = "${_user.organization_no}/${pickedFile!.name}";
      if (await FilesDb().CheckIfFileExistsInStorage(storagePath)) {
        String extension = GetExtension(pickedFile!);

        File file = File("");

        if (kIsWeb) {
          file = File("");
        } else {
          file = File(pickedFile!.path!);
        }
        final fileBytes = pickedFile?.bytes;

        String StorageLink = await FilesDb().UploadFileInStorage(
            storagePath,
            file,
            fileBytes,
            extension,
            Crypto.Keccack512kDigest(pickedFile?.bytes));
        print("recieved storage link");
        storageLink = StorageLink;
        print(StorageLink);
        return StorageLink;
      } else {
        Get.snackbar("Error", "File Does Not Exist in Remote Storage");
        return storagePath;
        // await FilesDb().UpdateStorageLinkInFile()
      }
    } else {
      return storageLink;
    }
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

  Future<void> decryptAndDownloadFile({required FilesModel file}) async {
    try {
      print("inside");
      Uint8List result = await FilesDb().DownloadFileInMemoryAndDecrypt(
          file.storage_link, file.storageName, file.creator_uid);
      print(result);
      if (result.length != 1) {
        if (kIsWeb) {
          js.context.callMethod("webSaveAs", [
            html.Blob([result]),
            "${file.storageName}"
          ]);
        } else {
          File('${file.storageName}').writeAsBytes(result);
        }
      }
    } catch (e) {
      Get..snackbar("Failed", "Failed to get File");
      print(e.toString());
    }
  }
}
