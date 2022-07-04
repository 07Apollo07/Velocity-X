import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocityx/controllers/docCreationController.dart';
import 'package:velocityx/controllers/userController.dart';
import 'package:file_picker/file_picker.dart';

class DocumentCreation extends StatefulWidget {
  static final _formkey = GlobalKey<FormState>();

  @override
  State<DocumentCreation> createState() => _DocumentCreationState();
}

class _DocumentCreationState extends State<DocumentCreation> {
  bool loading = false;
  String name = '';
  String assignedDocument = '';
  String finalApprover = '';

  // void _updateDocName(){
  //   name = "${documentNameController.value}";
  //   print("${documentNameController.value}");
  // }
  //
  // void initState() {
  //   super.initState();
  //
  //   // Start listening to changes.
  //   documentNameController.addListener(_updateDocName);
  // }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DocCreationController>(
        init: Get.put<DocCreationController>(DocCreationController()),
        builder: (controller) {
          // documentNameController.text = "${controller.name}";
          // documentNameController.selection = TextSelection.fromPosition(TextPosition(offset: documentNameController.text.length));
          // documentNameController.text = name;
          // documentNameController.value = TextEditingValue(
          //   text: "${controller.name}",
          //   selection: TextSelection.collapsed(offset: "${controller.name}".length),
          // );
          if (Get.find<UserController>().user.organization_no == "00") {
            return Scaffold(
              body: Center(
                  child: Text(
                "Please ask your Employer to add you to their Organization",
                style: Theme.of(context).textTheme.headline5,
              )),
            );
          } else {
            return SafeArea(
              child: Scaffold(
                appBar: AppBar(
                  elevation: 0,
                  // leading: Icon(Icons.arrow_back_ios_new_rounded),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(
                            "Create Document",
                            style: Theme.of(context).textTheme.headline3,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                body: SingleChildScrollView(
                  controller: ScrollController(),
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                      child: Form(
                        key: DocumentCreation._formkey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              // width: 600,
                              child: Column(
                                children: [
                                  TextFormField(
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color:
                                                Theme.of(context).primaryColor,
                                            width: 2.0),
                                      ),
                                      // filled: true,
                                      label: Text("Document Name"),
                                      hintText: "Name",
                                      focusColor: Colors.blue,
                                    ),
                                    controller:
                                        controller.documentNameController,
                                    validator: (val) {
                                      if (val != null && val.isEmpty)
                                        return "Document name can't be Empty";
                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 20),
                                  TextFormField(
                                    style:
                                        Theme.of(context).textTheme.headline5,
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
                                            controller.addToAssignedList(
                                                Get.find<UserController>()
                                                        .user
                                                        .id ??
                                                    "Email Not Set",
                                                controller
                                                    .assignedPersonNameController
                                                    .text
                                                    .trim()
                                                    .toLowerCase());
                                          }
                                          ;
                                          controller
                                              .assignedPersonNameController
                                              .text = "";
                                        },
                                        icon: Icon(Icons.add),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color:
                                                Theme.of(context).primaryColor,
                                            width: 2.0),
                                      ),
                                      // filled: true,
                                      label: Text(
                                          "Who do you want to assign this Document? "),
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
                            (controller != null &&
                                    controller.assignedList.length > 0)
                                ? GridView.builder(
                                    controller: ScrollController(),
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
                                : Container(),
                            SizedBox(height: 20),
                            CheckboxListTile(
                              title: Text(
                                "Online Document? ",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5
                                    ?.copyWith(fontSize: 18),
                              ),
                              value: controller.onlineDocument,
                              onChanged: (newValue) {
                                controller.changeOnlineDocument(newValue!);
                              },
                              // checkColor: Color(0xFF4784F1),
                              activeColor: Color(0xFF4784F1),
                              controlAffinity: ListTileControlAffinity
                                  .trailing, //  <-- leading Checkbox
                            ),
                            SizedBox(height: 20),
                            CheckboxListTile(
                              title: Text(
                                "Do you want the assigned person to download this document?",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5
                                    ?.copyWith(fontSize: 18),
                              ),
                              value: controller.downloadDocument,
                              onChanged: (newValue) {
                                controller
                                    .changeDownloadDocumentCheck(newValue!);
                              },
                              // checkColor: Color(0xFF4784F1),
                              activeColor: Color(0xFF4784F1),
                              controlAffinity: ListTileControlAffinity
                                  .trailing, //  <-- leading Checkbox
                            ),
                            SizedBox(height: 20),
                            CheckboxListTile(
                              title: Text(
                                "Do you want to appoint a final approver?",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5
                                    ?.copyWith(fontSize: 18),
                              ),
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
                                style: Theme.of(context).textTheme.headline5,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      if (controller.finalApproverController
                                                  .text !=
                                              null &&
                                          controller.finalApproverController
                                              .text.isNotEmpty) {
                                        print("sending request");
                                        controller.setFinalApprover(controller
                                            .finalApproverController.text
                                            .trim()
                                            .toLowerCase());
                                      }
                                      ;
                                      controller.finalApproverController.text =
                                          "";
                                    },
                                    icon: Icon(Icons.add),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor,
                                        width: 2.0),
                                  ),
                                  // filled: true,
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
                              child: (controller != null &&
                                      controller.finApproverList.length > 0)
                                  ? GridView.builder(
                                      controller: ScrollController(),
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
                                  : Container(),
                            ),
                            SizedBox(height: 20),
                            Visibility(
                                visible: controller.onlineDocument,
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
                                              'Upload Document',
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
                                            final result = await FilePicker
                                                .platform
                                                .pickFiles(
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
                                            );
                                            print(result);
                                            if (result == null) {
                                              return null;
                                            } else {
                                              controller
                                                  .updatePickedFile(result);
                                              print(
                                                  controller.pickedFile?.name);
                                              print(controller
                                                  .pickedFile?.extension);
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
                                                      alignment:
                                                          Alignment.center,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
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
                                                            icon: Icon(Icons
                                                                .person_remove),
                                                            color: Colors.red,
                                                          )
                                                        ],
                                                      ),
                                                      decoration: BoxDecoration(
                                                          color: Colors.blue,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15)),
                                                    );
                                                  },
                                                )
                                              : Container()),
                                    ),
                                  ],
                                )),
                            SizedBox(height: 20),
                            Center(
                              child: TextButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Color(0xFF4784F1),
                                    padding:
                                        EdgeInsets.fromLTRB(40, 20, 40, 20)),
                                child: Text(
                                  controller.loading ? "Uploading" : "Upload",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () async {
                                  controller.loading
                                      ? null
                                      : {
                                          controller.changeLoading(true),
                                          if (DocumentCreation
                                                  ._formkey.currentState!
                                                  .validate() &&
                                              (controller.isFilePicked ||
                                                  !controller.onlineDocument))
                                            {
                                              controller.storageLink.value = "",
                                              print(
                                                  "sending for upload ; stprageLin is ${controller.storageLinkValue}"),
                                              controller.storageLink.value =
                                                  await controller
                                                      .updateStorageLink()
                                                      .whenComplete(() async {
                                                print(
                                                    "storage link is ${controller.storageLink} na dOnline file is ${!controller.onlineDocument}");
                                                if (controller
                                                            .storageLinkValue !=
                                                        "" ||
                                                    !controller
                                                        .onlineDocument) {
                                                  print("writing in db");
                                                  await controller.createDocument(
                                                      controller
                                                          .documentNameController
                                                          .text
                                                          .trim(),
                                                      controller.assignedIdList,
                                                      controller
                                                          .downloadDocument,
                                                      controller.finalApproverIdList
                                                                  .value.length >
                                                              0
                                                          ? true
                                                          : false,
                                                      controller
                                                          .finApproverIdList,
                                                      controller
                                                          .storageLinkValue);
                                                } else {
                                                  controller
                                                      .changeLoading(false);
                                                  // Get.snackbar("Duplicate",
                                                  //     "This File Already Exists");
                                                }
                                              }),
                                            }
                                          else
                                            {
                                              controller.changeLoading(false),
                                              Get.snackbar("Required",
                                                  "Document name not set or File not uploaded")
                                            }
                                        };
                                },
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            // Text(
                            //   error,
                            //   style: TextStyle(color: Colors.red, fontSize: 14.0),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
        });
  }
}
