import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class FileInformation extends StatelessWidget {
  const FileInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(36, 36, 36, 1.0),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(25.0, 70, 25, 40),
          child: Container(
              height: 580.0,
              width: 340.0,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 4,
                  color: Color(0xFF4784F1),
                ),
                borderRadius: BorderRadius.all(Radius.circular(45)),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                child: Center(
                    child: Column(
                  children: [
                    Container(
                        height: 70.0,
                        width: 400.0,
                        decoration: BoxDecoration(
                          color: Color(0xFF4784F1),
                          border: Border.all(
                            width: 4,
                            color: Color(0xFF4784F1),
                          ),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 15, 8, 5),
                          child: Center(
                            child: Text(
                              'File Tracking Information',
                              style: TextStyle(
                                  color: Colors.white,
                                  letterSpacing: 1.8,
                                  fontSize: 17),
                            ),
                          ),
                        )),
                    Column(
                      children: [
                        TimelineTile(
                          alignment: TimelineAlign.manual,
                          lineXY: 0.5,
                          beforeLineStyle: const LineStyle(
                            color: Color(0xFF4784F1),
                            thickness: 6,
                          ),
                          afterLineStyle: const LineStyle(
                            color: Color(0xFF4784F1),
                            thickness: 6,
                          ),
                          startChild: Padding(
                            padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                            child: Container(
                              constraints: const BoxConstraints(
                                minHeight: 30,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Text(
                                    "Jan 31, 2021",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          endChild: Container(
                            constraints: const BoxConstraints(
                              minHeight: 90,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.supervised_user_circle,
                                  color: Color(0xFF4784F1),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "User_1",
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  Icons.link,
                                  color: Color(0xFF4784F1),
                                )
                              ],
                            ),
                          ),
                        ),
                        TimelineTile(
                          alignment: TimelineAlign.manual,
                          lineXY: 0.5,
                          beforeLineStyle: const LineStyle(
                            color: Color(0xFF4784F1),
                            thickness: 6,
                          ),
                          afterLineStyle: const LineStyle(
                            color: Color(0xFF4784F1),
                            thickness: 6,
                          ),
                          startChild: Padding(
                            padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                            child: Container(
                              constraints: const BoxConstraints(
                                minHeight: 30,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Text(
                                    "Jan 31, 2021",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          endChild: Container(
                            constraints: const BoxConstraints(
                              minHeight: 90,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.supervised_user_circle,
                                  color: Color(0xFF4784F1),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "User_2",
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  Icons.link,
                                  color: Color(0xFF4784F1),
                                )
                              ],
                            ),
                          ),
                        ),
                        TimelineTile(
                          alignment: TimelineAlign.manual,
                          lineXY: 0.5,
                          beforeLineStyle: const LineStyle(
                            color: Color(0xFF4784F1),
                            thickness: 6,
                          ),
                          afterLineStyle: const LineStyle(
                            color: Color(0xFF4784F1),
                            thickness: 6,
                          ),
                          startChild: Padding(
                            padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                            child: Container(
                              constraints: const BoxConstraints(
                                minHeight: 30,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  Text(
                                    "Feb 31, 2021",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          endChild: Container(
                            constraints: const BoxConstraints(
                              minHeight: 90,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.supervised_user_circle,
                                  color: Color(0xFF4784F1),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "User_3",
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  Icons.link,
                                  color: Color(0xFF4784F1),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
              )),
        ),
      ),
    );
  }
}
