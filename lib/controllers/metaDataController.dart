import 'package:ai_barcode/ai_barcode.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:velocityx/controllers/categoryController.dart';
import 'package:velocityx/controllers/userController.dart';
import 'package:velocityx/models/files.dart';
import 'package:velocityx/models/user.dart';
import 'package:velocityx/models/user_categories.dart';
import 'package:velocityx/services/crypto.dart';
import 'package:velocityx/services/filesDb.dart';
import 'package:velocityx/services/usersDb.dart';
import 'package:velocityx/shared/constants.dart';
import 'package:file_picker/file_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class MetaDataController extends GetxController {
  bool initialized = false;
  bool removeYourself = false;
  var isAssignedPressed = false.obs;
  PlatformFile? pickedFile;
  bool isFilePicked = false;
  String uploadedFileName = "";
  bool loading = false;
  String storageLink = "";
  CreatorController? creatorController;
  bool isUploadVisible = false;
  String initialDropDownValue = "Not Set";
  bool isFinalApprover = false;

  List<CategoryModel> categories = Get.find<UserController>().categories;
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

  void changeCategory(String categoryName, String fileId) async {
    try {
      int indexOldCategory = categories
          .indexWhere((category) => category.name == initialDropDownValue);
      if (indexOldCategory != -1) {
        categories[indexOldCategory].ids?.removeWhere((id) => id == fileId);
      }
      int indexNewCategory =
          categories.indexWhere((category) => category.name == categoryName);
      if (indexNewCategory != -1) {
        categories[indexNewCategory].ids?.add(fileId);
      }
    } catch (e) {
      print(e.toString());
    }
    List<dynamic> categoriesToUpload = categories
        .map((category) => {"name": category.name, "ids": category.ids})
        .toList();
    if (await UserDb().UpdateCategoryItem(
        categoriesToUpload, Get.find<UserController>().user.id ?? "Not Set")) {}
    if (Get.isRegistered<CategoryController>()) {
      // Get.find<CategoryController>().changeInitialized(false);
      Get.delete<CategoryController>();
    }
    initialDropDownValue = categoryName;
    update();
  }

  void removeCategory(String fileId) async {
    int indexOldCategory = categories
        .indexWhere((category) => category.name == initialDropDownValue);
    if (indexOldCategory != -1) {
      categories[indexOldCategory].ids?.removeWhere((id) => id == fileId);
    }
    List<dynamic> categoriesToUpload = categories
        .map((category) => {"name": category.name, "ids": category.ids})
        .toList();
    if (await UserDb().UpdateCategoryItem(
        categoriesToUpload, Get.find<UserController>().user.id ?? "Not Set")) {}
    if (Get.isRegistered<CategoryController>()) {
      // Get.find<CategoryController>().changeInitialized(false);
      Get.delete<CategoryController>();
    }
    initialDropDownValue = "Not Set";
    update();
  }

  void initializeDropDown(String id) {
    bool found = false;
    print(id);
    for (var category in categories) {
      print(category.ids.toString());
      if (found == false) {
        category.ids?.firstWhere((cateId) {
          if (cateId == id) {
            initialDropDownValue = category.name!;
            found = true;
            return true;
          } else {
            return false;
          }
        }, orElse: () => "Not Set");
      }
    }
    print(initialDropDownValue);
    update();
  }

  void changeLoading(bool load) {
    loading = load;
    update();
  }

  void initializeUploadedFile(String fileName, String oldstorageLink) {
    uploadedFileName = fileName;
    storageLink = oldstorageLink;
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

  bool optionsVisible() {
    bool assigned = assignedIdList.contains(Get.find<UserController>().user.id);
    return assigned ? true : false;
  }

  void changeIsAssignedPressed() {
    isAssignedPressed.value = !isAssignedPressed.value;
    update();
  }

  void changeIsUploadVisible() {
    isUploadVisible = !isUploadVisible;
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

  // void addToAssignedList(String email) async {
  //   print("reached here to add");
  //   if (userList.length > 0) {
  //     print("there are items in userList");
  //     UserModel _eligibleUser = userList.firstWhere(
  //           (user) => ((user.email == email)),
  //       orElse: () {
  //         UserModel dummy = UserModel();
  //         Get.snackbar("Fail", "Massive Fail");
  //         return dummy;
  //       },
  //     );
  //     bool duplicateUser =
  //     assignedList.any((user) => (user.email == _eligibleUser.email));
  //     if (!duplicateUser && _eligibleUser.email != "Email Not Set") {
  //       assignedUserList.value.add(_eligibleUser);
  //       assignedUserIdList.value.add(_eligibleUser.id);
  //       update();
  //       print("Added to List");
  //     } else {
  //       Get.snackbar("Failure", "Cant Add User");
  //     }
  //   } else
  //     (Get.snackbar("Empty List", "userList empty"));
  // }

  void addToNewList(String creator_id, String email) async {
    print("Adding to New List");
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
        Get.snackbar("Not Allowed", "You are Not allowed to add this User");
      }
    } else {
      (Get.snackbar("Empty List", "userList empty"));
    }
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

  String getFinalApproverName(String uid) {
    if (uid == "No Final Approver") {
      return "No Final Approver";
    }
    UserModel user = userList.firstWhere((user) => user.id == uid);
    String name = user.f_name + " " + user.l_name;
    return name;
  }

  void checkIfFinalApprover(String id) {
    String? user = assignedIdList.firstWhere((userId) => userId == id,
        orElse: () => "Not Found");
    if (user != "Not Found") {
      isFinalApprover = true;
    } else {
      isFinalApprover = false;
    }
    update();
  }

  void FinalApproverResponse(bool response) {}

  void updateDocument(
      String fileId, String userId, FilesModel file, String StorageLink) async {
    List<String> _assignedIdList = List.from(assignedIdList);
    List<String> _newIdList = List.from(newIdList);
    _assignedIdList.addAll(_newIdList);
    if (removeYourself) {
      _assignedIdList.remove(userId);
    }
    FilesModel _file = FilesModel(
      assigned_person_uid: _assignedIdList.length > 0 ? _assignedIdList : [""],
      storage_link: StorageLink,
    );
    print(fileId);
    print(_file.assigned_person_uid);

    if (await FilesDb()
        .ForwardFile(fileId, _file, _newIdList, file, removeYourself)) {
      update();
      Get.back(id: Constants.homeId);
      Get.snackbar("Success", "File Updated");
    }
    print(_file.toString());
  }

  void OpenedDocument(String fileId, String userId) async {
    await FilesDb().UpdateOpenedStats(fileId, userId);
  }

  String getCreatorEmail(String id) {
    UserModel _user = userList.firstWhere((element) => element.id == id);
    return _user.email ?? "Email Not Set";
  }

  String getDateFromTimeStamp(String timestamp) {
    int time = int.parse(timestamp);
    DateTime date = DateTime.fromMillisecondsSinceEpoch(time * 1000);
    String formattedDate = DateFormat('M/d/y -- E -- HH:mm:ss a ').format(date);
    return formattedDate;
  }

  void clear() {
    assignedUserList.value = [];
  }

  @override
  void onInit() {
    super.onInit();
    creatorController = CreatorController();
    initialized = false;
  }

  @override
  void dispose() {
    super.dispose();
    creatorController = null;
    assignedUserList.value = [];
    assignedUserIdList.value = [];
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
}
