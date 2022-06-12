import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocityx/assets/custom_icons_icons.dart';
import 'package:velocityx/controllers/authController.dart';
import 'package:velocityx/controllers/filesController.dart';
import 'package:velocityx/controllers/userController.dart';
import 'package:velocityx/routes/app_pages.dart';
import 'package:velocityx/screens/FileInformation/file_information.dart';
import 'package:velocityx/shared/constants.dart';
import 'package:velocityx/shared/TaskTile.dart';
import 'package:velocityx/shared/category_tile.dart';

class Organization extends StatefulWidget {
  @override
  State<Organization> createState() => _OrganizationState();
}

class _OrganizationState extends State<Organization> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            // leading: Icon(Icons.arrow_back_ios_new_rounded),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    new Text(
                      "Organization Name",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    new Text(
                      "Organization Code",
                      style: TextStyle(fontSize: 13),
                    ),
                  ],
                ),
              ],
            ),
            bottom: TabBar(
              tabs: [
                Tab(text: 'Informations'),
                Tab(text: 'Employees'),
              ],
            ),
          ),
          body: TabBarView(children: [
            UserInfo(),
            OrganizationDoc(),
          ]),
        ));
  }
}

class OrganizationDoc extends StatelessWidget {
  const OrganizationDoc({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GetX<UserController>(
            init: Get.find<UserController>(),
            builder: (UserController userController) {
              if (userController != null && userController.users.length > 0) {
                return ListView.builder(
                  itemCount: userController.users.length,
                  itemBuilder: (_, index) {
                    return ListTile(
                      //TODO remove assigned_by and due_date after changes to TaskTile
                      leading: Icon(Icons.account_circle_outlined),
                      title: Text(userController.users[index].f_name +
                          " " +
                          userController.users[index].l_name),
                      subtitle: Text(userController.users[index].designation),
                      onTap: () {
                        Get.toNamed(
                          Routes.CONTACT_CARD,
                          id: Constants.orgDirectoryId,
                        );
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

class UserInfo extends StatelessWidget {
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
        Text(
          '''Name : Organization_1,
Number of people : 24 ,
Owner : User_example
Created : Jan 31, 2021
Admins : User1, user2 .''',
          textAlign: TextAlign.left,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ],
    );
  }
}
