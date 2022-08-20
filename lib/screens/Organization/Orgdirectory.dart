import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocityx/assets/custom_icons_icons.dart';
import 'package:velocityx/controllers/authController.dart';
import 'package:velocityx/controllers/filesController.dart';
import 'package:velocityx/controllers/organizationController.dart';
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
                    Text(
                      "Organization Name",
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    Text(
                      "Organization Code",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ],
                ),
              ],
            ),
            bottom: TabBar(
              tabs: const [
                Tab(text: 'Informations'),
                Tab(text: 'Employees'),
              ],
              labelColor: Theme.of(context).secondaryHeaderColor,
            ),
          ),
          body: const TabBarView(children: [
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
              if (userController.user.organization_no != "00") {
                if (userController != null && userController.users.length > 0) {
                  return ListView.builder(
                    itemCount: userController.users.length,
                    itemBuilder: (_, index) {
                      return ListTile(
                        //TODO remove assigned_by and due_date after changes to TaskTile
                        leading: const Icon(Icons.account_circle_outlined),
                        title: Text(
                          userController.users[index].f_name +
                              " " +
                              userController.users[index].l_name,
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        subtitle: Text(
                          userController.users[index].designation,
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        onTap: () {
                          Get.toNamed(
                            Routes.CONTACT_CARD,
                            id: Constants.orgDirectoryId,
                            arguments: index,
                          );
                        },
                      );
                    },
                  );
                } else {
                  return const Center(child: const CircularProgressIndicator());
                }
              } else {
                return Center(
                    child: Text(
                  "Please ask your Employer to add you to their organization",
                  style: Theme.of(context).textTheme.headline5,
                ));
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
    return GetX<OrganizationController>(
        init: Get.put<OrganizationController>(OrganizationController()),
        builder: (OrganizationController controller) {
          if (!controller.initialized) {
            controller.fetchInfo();
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("NAME",
                          textAlign: TextAlign.start,
                          style: Theme.of(context).textTheme.headline5),
                      SizedBox(height: 5.0),
                      Container(
                        width: 400,
                        child: TextFormField(
                          enabled: false,
                          decoration: InputDecoration(
                            hintText: controller.orgModel.value.orgName,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(int.parse(("0xff3D3A3A"))),
                                  width: 2.0),
                            ),
                            fillColor: Color(int.parse(("0xff3D3A3A"))),
                            filled: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Number of people',
                          textAlign: TextAlign.start,
                          style: Theme.of(context).textTheme.headline5),
                      SizedBox(height: 5.0),
                      Container(
                        width: 400,
                        child: TextFormField(
                          enabled: false,
                          decoration: InputDecoration(
                            hintText: Get.find<UserController>()
                                .users
                                .length
                                .toString(),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(int.parse(("0xff3D3A3A"))),
                                  width: 2.0),
                            ),
                            fillColor: Color(int.parse(("0xff3D3A3A"))),
                            filled: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Owner',
                          textAlign: TextAlign.start,
                          style: Theme.of(context).textTheme.headline5),
                      SizedBox(height: 5.0),
                      Container(
                        width: 400,
                        child: TextFormField(
                          enabled: false,
                          decoration: InputDecoration(
                            hintText: "User_example",
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(int.parse(("0xff3D3A3A"))),
                                  width: 2.0),
                            ),
                            fillColor: Color(int.parse(("0xff3D3A3A"))),
                            filled: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Created',
                          textAlign: TextAlign.start,
                          style: Theme.of(context).textTheme.headline5),
                      SizedBox(height: 5.0),
                      Container(
                        width: 400,
                        child: TextFormField(
                          enabled: false,
                          decoration: InputDecoration(
                            hintText: controller
                                .orgModel.value.creation_datetime
                                .toString(),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(int.parse(("0xff3D3A3A"))),
                                  width: 2.0),
                            ),
                            fillColor: Color(int.parse(("0xff3D3A3A"))),
                            filled: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Admins',
                          textAlign: TextAlign.start,
                          style: Theme.of(context).textTheme.headline5),
                      SizedBox(height: 5.0),
                      Container(
                        width: 400,
                        child: TextFormField(
                          enabled: false,
                          decoration: InputDecoration(
                            hintText:
                                controller.orgModel.value.admins_uid.toString(),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(int.parse(("0xff3D3A3A"))),
                                  width: 2.0),
                            ),
                            fillColor: Color(int.parse(("0xff3D3A3A"))),
                            filled: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
            ],
          );
        });
  }
}
