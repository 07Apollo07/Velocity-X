import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocityx/assets/custom_icons_icons.dart';
import 'package:velocityx/controllers/authController.dart';
import 'package:velocityx/controllers/filesController.dart';
import 'package:velocityx/routes/app_pages.dart';
import 'package:velocityx/screens/FileInformation/file_information.dart';
import 'package:velocityx/screens/Home/constants.dart';
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
            leading: Icon(Icons.arrow_back_ios_new_rounded),
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
                Tab(text: 'Informations'),
                Tab(text: 'Participants'),
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
    return ListView(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.account_circle_outlined),
          title: Text("User_1"),
          subtitle: Text("Position : Juniour Software Developer"),
          onTap: () {},
        )
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
