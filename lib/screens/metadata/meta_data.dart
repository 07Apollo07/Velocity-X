import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocityx/assets/custom_icons_icons.dart';
import 'package:velocityx/controllers/authController.dart';
import 'package:velocityx/controllers/metaDataController.dart';
import 'package:velocityx/models/files.dart';
import 'package:velocityx/routes/app_pages.dart';
import 'package:velocityx/shared/constants.dart';
import 'package:velocityx/shared/icon_logo.dart';
import 'package:ai_barcode/ai_barcode.dart';

class MetaDataPage extends GetWidget<MetaDataController> {
  final FilesModel File;
  const MetaDataPage({Key? key, required this.File}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                          color: Theme.of(context).primaryColor, width: 2.0),
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
                          color: Theme.of(context).primaryColor, width: 2.0),
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
                          color: Theme.of(context).primaryColor, width: 2.0),
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
                          color: Theme.of(context).primaryColor, width: 2.0),
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
                          color: Theme.of(context).primaryColor, width: 2.0),
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
                          color: Theme.of(context).primaryColor, width: 2.0),
                    ),
                    fillColor: Colors.black54,
                    filled: true,
                    label: Text("Assigned Persons"),
                    hintText: File.name,
                    focusColor: Colors.blue,
                  ),
                ),
                // Text("Name : " + File.name),
                // Text("Size : " + "No Size available"),
                // Text("File Owner : " + File.creator_uid),
                // Text("Created : " +
                //     controller.getDateFromTimeStamp(
                //         File.creation_datetime!.seconds.toString())),
                // Text("Final Approver : " + File.final_approver),
                // Text("Assigned Persons : " +
                //     File.assigned_person_uid.toString()),
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
                      icon: Icon(CustomIcons.bookmark),
                      onPressed: () {
                        Get.toNamed(
                          Routes.PDFVIEWER,
                          id: Constants.homeId,
                          arguments: File.storage_link,
                        );
                      },
                    ),
                    IconLogo(
                        color: Theme.of(context).primaryColor,
                        icon: CustomIcons.bell),
                    IconLogo(
                        color: Theme.of(context).primaryColor,
                        icon: CustomIcons.home),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
