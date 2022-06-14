import 'package:ai_barcode/ai_barcode.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocityx/controllers/docEditingController.dart';
import 'package:velocityx/models/file_stats.dart';
import 'package:velocityx/models/files.dart';
import 'package:velocityx/routes/app_pages.dart';
import 'package:velocityx/services/filesDb.dart';
import 'package:velocityx/shared/constants.dart';

class DocumentEditing extends StatefulWidget {
  final FilesModel File;
  const DocumentEditing({Key? key, required this.File}) : super(key: key);

  static final _formkey = GlobalKey<FormState>();

  @override
  State<DocumentEditing> createState() => _DocumentEditingState();
}

class _DocumentEditingState extends State<DocumentEditing> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DocEditingController>(
        init: Get.put<DocEditingController>(DocEditingController()),
        builder: (controller) {
          if (controller.initialized == false) {
            controller.documentNameController.text = widget.File.name;
            for (String id in widget.File.assigned_person_uid) {
              controller.initializeAssignedList(id);
            }
            controller.setFinalApproverFromId(widget.File.final_approver);
            controller.initialized = true;
            controller.downloadDocument = widget.File.download;
            controller.finalApprover = widget.File.final_approver_set;
          }
          print(controller.assignedList.length);

          String error = '';

          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              // leading: Icon(Icons.arrow_back_ios_new_rounded),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      new Text(
                        "Document Editing",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                Container(
                  margin: EdgeInsets.only(right: 15.0),
                  decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.red,
                          blurRadius: 5.0,
                        ),
                      ]),
                  child: IconButton(
                      onPressed: () {
                        controller.deleteFile(widget.File.files_uniqueId);
                      },
                      icon: Icon(Icons.delete_forever),
                      color: Colors.red),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Form(
                    key: DocumentEditing._formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            Get.toNamed(
                              Routes.QR_CODE,
                              id: Constants.profileId,
                              arguments: widget.File.files_uniqueId,
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
                              initialValue: "Hello",
                            ),
                          ),
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              FileStatsModel FileStats =
                                  await FilesDb().GetStats("File");
                              // FilesDb().GetStats("File");
                              Get.toNamed(
                                Routes.FILE_INFORMATION,
                                id: Constants.profileId,
                                arguments: FileStats,
                                // arguments: "File",
                              );
                            },
                            child: Text("Track Document")),
                        SizedBox(height: 10),
                        Container(
                          child: Column(
                            children: [
                              TextFormField(
                                // initialValue: "hey",
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor,
                                        width: 2.0),
                                  ),
                                  fillColor: Colors.black54,
                                  filled: true,
                                  label: Text("Document Name"),
                                  hintText: "Name",
                                  focusColor: Colors.blue,
                                ),
                                controller: controller.documentNameController,
                                validator: (val) {
                                  if (val != null && val.isEmpty)
                                    return "Document name can't be Empty";
                                  return null;
                                },
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      if (controller
                                                  .assignedPersonNameController
                                                  .text !=
                                              null &&
                                          controller
                                              .assignedPersonNameController
                                              .text
                                              .isNotEmpty) {
                                        print("sending request");
                                        controller.addToAssignedList(controller
                                            .assignedPersonNameController.text
                                            .trim()
                                            .toLowerCase());
                                      }
                                      ;
                                      controller.assignedPersonNameController
                                          .text = "";
                                    },
                                    icon: Icon(Icons.add),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor,
                                        width: 2.0),
                                  ),
                                  fillColor: Colors.black54,
                                  filled: true,
                                  label: Text(
                                      "Who do u want to assign this Document? "),
                                  hintText: "Enter Names",
                                  focusColor: Colors.blue,
                                ),
                                controller:
                                    controller.assignedPersonNameController,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        SingleChildScrollView(
                            child: (controller != null &&
                                    controller.assignedList.length > 0)
                                ? GridView.builder(
                                    shrinkWrap: true,
                                    itemCount: controller.assignedList.length,
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
                                            Text(controller.assignedList[index]
                                                    .f_name +
                                                " " +
                                                controller.assignedList[index]
                                                    .l_name),
                                            Text(controller.assignedList[index]
                                                    .email ??
                                                "Email Not Set"),
                                            IconButton(
                                              onPressed: () {
                                                controller
                                                    .removePersonFromAssignedPerson(
                                                        controller
                                                                .assignedList[
                                                                    index]
                                                                .email ??
                                                            "Email Not Set");
                                              },
                                              icon: Icon(Icons.person_remove),
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
                              "Do you want the assigned person to download this document?"),
                          value: controller.downloadDocument,
                          onChanged: (newValue) {
                            controller.changeDownloadDocumentCheck(newValue!);
                          },
                          // checkColor: Color(0xFF4784F1),
                          activeColor: Color(0xFF4784F1),
                          controlAffinity: ListTileControlAffinity
                              .trailing, //  <-- leading Checkbox
                        ),
                        SizedBox(height: 20),
                        CheckboxListTile(
                          title:
                              Text("Do you want to appoint a final approver?"),
                          value: controller.finalApprover,
                          onChanged: (newValue) {
                            controller.changeFinalApproverCheck(newValue!);
                          },
                          // checkColor: Color(0xFF4784F1),
                          activeColor: Color(0xFF4784F1),
                          controlAffinity: ListTileControlAffinity
                              .trailing, //  <-- leading Checkbox
                        ),
                        SizedBox(height: 20),
                        Visibility(
                          visible: controller.finalApprover,
                          child: TextFormField(
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () {
                                  if (controller.finalApproverController.text !=
                                          null &&
                                      controller.finalApproverController.text
                                          .isNotEmpty) {
                                    print("sending request");
                                    controller.setFinalApprover(controller
                                        .finalApproverController.text
                                        .trim()
                                        .toLowerCase());
                                  }
                                  ;
                                  controller.finalApproverController.text = "";
                                },
                                icon: Icon(Icons.add),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    width: 2.0),
                              ),
                              fillColor: Colors.black54,
                              filled: true,
                              label: Text("Final Approver Name "),
                              hintText: "Enter Names",
                              focusColor: Colors.blue,
                            ),
                            controller: controller.finalApproverController,
                          ),
                        ),
                        SizedBox(height: 20),
                        Visibility(
                          visible: controller.finalApprover,
                          child: SingleChildScrollView(
                              child: (controller != null &&
                                      controller.finApproverList.length > 0)
                                  ? GridView.builder(
                                      shrinkWrap: true,
                                      itemCount:
                                          controller.finApproverList.length,
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
                                                      .finApproverList[index]
                                                      .f_name +
                                                  " " +
                                                  controller
                                                      .finApproverList[index]
                                                      .l_name),
                                              Text(controller
                                                      .finApproverList[index]
                                                      .email ??
                                                  "Email Not Set"),
                                              IconButton(
                                                onPressed: () {
                                                  controller
                                                      .removePersonFromFinalApprover(
                                                          controller
                                                                  .finApproverList[
                                                                      index]
                                                                  .email ??
                                                              "Email Not Set");
                                                },
                                                icon: Icon(Icons.person_remove),
                                                color: Colors.red,
                                              )
                                            ],
                                          ),
                                          decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                        );
                                      },
                                    )
                                  : Container()),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Upload Document',
                                  style: TextStyle(fontSize: 20),
                                ),
                                // Text(
                                //     '(Proof of Address)'
                                // )
                              ],
                            ),
                            IconButton(
                              onPressed: () {},
                              iconSize: 40,
                              icon: Icon(
                                Icons.upload_file,
                                color: Color(0xFF4784F1),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: TextButton(
                            style: ElevatedButton.styleFrom(
                                primary: Color(0xFF4784F1),
                                padding: EdgeInsets.fromLTRB(40, 20, 40, 20)),
                            child: Text(
                              "Upload",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () async {
                              if (DocumentEditing._formkey.currentState!
                                  .validate()) {
                                controller.updateDocument(
                                    widget.File.files_uniqueId,
                                    controller.documentNameController.text
                                        .trim(),
                                    controller.assignedIdList,
                                    controller.downloadDocument,
                                    controller.finalApprover,
                                    controller.finApproverIdList);
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          error,
                          style: TextStyle(color: Colors.red, fontSize: 14.0),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
