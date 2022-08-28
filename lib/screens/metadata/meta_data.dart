import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:html_editor_enhanced/utils/utils.dart';
import 'package:velocityx/assets/custom_icons_icons.dart';
import 'package:velocityx/controllers/authController.dart';
import 'package:velocityx/controllers/metaDataController.dart';
import 'package:velocityx/controllers/userController.dart';
import 'package:velocityx/models/file_stats.dart';
import 'package:velocityx/models/files.dart';
import 'package:velocityx/models/user_categories.dart';
import 'package:velocityx/routes/app_pages.dart';
import 'package:velocityx/services/filesDb.dart';
import 'package:velocityx/shared/constants.dart';
import 'package:velocityx/shared/icon_logo.dart';
import 'package:ai_barcode/ai_barcode.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import '../../controllers/docCreationController.dart';
import '../../models/user.dart';
import 'dart:async';
import 'dart:io';
import 'package:universal_html/html.dart' as html;

class MetaDataPage extends StatelessWidget {
  final FilesModel File;
  MetaDataPage({Key? key, required this.File}) : super(key: key);
  final TextEditingController assignedPersonNameController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (File.organization_no !=
        Get.find<UserController>().user.organization_no) {
      return Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: Theme.of(context).primaryColor,
          ),
          title: Text("File Information",
              style: Theme.of(context).textTheme.headline4),
          elevation: 0.0,
        ),
        body: Center(
          child: Text(
              "Please return this document to the Respective Organization"),
        ),
      );
    } else {
      return GetBuilder<MetaDataController>(
          init: Get.put<MetaDataController>(MetaDataController()),
          builder: (controller) {
            if (controller.initialized == false) {
              for (String id in File.assigned_person_uid) {
                controller.initializeAssignedList(id);
              }
              controller.checkIfFinalApprover(File.final_approver);
              controller.initializeDropDown(File.files_uniqueId);
              controller.initializeUploadedFile(
                  File.storageName, File.storage_link);
              controller.initialized = true;
            }
            return Container(
              child: Scaffold(
                // backgroundColor: Color.fromRGBO(36, 36, 36, 1.0),
                appBar: AppBar(
                  leading: BackButton(
                    color: Theme.of(context).primaryColor,
                  ),
                  title: Text("File Information",
                      style: Theme.of(context).textTheme.headline4),
                  elevation: 0.0,
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 50, 10, 70),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.toNamed(
                              Routes.QR_CODE,
                              id: Constants.homeId,
                              arguments: File.files_uniqueId,
                              // arguments: filesController.files[index],
                            );
                          },
                          child: Container(
                            width: 200,
                            height: 200,
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Colors.blue,
                                  width: 15,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                            ),
                            margin: EdgeInsets.all(40),
                            child: PlatformAiBarcodeCreatorWidget(
                              creatorController: controller.creatorController!,
                              initialValue: File.files_uniqueId,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),

                        Text(
                          'File Properties:',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Visibility(
                          visible: controller.optionsVisible(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Select Category",
                                style: Theme.of(context).textTheme.headline5,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              DropdownButton(
                                value:
                                    controller.initialDropDownValue == "Not Set"
                                        ? null
                                        : controller.initialDropDownValue,
                                hint: Text("Select a item"),
                                icon: const Icon(Icons.keyboard_arrow_down),
                                items: controller.categories
                                    .map((CategoryModel category) {
                                  return DropdownMenuItem(
                                    value: category.name,
                                    child: Text(
                                      category.name ?? "No Name",
                                      style:
                                          Theme.of(context).textTheme.headline5,
                                    ),
                                  );
                                }).toList(),
                                onChanged: (newValue) {
                                  controller.changeCategory(
                                      newValue.toString(), File.files_uniqueId);
                                  // print(newValue.toString());
                                },
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Visibility(
                                  visible: controller.initialDropDownValue ==
                                          "Not Set"
                                      ? false
                                      : true,
                                  child: ElevatedButton(
                                      onPressed: () {
                                        controller.removeCategory(
                                            File.files_uniqueId);
                                      },
                                      child: Text("Remove"))),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          style: Theme.of(context).textTheme.headline5,
                          enabled: false,
                          initialValue: File.name,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 2.0),
                            ),
                            fillColor: Colors.black54,
                            filled: true,
                            label: Text(
                              "Name",
                            ),
                            hintText: File.name,
                            focusColor: Colors.blue,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          style: Theme.of(context).textTheme.headline5,
                          enabled: false,
                          initialValue: "No Size Available",
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 2.0),
                            ),
                            fillColor: Colors.black54,
                            filled: true,
                            label: Text("Size"),
                            hintText: File.name,
                            focusColor: Colors.blue,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          style: Theme.of(context).textTheme.headline5,
                          enabled: false,
                          initialValue: File.creator_name,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 2.0),
                            ),
                            fillColor: Colors.black54,
                            filled: true,
                            label: Text("File Owner"),
                            hintText: File.name,
                            focusColor: Colors.blue,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          style: Theme.of(context).textTheme.headline5,
                          enabled: false,
                          initialValue: controller.getDateFromTimeStamp(
                              File.creation_datetime!.seconds.toString()),
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 2.0),
                            ),
                            fillColor: Colors.black54,
                            filled: true,
                            label: Text("Created"),
                            hintText: File.name,
                            focusColor: Colors.blue,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          style: Theme.of(context).textTheme.headline5,
                          enabled: false,
                          initialValue: controller
                              .getFinalApproverName(File.final_approver),
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 2.0),
                            ),
                            fillColor: Colors.black54,
                            filled: true,
                            label: Text("Final Approver"),
                            hintText: File.name,
                            focusColor: Colors.blue,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          style: Theme.of(context).textTheme.headline5,
                          enabled: false,
                          initialValue:
                              getEmailFromUidList(File.assigned_person_uid)
                                  .toString()
                                  .replaceAll("[", "")
                                  .replaceAll("]", ""),
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 2.0),
                            ),
                            fillColor: Colors.black54,
                            filled: true,
                            label: Text("Assigned Persons"),
                            hintText: File.name,
                            focusColor: Colors.blue,
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Visibility(
                            visible: controller.isFinalApprover,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    controller.FinalApproverResponse(
                                        File.files_uniqueId, "Rejected");
                                  },
                                  child: Text("Reject"),
                                ),
                                SizedBox(width: 20),
                                ElevatedButton(
                                  onPressed: () {
                                    controller.FinalApproverResponse(
                                        File.files_uniqueId, "Accepted");
                                  },
                                  child: Text("Accept"),
                                ),
                              ],
                            )),
                        SizedBox(
                          height: 50,
                        ),
                        Visibility(
                          // visible: false,
                          visible: controller.optionsVisible(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                color: Theme.of(context).primaryColor,
                                icon: Icon(Icons.history_outlined),
                                onPressed: () async {
                                  FileStatsModel FileStats = await FilesDb()
                                      .GetStats(File.files_uniqueId);
                                  Get.toNamed(
                                    Routes.FILE_INFORMATION,
                                    id: Constants.homeId,
                                    arguments: FileStats,
                                  );
                                },
                              ),
                              IconButton(
                                color: Theme.of(context).primaryColor,
                                icon: Icon(Icons.open_in_new),
                                onPressed: () {
                                  controller.OpenedDocument(File.files_uniqueId,
                                      Get.find<UserController>().user.id ?? "");
                                  Get.toNamed(
                                    Routes.PDFVIEWER,
                                    id: Constants.homeId,
                                    arguments: File.storage_link,
                                  );
                                },
                              ),
                              IconButton(
                                color: Theme.of(context).primaryColor,
                                icon: Icon(Icons.person_add_alt_outlined),
                                onPressed: () {
                                  controller.changeIsAssignedPressed();
                                },
                              ),
                              IconButton(
                                color: Theme.of(context).primaryColor,
                                icon: Icon(Icons.download),
                                onPressed: () {
                                  print(File.storage_link);
                                  // controller.downloadFile(File.storage_link);
                                  controller.decryptAndDownloadFile(file: File);
                                  print("clicked");
                                  // if (kIsWeb) {
                                  //   html.window
                                  //       .open(File.storage_link, "_blank");
                                  // } else {
                                  //   controller.download(
                                  //       url: File.storage_link,
                                  //       fileName: File.name);
                                  // }

                                  print(File.storage_link);
                                },
                              ),
                              IconButton(
                                color: Theme.of(context).primaryColor,
                                icon: Icon(Icons.upload_file),
                                onPressed: () {
                                  controller.changeIsUploadVisible();
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Visibility(
                          visible: controller.isAssignedPressed.value,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Column(
                                  children: [
                                    TextFormField(
                                      style:
                                          Theme.of(context).textTheme.headline5,
                                      decoration: InputDecoration(
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            if (assignedPersonNameController
                                                        .text !=
                                                    null &&
                                                assignedPersonNameController
                                                    .text.isNotEmpty) {
                                              print("sending request");
                                              controller.addToNewList(
                                                  File.creator_uid,
                                                  assignedPersonNameController
                                                      .text
                                                      .trim()
                                                      .toLowerCase());
                                            }
                                            ;
                                            assignedPersonNameController.text =
                                                "";
                                          },
                                          icon: Icon(Icons.add),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              width: 2.0),
                                        ),
                                        fillColor: Colors.black54,
                                        filled: true,
                                        label: Text(
                                            "Who do u want to assign this Document? "),
                                        hintText: "Enter Names",
                                        focusColor: Colors.blue,
                                      ),
                                      controller: assignedPersonNameController,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20),
                              SingleChildScrollView(
                                  child: (controller != null &&
                                          controller.newList.length > 0)
                                      ? GridView.builder(
                                          shrinkWrap: true,
                                          itemCount: controller.newList.length,
                                          gridDelegate:
                                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                            maxCrossAxisExtent: 180,
                                            childAspectRatio: 3 / 2,
                                            crossAxisSpacing: 20,
                                            mainAxisSpacing: 20,
                                          ),
                                          itemBuilder: (_, index) {
                                            return Container(
                                              alignment: Alignment.center,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(controller.newList[index]
                                                          .f_name +
                                                      " " +
                                                      controller.newList[index]
                                                          .l_name),
                                                  Text(controller.newList[index]
                                                          .email ??
                                                      "Email Not Set"),
                                                  IconButton(
                                                    onPressed: () {
                                                      controller
                                                          .removePersonFromNewList(
                                                              controller
                                                                      .newList[
                                                                          index]
                                                                      .email ??
                                                                  "Email Not Set");
                                                    },
                                                    icon: Icon(
                                                        Icons.person_remove),
                                                    color: Colors.red,
                                                  )
                                                ],
                                              ),
                                              decoration: BoxDecoration(
                                                  color: Colors.blue,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                            );
                                          })
                                      : Container()),
                              SizedBox(height: 20),
                              CheckboxListTile(
                                title: Text(
                                    "Do you want to remove yourself from assigned people?",
                                    style:
                                        Theme.of(context).textTheme.headline5),
                                value: controller.removeYourself,
                                onChanged: (newValue) {
                                  // controller.changeDownloadDocumentCheck(newValue!);
                                  controller.removeYourselfPresed();
                                },
                                // checkColor: Color(0xFF4784F1),
                                activeColor: Color(0xFF4784F1),
                                controlAffinity: ListTileControlAffinity
                                    .trailing, //  <-- leading Checkbox
                              ),
                              SizedBox(height: 20),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: controller.isUploadVisible,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Uploaded Document',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              SingleChildScrollView(
                                  child: controller.uploadedFileName != ""
                                      ? GridView.builder(
                                          shrinkWrap: true,
                                          itemCount: 1,
                                          gridDelegate:
                                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                            maxCrossAxisExtent: 180,
                                            childAspectRatio: 3 / 2,
                                            crossAxisSpacing: 20,
                                            mainAxisSpacing: 20,
                                          ),
                                          itemBuilder: (_, index) {
                                            return Container(
                                              alignment: Alignment.center,
                                              child: Text(
                                                  "${controller.uploadedFileName}"),
                                              decoration: BoxDecoration(
                                                  color: Colors.blue,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                            );
                                          },
                                        )
                                      : Container()),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Uploaded Modified Document',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4,
                                      ),
                                      // Text(
                                      //     '(Proof of Address)'
                                      // )
                                    ],
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      final result =
                                          await FilePicker.platform.pickFiles(
                                        type: FileType.custom,
                                        allowedExtensions: [
                                          'pdf',
                                          'doc',
                                          'docx',
                                          'xls',
                                          'csv',
                                          'ppt',
                                          'pptx',
                                          'zip',
                                        ],
                                        withData: true,
                                      );
                                      print(result);
                                      if (result == null) {
                                        return null;
                                      } else {
                                        controller.updatePickedFile(result);
                                        print(controller.pickedFile?.name);
                                        print(controller.pickedFile?.extension);
                                      }
                                    },
                                    iconSize: 40,
                                    icon: Icon(
                                      Icons.upload_file,
                                      color: Color(0xFF4784F1),
                                    ),
                                  )
                                ],
                              ),
                              Visibility(
                                visible: controller.isFilePicked,
                                // child: Text("${controller.pickedFile?.name}")
                                child: SingleChildScrollView(
                                    child: controller.isFilePicked
                                        ? GridView.builder(
                                            shrinkWrap: true,
                                            itemCount: 1,
                                            gridDelegate:
                                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                              maxCrossAxisExtent: 180,
                                              childAspectRatio: 3 / 2,
                                              crossAxisSpacing: 20,
                                              mainAxisSpacing: 20,
                                            ),
                                            itemBuilder: (_, index) {
                                              return Container(
                                                alignment: Alignment.center,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                        "${controller.pickedFile?.name}"),
                                                    // Text(controller
                                                    //     .finApproverList[index]
                                                    //     .email ??
                                                    //     "Email Not Set"),
                                                    IconButton(
                                                      onPressed: () {
                                                        controller
                                                            .removePickedFile();
                                                      },
                                                      icon: Icon(
                                                          Icons.person_remove),
                                                      color: Colors.red,
                                                    )
                                                  ],
                                                ),
                                                decoration: BoxDecoration(
                                                    color: Colors.blue,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                              );
                                            },
                                          )
                                        : Container()),
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: (controller.isAssignedPressed.value ||
                              controller.isUploadVisible),
                          child: Center(
                            child: TextButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Color(0xFF4784F1),
                                  padding: EdgeInsets.fromLTRB(40, 20, 40, 20)),
                              child: Text(
                                "Save",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              onPressed: () async {
                                controller.storageLink = await controller
                                    .updateStorageLink(File.creator_uid)
                                    .whenComplete(() =>
                                        controller.updateDocument(
                                            File.files_uniqueId,
                                            Get.find<UserController>()
                                                    .user
                                                    .id ??
                                                "",
                                            File,
                                            controller.storageLink));
                              },
                            ),
                          ),
                        )

                        //   },
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          });
    }
  }

  String getEmailFromUid(String uid) {
    print(uid);
    UserModel? user = Get.find<UserController>().users.firstWhereOrNull(
          (user) => user.id == uid,
        );
    // String name = user.f_name + " " + user.l_name;
    // return name;

    String email = user?.email == null ? "" : "${user?.email}";
    return email;
  }

  List<String> getEmailFromUidList(List<dynamic> listOfUidOfassignedUsers) {
    List<String> listOfNamesOfAssignedUsers = [];

    print(listOfUidOfassignedUsers.length);

    if (listOfUidOfassignedUsers.length != null) {
      for (var uid in listOfUidOfassignedUsers) {
        listOfNamesOfAssignedUsers.add(getEmailFromUid(uid));
      }
    }

    return listOfNamesOfAssignedUsers;
  }
}
