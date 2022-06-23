import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocityx/assets/custom_icons_icons.dart';
import 'package:velocityx/controllers/authController.dart';
import 'package:velocityx/controllers/filesController.dart';
import 'package:velocityx/controllers/userController.dart';
import 'package:velocityx/routes/app_pages.dart';
import 'package:velocityx/shared/constants.dart';

import '../../models/user.dart';

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
                          Text(
                            _.user.f_name + " " + _.user.l_name,
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          Text(
                            _.user.designation,
                            style: Theme.of(context).textTheme.headline5,
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
              tabs: const [
                Tab(text: 'Informations'),
                Tab(text: 'Documents'),
              ],
              labelColor: Theme.of(context).secondaryHeaderColor,
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
            init: Get.find<FilesController>(),
            builder: (FilesController filesController) {
              if (filesController != null &&
                  filesController.createdFiles.length > 0) {
                return ListView.builder(
                  itemCount: filesController.createdFiles.length,
                  itemBuilder: (_, index) {
                    print(filesController
                        .createdFiles[index].assigned_person_uid);
                    return ListTile(
                      //TODO remove assigned_by and due_date after changes to TaskTile
                      leading: Icon(Icons.account_circle_outlined),
                      title: Text(filesController.createdFiles[index].name),
                      subtitle: Text(
                          "${getEmailFromUidList(filesController.createdFiles[index].assigned_person_uid).toString().replaceAll("[", "").replaceAll("]", "")}"),
                      onTap: () {
                        Get.toNamed(Routes.DOC_EDITING,
                            id: Constants.profileId,
                            arguments: filesController.createdFiles[index]);
                      },
                    );
                  },
                );
              } else if (filesController.createdFiles.isEmpty) {
                return const Center(
                  child: Text("You have not created any Files"),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
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
    return Container(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.supervised_user_circle,
                    size: 100,
                  ),
                ],
              ),
              Column(
                children: [
                  GetX<UserController>(
                    init: Get.put<UserController>(UserController()),
                    builder: (_) {
                      return Column(
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'NAME',
                                      textAlign: TextAlign.start,
                                    ),
                                    Container(
                                      width: 500,
                                      child: TextFormField(
                                        enabled: false,
                                        decoration: InputDecoration(
                                          hintText:
                                              "${_.user.f_name} ${_.user.l_name}",
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color(
                                                    int.parse(("0xff3D3A3A"))),
                                                width: 2.0),
                                          ),
                                          fillColor:
                                              Color(int.parse(("0xff3D3A3A"))),
                                          filled: true,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ]),

                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 20, 560, 5),
                            child: Text(
                              'EMAIL',
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Container(
                            width: 600,
                            child: TextField(
                              enabled: false,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(int.parse(("0xff3D3A3A"))),
                                      width: 2.0),
                                ),
                                // hintText: '${snapshot.data?.phoneNumber}',
                                hintText: "${_.user.email}",
                                fillColor: Color(int.parse(("0xff3D3A3A"))),
                                filled: true,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 20, 495, 5),
                            child: Text(
                              'PHONE NUMBER',
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Container(
                            width: 600,
                            child: TextField(
                              enabled: false,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(int.parse(("0xff3D3A3A"))),
                                      width: 2.0),
                                ),
                                // hintText: '${snapshot.data?.phoneNumber}',
                                hintText: "${_.user.phone}",
                                fillColor: Color(int.parse(("0xff3D3A3A"))),
                                filled: true,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 20, 510, 5),
                            child: Text(
                              'DESIGNATION',
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Container(
                            width: 600,
                            child: TextFormField(
                              enabled: false,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(int.parse(("0xff3D3A3A"))),
                                      width: 2.0),
                                ),
                                // hintText: '${snapshot.data?.address}',
                                hintText: "${_.user.designation}",
                                fillColor: Color(int.parse(("0xff3D3A3A"))),
                                filled: true,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 20, 510, 5),
                            child: Text(
                              'JOINING DATE',
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Container(
                            width: 600,
                            child: TextFormField(
                              enabled: false,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(int.parse(("0xff3D3A3A"))),
                                      width: 2.0),
                                ),
                                // hintText: '${snapshot.data?.address}',
                                hintText: _.user.joining_date != null
                                    ? "${_.getDateFromTimeStamp(_.user.joining_date!.seconds.toString())}"
                                    : "Date Not set",
                                fillColor: Color(int.parse(("0xff3D3A3A"))),
                                filled: true,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          // Text(
                          //   error,
                          //   style: TextStyle(color: Colors.red, fontSize: 14.0),
                          // ),
                        ],
                      );
                    },
                  ),
                ],
              ),
              // key: _formkey,
            ],
          ),
        ),
      ),
    );

    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: GetX<UserController>(
            init: Get.put<UserController>(UserController()),
            builder: (_) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Name : ${_.user.f_name} ${_.user.l_name}",
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Text(
                    "Email: ${_.user.email}",
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Text(
                    "Phone: ${_.user.phone}",
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  Text(
                    "Designation: ${_.user.designation}",
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  _.user.joining_date != null
                      ? Text(
                          "Joining Date: ${_.getDateFromTimeStamp(_.user.joining_date!.seconds.toString())}",
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.headline5,
                        )
                      : Text("Joining Date : ")
                ],
              );
            },
          ),
        ),
//         Text(
//           '''Name : Document_1.pdf,
// Size : 246kb ,
// File Owner : User_example
// Created : Jan 31, 2021
// Modified : Jun 24, 2021
// Permission : User1, user2 .''',
//           textAlign: TextAlign.left, style: Theme.of(context).textTheme.headline5,
//         ),
      ],
    );
  }
}
