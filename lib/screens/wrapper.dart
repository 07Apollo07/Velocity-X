import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:velocityx/assets/custom_icons_icons.dart';
import 'package:velocityx/controllers/wrapperController.dart';
import 'package:velocityx/screens/FileInformation/file_information.dart';
import 'package:velocityx/screens/Home/home.dart';
import 'package:velocityx/screens/Scanner/Scanner.dart';
import 'package:velocityx/screens/authenticate/sign_in.dart';
import 'package:velocityx/screens/metadata/meta_data.dart';
import 'package:velocityx/controllers/authController.dart';

import 'Profile/profile.dart';

class Wrapper extends StatelessWidget {
  final iconList = <IconData>[
    CustomIcons.home,
    CustomIcons.bookmark,
    CustomIcons.folder,
    CustomIcons.profile,
  ];

  final screen = [
    Home(),
    FileInformation(),
    MetaDataPage(),
    // Scanner(),
    Profile()
    // Scanner(),
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WrapperController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          actions: <Widget>[
            Container(
                margin: EdgeInsets.only(right: 15.0),
                decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).primaryColor,
                        blurRadius: 5.0,
                      ),
                    ]),
                child: IconButton(
                    onPressed: () {
                      // Navigator.pushNamed(context, '/MetaData');
                    },
                    icon: Icon(CustomIcons.search_1),
                    color: Theme.of(context).primaryColor)),
            Container(
              margin: EdgeInsets.only(right: 15.0),
              decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).primaryColor,
                      blurRadius: 5.0,
                    ),
                  ]),
              child: IconButton(
                  onPressed: () {
                    AuthController.instance.signOut();
                  },
                  icon: Icon(CustomIcons.bell),
                  color: Theme.of(context).primaryColor),
            ),
          ],
        ),
        body: SafeArea(
          child: IndexedStack(
            index: controller.tabIndex,
            children: [
              Home(),
              FileInformation(),
              MetaDataPage(),
              // Scanner(),
              Profile(),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(
            Icons.qr_code_scanner_sharp,
            color: controller.floatingActive ? Colors.white : Colors.black,
          ),
          onPressed: () {
            controller.tabIndex = 5;
            controller.floatingActive = !controller.floatingActive;
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: AnimatedBottomNavigationBar.builder(
            tabBuilder: (int index, bool isActive) {
              final color = isActive && !controller.floatingActive
                  ? Colors.white
                  : Colors.black;
              return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    iconList[index],
                    size: 24,
                    color: color,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      (() {
                        if (index == 0) {
                          return "Home";
                        } else if (index == 1) {
                          return "Saved";
                        } else if (index == 2) {
                          return "Folder";
                        } else if (index == 3) {
                          return "Profile";
                        }
                        return "out of bounds";
                      }()),
                      maxLines: 1,
                      style: TextStyle(color: color),
                    ),
                  )
                ],
              );
            },
            itemCount: iconList.length,
            backgroundColor: Theme.of(context).primaryColor,
            activeIndex: controller.tabIndex,
            gapLocation: GapLocation.center,
            notchSmoothness: NotchSmoothness.softEdge,
            leftCornerRadius: 32,
            rightCornerRadius: 32,
            onTap: (index) => {controller.changeTabIndex(index)}),
      );
    });
  }
}
