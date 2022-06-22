import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocityx/models/file_stats.dart';
import 'package:velocityx/models/files.dart';
import 'package:velocityx/routes/app_pages.dart';
import 'package:velocityx/screens/DocumentCreation/document_creation.dart';
import 'package:velocityx/screens/DocumentEditing/DocumentEditing.dart';
import 'package:velocityx/screens/FileInformation/file_information.dart';
import 'package:velocityx/screens/QRCodeGeneration/QrCreator.dart';
import 'package:velocityx/screens/UserProfile/profile.dart';
import 'package:velocityx/shared/constants.dart';

import '../PdfViewer/pdf_viewer.dart';
import '../PdfViewerWeb/pdf_viewer_web.dart';

class ProfileWrapper extends StatelessWidget {
  const ProfileWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
        key: Get.nestedKey(Constants.profileId),
        initialRoute: Routes.PROFILEPAGE,
        onGenerateRoute: (routeSettings) {
          print("ProfileWrapper route stack");
          print(routeSettings.name);
          if (routeSettings.name.toString() == Routes.PROFILEPAGE) {
            return GetPageRoute(
              routeName: Routes.PROFILEPAGE,
              page: () => Profile(),
              maintainState: true,
            );
          } else if (routeSettings.name.toString() == Routes.DOC_EDITING) {
            return GetPageRoute(
              routeName: Routes.DOC_EDITING,
              page: () => DocumentEditing(
                File: routeSettings.arguments as FilesModel,
              ),
              maintainState: false,
            );
          } else if (routeSettings.name.toString() == Routes.QR_CODE) {
            return GetPageRoute(
              routeName: Routes.QR_CODE,
              page: () => QrCreator(qrCodeOfInput: routeSettings.arguments),
              maintainState: false,
            );
          } else if (routeSettings.name.toString() == Routes.FILE_INFORMATION) {
            return GetPageRoute(
              routeName: Routes.FILE_INFORMATION,
              page: () => FileInformation(
                FileStat: routeSettings.arguments as FileStatsModel,
              ),
              maintainState: false,
            );
          }else if (routeSettings.name.toString() == Routes.PDFVIEWER) {
            return GetPageRoute(
              routeName: Routes.PDFVIEWER,
              // page: () => MetaDataPage(
              //   File: routeSettings.arguments as FilesModel,
              // ),
              page: () {
                if (kIsWeb) {
                  // It's running on the web!
                  return PdfViewerWeb(
                    document: routeSettings.arguments.toString(),
                  );
                } else {
                  return Viewer(
                    document: routeSettings.arguments.toString(),
                  );

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
