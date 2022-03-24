import 'package:flutter/material.dart';
import 'package:velocityx/shared/TaskTile.dart';
import 'package:velocityx/shared/category_tile.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var bottomNavIndex = 0; //default index of a first screen

  bool floatingActive = false;
  final Tasks = <TaskTile>[
    TaskTile(task_name: 'Task One', assigned_by: 'John Doe', due_date: '23/10'),
    TaskTile(task_name: 'Task One', assigned_by: 'John Doe', due_date: '23/10'),
    TaskTile(task_name: 'Task One', assigned_by: 'John Doe', due_date: '23/10'),
    TaskTile(task_name: 'Task One', assigned_by: 'John Doe', due_date: '23/10'),
    TaskTile(task_name: 'Task One', assigned_by: 'John Doe', due_date: '23/10'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      backgroundColor: Color.fromRGBO(36, 36, 36, 1.0),
      body: SingleChildScrollView(
        child: Column(
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
              child: const Text(
                "Assigned to You",
                style: TextStyle(color: Colors.white, fontSize: 24),
                textAlign: TextAlign.start,
              ),
            ),
            Column(
              children: [
                TaskTile(
                  task_name: "task_name",
                  assigned_by: "assigned_by",
                  due_date: "due_date",
                ),
                TaskTile(
                    task_name: "task_name",
                    assigned_by: "assigned_by",
                    due_date: "due_date"),
                TaskTile(
                    task_name: "task_name",
                    assigned_by: "assigned_by",
                    due_date: "due_date"),
                TaskTile(
                    task_name: "task_name",
                    assigned_by: "assigned_by",
                    due_date: "due_date"),
                TaskTile(
                    task_name: "task_name",
                    assigned_by: "assigned_by",
                    due_date: "due_date"),
                TaskTile(
                    task_name: "task_name",
                    assigned_by: "assigned_by",
                    due_date: "due_date"),
                TaskTile(
                    task_name: "task_name",
                    assigned_by: "assigned_by",
                    due_date: "due_date"),
                TaskTile(
                    task_name: "task_name",
                    assigned_by: "assigned_by",
                    due_date: "due_date"),
                TaskTile(
                    task_name: "task_name",
                    assigned_by: "assigned_by",
                    due_date: "due_date"),
                TaskTile(
                    task_name: "task_name",
                    assigned_by: "assigned_by",
                    due_date: "due_date"),
                TaskTile(
                    task_name: "task_name",
                    assigned_by: "assigned_by",
                    due_date: "due_date"),
                TaskTile(
                    task_name: "task_name",
                    assigned_by: "assigned_by",
                    due_date: "due_date"),
                TaskTile(
                    task_name: "task_name",
                    assigned_by: "assigned_by",
                    due_date: "due_date"),
                TaskTile(
                    task_name: "task_name",
                    assigned_by: "assigned_by",
                    due_date: "due_date"),
                TaskTile(
                    task_name: "task_name",
                    assigned_by: "assigned_by",
                    due_date: "due_date"),
                TaskTile(
                    task_name: "task_name",
                    assigned_by: "assigned_by",
                    due_date: "due_date"),
                TaskTile(
                    task_name: "task_name",
                    assigned_by: "assigned_by",
                    due_date: "due_date"),
                TaskTile(
                    task_name: "task_name",
                    assigned_by: "assigned_by",
                    due_date: "due_date"),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
