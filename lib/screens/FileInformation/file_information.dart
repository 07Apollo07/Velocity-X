import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:velocityx/assets/custom_icons_icons.dart';
import 'package:velocityx/controllers/authController.dart';
import 'package:velocityx/controllers/fileInformationController.dart';
import 'package:velocityx/models/file_stats.dart';

class FileInformation extends StatelessWidget {
  final FileStatsModel FileStat;
  const FileInformation({Key? key, required this.FileStat}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<FileInformationController>(
        init: Get.put<FileInformationController>(FileInformationController()),
        builder: (controller) {
          if (controller.initialized == false) {
            controller.initializeFilesModel(FileStat);
            controller.initialized = true;
          }
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
                          Expanded(
                            child: _TimelineActivity(
                                FileStats: controller.FilesModel),
                          ),
                        ],
                      )),
                    )),
              ),
            ),
          );
        });
  }
}

class _TimelineActivity extends StatelessWidget {
  const _TimelineActivity({
    Key? key,
    required this.FileStats,
  }) : super(key: key);

  final FileStatsModel FileStats;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: FileStats.tracking?.length,
      itemBuilder: (BuildContext context, int index) {
        // String OperationType =
        //     FileStats.tracking![index].runtimeType.toString();
        Map<String, dynamic> Operation = FileStats.tracking![index];

        // final IndicatorStyle indicator = step.isCheckpoint
        //     ? _indicatorStyleCheckpoint(step)
        //     : const IndicatorStyle(width: 0);

        final IndicatorStyle indicator = const IndicatorStyle(width: 0);

        final righChild = _RightChildTimeline(
          FileStats: Operation,
        );
        final leftChild = _LeftChildTimeline(
          FileStats: Operation,
        );

        return TimelineTile(
          alignment: TimelineAlign.manual,
          isFirst: index == 0,
          isLast: index == (FileStats.tracking?.length ?? 1) - 1,
          lineXY: 0.5,
          indicatorStyle: indicator,
          startChild: leftChild,
          endChild: righChild,
          // hasIndicator: step.isCheckpoint,
          beforeLineStyle: LineStyle(
            color: Theme.of(context).primaryColor,
            thickness: 8,
          ),
        );
      },
    );
  }
}

class _LeftChildTimeline extends StatelessWidget {
  const _LeftChildTimeline({Key? key, required this.FileStats})
      : super(key: key);
  final Map<String, dynamic> FileStats;
  @override
  Widget build(BuildContext context) {
    String RunTypeType;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[Text(getLeftText(FileStats))],
    );
  }
}

String getRightText(Map<String, dynamic> FileStats) {
  if (FileStats["Operation"] == "Transfer") {
    String message =
        "File Transferred from " + FileStats["From"] + " to " + FileStats["To"];
    return message;
  } else if (FileStats["Operation"] == "Creation") {
    String message = "File Created by " + FileStats["By"];
    return message;
  } else if (FileStats["Operation"] == "Opened") {
    String message = "File Opened by " + FileStats["User"];
    return message;
  }
  return "";
}

String getLeftText(Map<String, dynamic> FileStats) {
  String message = FileStats["Time"].toString();
  return message;
}

class _RightChildTimeline extends StatelessWidget {
  const _RightChildTimeline({Key? key, required this.FileStats})
      : super(key: key);

  final Map<String, dynamic> FileStats;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 29),
          child: Text(getRightText(FileStats)
              // style: GoogleFonts.patrickHand(
              //   fontSize: 16,
              //   color: Colors.white.withOpacity(0.6),
              // ),
              ),
        )
      ],
    );
  }
}
