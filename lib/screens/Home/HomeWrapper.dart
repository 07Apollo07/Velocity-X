import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocityx/routes/app_pages.dart';
import 'package:velocityx/screens/FileInformation/file_information.dart';
import 'package:velocityx/screens/Home/constants.dart';
import 'package:velocityx/screens/Home/home.dart';
import 'package:velocityx/screens/metadata/meta_data.dart';

class HomeWrapper extends StatelessWidget {
  const HomeWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Navigator(
        key: Get.nestedKey(Constants.homeId),
        initialRoute: Routes.HOME,
        onGenerateRoute: (routeSettings) {
          // print("inside HomeWrapper");
          // print(routeSettings.name);
          if (routeSettings.name == Routes.HOME) {
            return GetPageRoute(
              routeName: Routes.HOME,
              page: () => Home(),
              maintainState: false,
            );
          } else if (routeSettings.name == Routes.METADATA) {
            return GetPageRoute(
              routeName: Routes.METADATA,
              page: () => MetaDataPage(),
              maintainState: false,
            );
          }
        });
  }
}
