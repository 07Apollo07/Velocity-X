import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocityx/assets/custom_icons_icons.dart';
import 'package:velocityx/controllers/authController.dart';
import 'package:velocityx/controllers/filesController.dart';
import 'package:velocityx/controllers/userController.dart';

// class Profile extends StatefulWidget {
//   @override
//   State<Profile> createState() => _ProfileState();
// }

class Profile extends GetWidget<AuthController> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            leading: Icon(Icons.arrow_back_ios_new_rounded),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    new Text(
                      "User Name",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    new Text(
                      "User info",
                      style: TextStyle(fontSize: 13),
                    ),
                  ],
                ),
              ],
            ),
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
                    icon: Icon(CustomIcons.bell),
                    color: Theme.of(context).primaryColor),
              ),
            ],
            bottom: TabBar(
              tabs: [
                Text(
                  'Informations',
                ),
                Text(
                  'Documents',
                ),
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
    return ListView(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.picture_as_pdf_rounded),
          title: Text("Document_1"),
          subtitle: Text("Assigned By : User_2"),
          onTap: () {},
        )
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
          // initState: (_) async {
          //   print("printing user");
          //   print(Get.find<UserController>().user.email);
          // },
          builder: (_) {
            // print();

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
                Text(
                  "Designation: ${_.user.joining_date}",
                  textAlign: TextAlign.left,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
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
