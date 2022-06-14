import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:velocityx/assets/custom_icons_icons.dart';
import 'package:velocityx/controllers/authController.dart';

class FileInformation extends StatelessWidget {
  const FileInformation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            color: Theme.of(context).primaryColor,
          ),
          title: Text(
            "File Tracking",
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
          elevation: 0.0,
        ),
        // backgroundColor: Color.fromRGBO(36, 36, 36, 1.0),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(25.0, 20, 25, 40),
          child: Container(
              height: 640.0,
              width: width,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 4,
                  color: Theme.of(context).primaryColor,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(45)),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                child: Center(
                    child: Column(
                  children: [
                    Container(
                        height: 50.0,
                        width: width,
                        decoration: BoxDecoration(
                          // color: Color(0xFF4784F1),
                          color: Theme.of(context).primaryColor,
                          border: Border.all(
                            width: 4,
                            color: Theme.of(context).primaryColor,
                          ),
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40)),
                        ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(8.0, 8, 8, 5),
                          child: Center(
                            child: (width > 800)
                                ? const Text(
                                    'File Tracking Information',
                                    style: TextStyle(
                                        color: Colors.black,
                                        letterSpacing: 1.8,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700),
                                  )
                                : const Text(
                                    'File Tracking Information: File Name ',
                                    style: TextStyle(
                                        color: Colors.black,
                                        letterSpacing: 1.8,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700),
                                  ),
                          ),
                        )),
                    Column(
                      children: [
                        TimelineTile(
                          alignment: TimelineAlign.manual,
                          lineXY: 0.5,
                          beforeLineStyle: LineStyle(
                            color: Theme.of(context).primaryColor,
                            thickness: 6,
                          ),
                          afterLineStyle: LineStyle(
                            color: Theme.of(context).primaryColor,
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
                                    // style: TextStyle(color: Colors.white),
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
                              children: [
                                Icon(
                                  Icons.supervised_user_circle,
                                  color: Theme.of(context).primaryColor,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "User_1",
                                  // style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  Icons.link,
                                  color: Theme.of(context).primaryColor,
                                )
                              ],
                            ),
                          ),
                        ),
                        TimelineTile(
                          alignment: TimelineAlign.manual,
                          lineXY: 0.5,
                          beforeLineStyle: LineStyle(
                            color: Theme.of(context).primaryColor,
                            thickness: 6,
                          ),
                          afterLineStyle: LineStyle(
                            color: Theme.of(context).primaryColor,
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
                                    // style: TextStyle(color: Colors.white),
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
                              children: [
                                Icon(
                                  Icons.supervised_user_circle,
                                  color: Theme.of(context).primaryColor,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "User_2",
                                  // style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  Icons.link,
                                  color: Theme.of(context).primaryColor,
                                )
                              ],
                            ),
                          ),
                        ),
                        TimelineTile(
                          alignment: TimelineAlign.manual,
                          lineXY: 0.5,
                          beforeLineStyle: LineStyle(
                            color: Theme.of(context).primaryColor,
                            thickness: 6,
                          ),
                          afterLineStyle: LineStyle(
                            color: Theme.of(context).primaryColor,
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
                                    // style: TextStyle(color: Colors.white),
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
                              children: [
                                Icon(
                                  Icons.supervised_user_circle,
                                  color: Theme.of(context).primaryColor,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "User_3",
                                  // style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(Icons.link,
                                    color: Theme.of(context).primaryColor)
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
