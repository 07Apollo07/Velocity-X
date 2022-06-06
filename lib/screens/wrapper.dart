import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:velocityx/assets/custom_icons_icons.dart';
import 'package:velocityx/controllers/wrapperController.dart';
import 'package:velocityx/routes/app_pages.dart';
import 'package:velocityx/screens/FileInformation/file_information.dart';
import 'package:velocityx/screens/Home/HomeWrapper.dart';
import 'package:velocityx/screens/Home/home.dart';
import 'package:velocityx/screens/Scanner/Scanner.dart';
import 'package:velocityx/screens/authenticate/sign_in.dart';
import 'package:velocityx/screens/metadata/meta_data.dart';
import 'package:velocityx/controllers/authController.dart';
import 'package:velocityx/screens/UserProfie/profile.dart';

class Wrapper extends StatelessWidget {
  final iconList = <IconData>[
    CustomIcons.home,
    CustomIcons.bookmark,
    CustomIcons.folder,
    CustomIcons.profile,
  ];

  // final screen = [
  //   Home(),
  //   FileInformation(),
  //   MetaDataPage(),
  //   Scanner(),
  //   // Scanner(),
  // ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<WrapperController>(builder: (controller) {
      return Scaffold(
        body: SafeArea(
          child: IndexedStack(
            index: controller.tabIndex,
            children: [
              HomeWrapper(),
              FileInformation(),
              MetaDataPage(),
              Profile(),
              Scanner(),
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
            controller.changeTabIndex(4);
            controller.changeFloatingActive(true);
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
            onTap: (index) => {
                  controller.changeTabIndex(index),
                  controller.changeFloatingActive(false)
                }),
      );
    });
  }
}
