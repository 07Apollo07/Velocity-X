import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocityx/controllers/scannerController.dart';
import 'package:velocityx/models/files.dart';
import 'package:velocityx/screens/Scanner/Scanner.dart';
import 'package:velocityx/screens/metadata/meta_data.dart';
import 'package:velocityx/services/filesDb.dart';

class ScannerLoad extends GetWidget<ScannerV2Controller> {
  @override
  Widget build(BuildContext context) {
    Future<FilesModel> fetchFile() => FilesDb().GetFile(controller.Code, true);
    return FutureBuilder<FilesModel>(
        future: fetchFile(),
        builder: (context, AsyncSnapshot<FilesModel> file) {
          controller.setCode("");
          controller.setResult("");
          if (file.hasData) {
            if (file.data?.files_uniqueId != "Not Found") {
              return MetaDataPage(File: file.requireData);
            } else {
              return Scaffold(
                body: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text("File Not Found"),
                  ),
                ),
              );
            }
          } else {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          }
        });
  }
}
