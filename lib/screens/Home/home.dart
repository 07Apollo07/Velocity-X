import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocityx/assets/custom_icons_icons.dart';
import 'package:velocityx/controllers/authController.dart';
import 'package:velocityx/controllers/filesController.dart';
import 'package:velocityx/routes/app_pages.dart';
import 'package:velocityx/screens/FileInformation/file_information.dart';
import 'package:velocityx/shared/animatednavbar.dart';
import 'package:velocityx/shared/constants.dart';
import 'package:velocityx/shared/TaskTile.dart';
import 'package:velocityx/shared/category_tile.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    TextEditingController textController = TextEditingController();
    return Container(
        child: Scaffold(
      // backgroundColor: Color.fromRGBO(36, 36, 36, 1.0),

      appBar: AppBar(
        backgroundColor: Colors.black38,
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
            ),
            child: AnimSearchBar(
              width: 200,
              color: Theme.of(context).scaffoldBackgroundColor,
              style: TextStyle(),
              textController: textController,
              onSuffixTap: () {
                setState(() {
                  textController.clear();
                });
              },
            ),
          ),
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
                  print("theme changed");
                  if (Get.isDarkMode)
                    Get.changeThemeMode(ThemeMode.light);
                  else
                    Get.changeThemeMode(ThemeMode.dark);
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
              init: Get.find<FilesController>(),
              builder: (FilesController filesController) {
                if (filesController != null &&
                    filesController.assignedFiles.length > 0) {
                  return (MediaQuery.of(context).size.width < 800)
                      ? ListView.builder(
                          itemCount: filesController.assignedFiles.length,
                          itemBuilder: (_, index) {
                            return GestureDetector(
                              onTap: () {
                                Get.toNamed(Routes.METADATA,
                                    id: Constants.homeId,
                                    arguments:
                                        filesController.assignedFiles[index]);
                                // print("sending data");
                                // print(filesController.files[index].files_uniqueId);
                              },
                              child: TaskTile(
                                  //TODO remove assigned_by and due_date after changes to TaskTile
                                  assigned_by: "Random Person",
                                  due_date: "Random date",
                                  filesModel:
                                      filesController.assignedFiles[index]),
                            );
                          },
                        )
                      : GridView.builder(
                          controller: ScrollController(),
                          shrinkWrap: true,
                          itemCount: filesController.assignedFiles.length,
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 780,
                            childAspectRatio: 7 / 1,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                          ),
                          itemBuilder: (_, index) {
                            return GestureDetector(
                                onTap: () {
                                  Get.toNamed(Routes.METADATA,
                                      id: Constants.homeId,
                                      arguments:
                                          filesController.assignedFiles[index]);
                                  // print("sending data");
                                  // print(filesController.files[index].files_uniqueId);
                                },
                                child: Container(
                                  height: 50,
                                  child: TaskTile(
                                      //TODO remove assigned_by and due_date after changes to TaskTile
                                      assigned_by: "Random Person",
                                      due_date: "Random date",
                                      filesModel:
                                          filesController.assignedFiles[index]),
                                ));
                          });
                } else if (filesController.assignedFiles.isEmpty) {
                  return Center(
                      child: Text("No Documents have Been Assigned to you",
                          style: Theme.of(context).textTheme.headline5));
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    ));
  }
}
