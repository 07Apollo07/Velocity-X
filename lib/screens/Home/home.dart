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

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // final Tasks = <TaskTile>[
  //   TaskTile(task_name: 'Task One', assigned_by: 'John Doe', due_date: '23/10'),
  //   TaskTile(task_name: 'Task One', assigned_by: 'John Doe', due_date: '23/10'),
  //   TaskTile(task_name: 'Task One', assigned_by: 'John Doe', due_date: '23/10'),
  //   TaskTile(task_name: 'Task One', assigned_by: 'John Doe', due_date: '23/10'),
  //   TaskTile(task_name: 'Task One', assigned_by: 'John Doe', due_date: '23/10'),
  // ];

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      // backgroundColor: Color.fromRGBO(36, 36, 36, 1.0),

      appBar: AppBar(
        elevation: 0.0,
        title: Image.asset(
          'assets/images/VelocityX.png',
          width: 120,
          fit: BoxFit.fitWidth,
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CategoryTile(
                    title: 'Urgent Submission',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CategoryTile(
                    title: 'Urgent Submission',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CategoryTile(
                    title: 'Urgent Submission',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CategoryTile(
                    title: 'Urgent Submission',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CategoryTile(
                    title: 'Urgent Submission',
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Text(
              "Assigned to You",
              style: Theme.of(context).textTheme.headline3,
              textAlign: TextAlign.start,
            ),
          ),
          Expanded(
            child: GetX<FilesController>(
              init: Get.put<FilesController>(FilesController()),
              builder: (FilesController filesController) {
                if (filesController != null &&
                    filesController.files.length > 0) {
                  return ListView.builder(
                    itemCount: filesController.files.length,
                    itemBuilder: (_, index) {
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.METADATA,
                              id: Constants.homeId,
                              arguments: filesController.files[index]);
                          // print("sending data");
                          // print(filesController.files[index].files_uniqueId);
                        },
                        child: TaskTile(
                            //TODO remove assigned_by and due_date after changes to TaskTile
                            assigned_by: "Random Person",
                            due_date: "Random date",
                            filesModel: filesController.files[index]),
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
      ),
    ));
  }
}
