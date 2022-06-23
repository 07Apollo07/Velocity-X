import 'package:flutter/cupertino.dart';
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
                      title: Text(filesController.createdFiles[index].name,
                          style: Theme.of(context).textTheme.headline5),
                      subtitle: Text(
                        "${getEmailFromUidList(filesController.createdFiles[index].assigned_person_uid).toString().replaceAll("[", "").replaceAll("]", "")}",
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      onTap: () {
                        Get.toNamed(Routes.DOC_EDITING,
                            id: Constants.profileId,
                            arguments: filesController.createdFiles[index]);
                      },
                    );
                  },
                );
              } else if (filesController.createdFiles.isEmpty) {
                return Center(
                  child: Text(
                    "You have not created any Files",
                    style: Theme.of(context).textTheme.headline5,
                  ),
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
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'NAME',
                                      textAlign: TextAlign.start,
                                      style:
                                          Theme.of(context).textTheme.headline5,
                                    ),
                                    SizedBox(height: 5.0),
                                    Container(
                                      width: 400,
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
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Email',
                                      textAlign: TextAlign.start,
                                      style:
                                          Theme.of(context).textTheme.headline5,
                                    ),
                                    Container(
                                      width: 400,
                                      child: TextFormField(
                                        enabled: false,
                                        decoration: InputDecoration(
                                          hintText: "${_.user.email}",
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
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'PHONE NUMBER',
                                      textAlign: TextAlign.start,
                                      style:
                                          Theme.of(context).textTheme.headline5,
                                    ),
                                    Container(
                                      width: 400,
                                      child: TextFormField(
                                        enabled: false,
                                        decoration: InputDecoration(
                                          hintText: "${_.user.phone}",
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
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'DESIGNATION',
                                      textAlign: TextAlign.start,
                                      style:
                                          Theme.of(context).textTheme.headline5,
                                    ),
                                    Container(
                                      width: 400,
                                      child: TextFormField(
                                        enabled: false,
                                        decoration: InputDecoration(
                                          hintText: "${_.user.designation}",
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
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'JOINING DATE',
                                      textAlign: TextAlign.start,
                                      style:
                                          Theme.of(context).textTheme.headline5,
                                    ),
                                    Container(
                                      width: 400,
                                      child: TextFormField(
                                        enabled: false,
                                        decoration: InputDecoration(
                                          hintText: _.user.joining_date != null
                                              ? "${_.getDateFromTimeStamp(_.user.joining_date!.seconds.toString())}"
                                              : "Date Not set",
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
                              ],
                            ),
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
  }
}
