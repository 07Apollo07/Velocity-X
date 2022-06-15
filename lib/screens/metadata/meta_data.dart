import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/utils/utils.dart';
import 'package:velocityx/assets/custom_icons_icons.dart';
import 'package:velocityx/controllers/authController.dart';
import 'package:velocityx/controllers/metaDataController.dart';
import 'package:velocityx/controllers/userController.dart';
import 'package:velocityx/models/files.dart';
import 'package:velocityx/routes/app_pages.dart';
import 'package:velocityx/shared/constants.dart';
import 'package:velocityx/shared/icon_logo.dart';
import 'package:ai_barcode/ai_barcode.dart';
import 'package:get/get.dart';

import '../../controllers/docCreationController.dart';

class MetaDataPage extends StatelessWidget {
  final FilesModel File;
  MetaDataPage({Key? key, required this.File}) : super(key: key);
  final TextEditingController assignedPersonNameController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MetaDataController>(
        init: Get.put<MetaDataController>(MetaDataController()),
        builder: (controller) {
          if (controller.initialized == false) {
            for (String id in File.assigned_person_uid) {
              controller.initializeAssignedList(id);
            }
            controller.initialized = true;
          }
          return Container(
            child: Scaffold(
              // backgroundColor: Color.fromRGBO(36, 36, 36, 1.0),
              appBar: AppBar(
                leading: BackButton(
                  color: Theme.of(context).primaryColor,
                ),
                title: Text(
                  "File Information",
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                elevation: 0.0,
                actions: <Widget>[
                  Container(
                      margin: EdgeInsets.only(right: 15.0),
                      decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(context).primaryColor,
                              blurRadius: 5.0,
                            ),
                          ]),
                      child: IconButton(
                          onPressed: () {
                            // Navigator.pushNamed(context, '/MetaData');
                          },
                          icon: Icon(CustomIcons.search_1),
                          color: Theme.of(context).primaryColor)),
                  Container(
                    margin: EdgeInsets.only(right: 15.0),
                    decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).primaryColor,
                            blurRadius: 5.0,
                          ),
                        ]),
                    child: IconButton(
                        onPressed: () {
                          AuthController.instance.signOut();
                        },
                        icon: Icon(CustomIcons.bell),
                        color: Theme.of(context).primaryColor),
                  ),
                ],
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
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
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
                          label: Text("Name"),
                          hintText: File.name,
                          focusColor: Colors.blue,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
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
                        enabled: false,
                        initialValue: File.creator_uid,
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
                        enabled: false,
                        initialValue: File.final_approver,
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
                        enabled: false,
                        initialValue: File.assigned_person_uid.toString(),
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
                        height: 100,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            color: Theme.of(context).primaryColor,
                            icon: Icon(Icons.history_outlined),
                            onPressed: () {
                              Get.toNamed(
                                Routes.FILE_INFORMATION,
                                id: Constants.homeId,
                              );
                            },
                          ),
                          IconButton(
                            color: Theme.of(context).primaryColor,
                            icon: Icon(Icons.open_in_new),
                            onPressed: () {
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
                          IconLogo(
                              color: Theme.of(context).primaryColor,
                              icon: CustomIcons.home),
                        ],
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
                                            color:
                                                Theme.of(context).primaryColor,
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
                                                Text(controller
                                                        .newList[index].f_name +
                                                    " " +
                                                    controller
                                                        .newList[index].l_name),
                                                Text(controller
                                                        .newList[index].email ??
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
                                                  icon:
                                                      Icon(Icons.person_remove),
                                                  color: Colors.red,
                                                )
                                              ],
                                            ),
                                            decoration: BoxDecoration(
                                                color: Colors.blue,
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                          );
                                        })
                                    : Container()),
                            SizedBox(height: 20),
                            CheckboxListTile(
                              title: Text(
                                  "Do you want to remove yourself from assigned people?"),
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
                            Center(
                              child: TextButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Color(0xFF4784F1),
                                    padding:
                                        EdgeInsets.fromLTRB(40, 20, 40, 20)),
                                child: Text(
                                  "Save",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () async {
                                  controller.updateDocument(
                                      File.files_uniqueId,
                                      Get.find<UserController>().user.id ?? "",
                                      File);
                                },
                              ),
                            ),
                          ],
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
