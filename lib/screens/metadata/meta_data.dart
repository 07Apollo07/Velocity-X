import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocityx/assets/custom_icons_icons.dart';
import 'package:velocityx/controllers/authController.dart';
import 'package:velocityx/controllers/metaDataController.dart';
import 'package:velocityx/models/files.dart';
import 'package:velocityx/routes/app_pages.dart';
import 'package:velocityx/shared/constants.dart';
import 'package:velocityx/shared/icon_logo.dart';

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
            padding: const EdgeInsets.fromLTRB(20, 70, 10, 70),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    height: 140.0,
                    width: 340.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        width: 4,
                        color: Theme.of(context).primaryColor,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15.0, 105, 90, 5),
                      child: Text(
                        File.name,
                        style:
                            TextStyle(color: Colors.black, letterSpacing: 1.8),
                      ),
                    )),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'File Properties:',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                //         Text(
                //           '''Name : Document_1.pdf,
                // Size : 246kb ,
                // File Owner : User_example
                // Created : Jan 31, 2021
                // Modified : Jun 24, 2021
                // Permission : User1, user2 .''',
                //           textAlign: TextAlign.start,
                //           style: TextStyle(fontSize: 16),
                //         ),
                Text("Name : " + File.name),
                Text("Size : " + "No Size available"),
                Text("File Owner : " + File.creator_uid),
                Text("Created : " +
                    controller.getDateFromTimeStamp(
                        File.creation_datetime!.seconds.toString())),
                Text("Final Approver : " + File.final_approver),
                Text("Assigned Persons : " +
                    File.assigned_person_uid.toString()),
                SizedBox(
                  height: 200,
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
                          // arguments: filesController.files[index],
                        );
                      },
                    ),
                    IconButton(
                      color: Theme.of(context).primaryColor,
                      icon: Icon(CustomIcons.bookmark),
                      onPressed: () {},
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
