import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocityx/assets/custom_icons_icons.dart';
import 'package:velocityx/controllers/authController.dart';
import 'package:velocityx/controllers/filesController.dart';
import 'package:velocityx/controllers/userController.dart';
import 'package:velocityx/routes/app_pages.dart';
import 'package:velocityx/shared/constants.dart';

// class Profile extends StatefulWidget {
//   @override
//   State<Profile> createState() => _ProfileState();
// }

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            leading: Icon(Icons.edit),
            title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: GetX<UserController>(
                      init: Get.put<UserController>(UserController()),
                      builder: (_) {
                        return Column(children: [
                          new Text(
                            _.user.f_name + " " + _.user.l_name,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          new Text(
                            _.user.designation,
                            style: TextStyle(fontSize: 13),
                          ),
                        ]);
                      },
                    ),
                  )
                ]),
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
                      AuthController.instance.signOut();
                    },
                    icon: Icon(Icons.logout),
                    color: Theme.of(context).primaryColor),
              ),
            ],
            bottom: TabBar(
              tabs: [
                Tab(text: 'Informations'),
                Tab(text: 'Documents'),
              ],
            ),
          ),
          body: TabBarView(children: [
            UserInfo(),
            ProfileDoc(),
          ]),
        ));
  }
}

class ProfileDoc extends StatelessWidget {
  const ProfileDoc({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return ListView(
    //   children: <Widget>[
    //     ListTile(
    //       leading: Icon(Icons.picture_as_pdf_rounded),
    //       title: Text("Document_1"),
    //       subtitle: Text("Assigned By : User_2"),
    //       onTap: () {},
    //     )
    //   ],
    // );
    return Column(
      children: [
        Expanded(
          child: GetX<FilesController>(
            init: Get.put<FilesController>(FilesController()),
            builder: (FilesController filesController) {
              if (filesController != null &&
                  filesController.assignedFiles.length > 0) {
                return ListView.builder(
                  itemCount: filesController.createdFiles.length,
                  itemBuilder: (_, index) {
                    return ListTile(
                      //TODO remove assigned_by and due_date after changes to TaskTile
                      leading: Icon(Icons.account_circle_outlined),
                      title: Text(filesController.createdFiles[index].name),
                      subtitle: Text(filesController
                          .createdFiles[index].assigned_person_uid
                          .toString()),
                      onTap: () {
                        Get.toNamed(Routes.QR_CODE,
                            id: Constants.profileId,
                            arguments: filesController
                                .createdFiles[index].files_uniqueId);
                      },
                    );
                  },
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ],
    );
  }
}

class UserInfo extends GetWidget<UserController> {
  const UserInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 15,
        ),
        Text(
          'Information',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        SizedBox(
          height: 10,
        ),
        GetX<UserController>(
          init: Get.put<UserController>(UserController()),
          builder: (_) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Name : ${_.user.f_name} ${_.user.l_name}",
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                Text(
                  "Email: ${_.user.email}",
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                Text(
                  "Phone: ${_.user.phone}",
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                Text(
                  "Designation: ${_.user.designation}",
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                _.user.joining_date != null
                    ? Text(
                        "Joining Date: ${_.getDateFromTimeStamp(_.user.joining_date!.seconds.toString())}",
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      )
                    : Text("Joining Date : ")
              ],
            );
          },
        ),
//         Text(
//           '''Name : Document_1.pdf,
// Size : 246kb ,
// File Owner : User_example
// Created : Jan 31, 2021
// Modified : Jun 24, 2021
// Permission : User1, user2 .''',
//           textAlign: TextAlign.left, style: TextStyle(color: Colors.white, fontSize: 16),
//         ),
      ],
    );
  }
}
