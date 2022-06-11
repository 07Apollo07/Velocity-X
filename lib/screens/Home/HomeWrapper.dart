import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocityx/models/files.dart';
import 'package:velocityx/routes/app_pages.dart';
import 'package:velocityx/screens/FileInformation/file_information.dart';
import 'package:velocityx/screens/PdfViewer/pdf_viewer.dart';
import 'package:velocityx/screens/QRCodeGeneration/QrCreator.dart';
import 'package:velocityx/shared/constants.dart';
import 'package:velocityx/screens/Home/home.dart';
import 'package:velocityx/screens/metadata/meta_data.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import '../PdfViewerWeb/pdf_viewer_web.dart';

class HomeWrapper extends StatelessWidget {
  const HomeWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
        key: Get.nestedKey(Constants.homeId),
        initialRoute: Routes.HOME,
        onGenerateRoute: (routeSettings) {
          // print("inside HomeWrapper");
          print("HomeWrapper route stack");
          print(routeSettings.name);
          if (routeSettings.name.toString() == Routes.HOME) {
            return GetPageRoute(
              routeName: Routes.HOME,
              page: () => Home(),
              maintainState: false,
            );
          } else if (routeSettings.name.toString() == Routes.METADATA) {
            return GetPageRoute(
              routeName: Routes.METADATA,
              page: () => MetaDataPage(
                File: routeSettings.arguments as FilesModel,
              ),
              maintainState: false,
            );
          } else if (routeSettings.name.toString() == Routes.FILE_INFORMATION) {
            return GetPageRoute(
              routeName: Routes.FILE_INFORMATION,
              page: () => FileInformation(),
              maintainState: false,
            );
          } else if (routeSettings.name.toString() == Routes.QR_CODE) {
            return GetPageRoute(
              routeName: Routes.QR_CODE,
              page: () => QrCreator(qrCodeOfInput: routeSettings.arguments),
              maintainState: false,
            );
          } else if (routeSettings.name.toString() == Routes.PDFVIEWER) {
            return GetPageRoute(
              routeName: Routes.PDFVIEWER,
              page: () {
                if (kIsWeb) {
                  // It's running on the web!
                  return PdfViewerWeb();
                } else {
                  return Viewer();
                  // NOT running on the web!
                  // You can also check for additional platforms here.
                  // Or you only develop for web and mobile this is mobile
                }
              },
              maintainState: false,
            );
          }
        });
  }
}
