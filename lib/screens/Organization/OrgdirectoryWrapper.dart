import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocityx/routes/app_pages.dart';
import 'package:velocityx/screens/ContactCard/ContactCard.dart';
import 'package:velocityx/screens/FileInformation/file_information.dart';
import 'package:velocityx/screens/Organization/Orgdirectory.dart';
import 'package:velocityx/screens/metadata/meta_data.dart';
import 'package:velocityx/shared/constants.dart';

class OrgDirectoryWrapper extends StatelessWidget {
  const OrgDirectoryWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
        key: Get.nestedKey(Constants.orgDirectoryId),
        initialRoute: Routes.ORGDIRECTORY,
        onGenerateRoute: (routeSettings) {
          print("OrgDirectoryWrapper route stack");
          print(routeSettings.name);
          if (routeSettings.name.toString() == Routes.ORGDIRECTORY) {
            return GetPageRoute(
              routeName: Routes.ORGDIRECTORY,
              page: () => Organization(),
              maintainState: true,
            );
          } else if (routeSettings.name.toString() == Routes.CONTACT_CARD) {
            return GetPageRoute(
              routeName: Routes.CONTACT_CARD,
              page: () => ContactPage(),
              maintainState: false,
            );
          }
        });
  }
}
