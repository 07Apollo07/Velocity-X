import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:velocityx/models/files.dart';

class TaskTile extends StatelessWidget {
  final String assigned_by, due_date;
  final FilesModel filesModel;

  //TODO fetch username by fileModel.assigned_person_uid and convert it to name and display
  TaskTile(
      {
      // required this.task_name,
      required this.assigned_by,
      required this.due_date,
      required this.filesModel});

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Theme.of(context).scaffoldBackgroundColor,
        shape: StadiumBorder(
          side: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2.0,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(6.0, 12, 6.0, 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.circle,
                color: Color(0xFFA2B9E4),
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    filesModel.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Row(children: [
                    Text(
                      'Assigned by:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Text(filesModel.creator_name)
                  ]),
                ],
              ),
              SizedBox(
                width: 15,
              ),
              Column(
                children: [
                  SizedBox(
                    height: 29,
                  ),
                  Text(
                    'Due by: $due_date',
                    style: TextStyle(color: Color(0xFFA2B9E4)),
                  ),
                ],
              ),
              SizedBox(
                width: 10,
              ),
            ],
          ),
        ));
  }
}
