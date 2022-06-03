import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocityx/controllers/filesController.dart';
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
                if (filesController != null && filesController.files != null) {
                  return ListView.builder(
                    itemCount: filesController.files.length,
                    itemBuilder: (_, index) {
                      return TaskTile(
                          //TODO remove assigned_by and due_date after changes to TaskTile
                          assigned_by: "Random Person",
                          due_date: "Random date",
                          filesModel: filesController.files[index]);
                    },
                  );
                } else {
                  return Text("loading...");
                }
              },
            ),
          )
        ],
      ),
    ));
  }
}
