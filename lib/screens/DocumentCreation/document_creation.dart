import  'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocityx/controllers/docCreationController.dart';
import 'package:velocityx/controllers/userController.dart';

class DocumentCreation extends StatefulWidget {
  static final _formkey = GlobalKey<FormState>();

  @override
  State<DocumentCreation> createState() => _DocumentCreationState();
}

class _DocumentCreationState extends State<DocumentCreation> {
  final TextEditingController documentNameController = TextEditingController();
  final TextEditingController assignedPersonNameController =
      TextEditingController();
  final TextEditingController finalApproverController = TextEditingController();

  bool loading = false;
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DocCreationController>(
        init: Get.put<DocCreationController>(DocCreationController()),
        builder: (controller) {
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
                        "Create Document",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            body: SingleChildScrollView(
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
                                controller: documentNameController,
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
                                      if (assignedPersonNameController.text !=
                                              null &&
                                          assignedPersonNameController
                                              .text.isNotEmpty) {
                                        print("sending request");
                                        controller.addToAssignedList(
                                            assignedPersonNameController.text
                                                .trim()
                                                .toLowerCase());
                                      }
                                      ;
                                      assignedPersonNameController.text = "";
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
                                controller: assignedPersonNameController,
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
                                  if (finalApproverController.text != null &&
                                      finalApproverController.text.isNotEmpty) {
                                    print("sending request");
                                    controller.setFinalApprover(
                                        finalApproverController.text
                                            .trim()
                                            .toLowerCase());
                                  }
                                  ;
                                  finalApproverController.text = "";
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
                            controller: finalApproverController,
                          ),
                        ),
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
                                        maxCrossAxisExtent: 130,
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
                              if (DocumentCreation._formkey.currentState!
                                  .validate()) {
                                controller.createDocument(
                                    documentNameController.text.trim(),
                                    controller.assignedIdList,
                                    controller.downloadDocument,
                                    controller.finalApprover,
                                    controller.finApproverIdList);
                                documentNameController.text = "";
                                assignedPersonNameController.text = "";
                                finalApproverController.text = "";
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
