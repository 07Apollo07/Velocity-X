import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocityx/routes/app_pages.dart';
import 'package:velocityx/screens/FileInformation/file_information.dart';
import 'package:velocityx/screens/UserProfile/profile.dart';
import 'package:velocityx/shared/constants.dart';

class ProfileWrapper extends StatelessWidget {
  const ProfileWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
        key: Get.nestedKey(Constants.profileId),
        initialRoute: Routes.PROFILEPAGE,
        onGenerateRoute: (routeSettings) {
          print("OrgDirectoryWrapper route stack");
          print(routeSettings.name);
          if (routeSettings.name.toString() == Routes.PROFILEPAGE) {
            return GetPageRoute(
              routeName: Routes.ORGDIRECTORY,
              page: () => Profile(),
              maintainState: false,
            );
          } else if (routeSettings.name.toString() == Routes.FILE_INFORMATION) {
            return GetPageRoute(
              routeName: Routes.FILE_INFORMATION,
              page: () => FileInformation(),
              maintainState: false,
            );
          }
        });
  }
}
