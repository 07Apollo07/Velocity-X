import 'dart:html';
import 'package:velocityx/shared/animatednavbar.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:velocityx/assets/custom_icons_icons.dart';
import 'package:velocityx/controllers/wrapperController.dart';
import 'package:velocityx/routes/app_pages.dart';
import 'package:velocityx/screens/FileInformation/file_information.dart';
import 'package:velocityx/screens/Home/HomeWrapper.dart';
import 'package:velocityx/screens/Home/home.dart';
import 'package:velocityx/screens/Organization/OrgdirectoryWrapper.dart';
import 'package:velocityx/screens/Scanner/Scanner.dart';
import 'package:velocityx/screens/UserProfile/profile.dart';
import 'package:velocityx/screens/UserProfile/profileWrapper.dart';
import 'package:velocityx/screens/authenticate/sign_in.dart';
import 'package:velocityx/screens/metadata/meta_data.dart';
import 'package:velocityx/controllers/authController.dart';
import 'package:velocityx/screens/Organization/Orgdirectory.dart';

import 'DocumentCreation/document_creation.dart';

class Wrapper extends StatefulWidget {
  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  PageController page = PageController();

  final iconList = <IconData>[
    CustomIcons.home,
    CustomIcons.bookmark,
    CustomIcons.folder,
    CustomIcons.profile,
  ];

  // final screen = [
  @override
  Widget build(BuildContext context) {
    TextEditingController textController = TextEditingController();
    return GetBuilder<WrapperController>(builder: (controller) {
      return (MediaQuery.of(context).size.width < 600)
          ? Scaffold(
              body: SafeArea(
                child: IndexedStack(
                  index: controller.tabIndex,
                  children: [
                    HomeWrapper(),
                    OrgDirectoryWrapper(),
                    // MetaDataPage(),
                    DocumentCreation(),
                    Profile(),
                    Scanner(),
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton(
                backgroundColor: Theme.of(context).primaryColor,
                child: Icon(
                  Icons.qr_code_scanner_sharp,
                  color:
                      controller.floatingActive ? Colors.white : Colors.black,
                ),
                onPressed: () {
                  controller.changeTabIndex(4);
                  controller.changeFloatingActive(true);
                },
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
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
                                return "Organization";
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
            )
          : Scaffold(
              appBar: AppBar(
                elevation: 0.0,
                title: Image.asset(
                  'assets/images/VelocityX.png',
                  width: 120,
                  fit: BoxFit.fitWidth,
                ),
                actions: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 15.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      shape: BoxShape.circle,
                    ),
                    child: AnimSearchBar(
                      width: 500,
                      color: Color.fromRGBO(36, 36, 36, 1.0),
                      style: TextStyle(),
                      textController: textController,
                      onSuffixTap: () {
                        setState(() {
                          textController.clear();
                        });
                      },
                    ),
                  ),
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
              body: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SideMenu(
                    controller: page,
                    // onDisplayModeChanged: (mode) {
                    //   print(mode);
                    // },
                    style: SideMenuStyle(
                        displayMode: SideMenuDisplayMode.compact,
                        hoverColor: Colors.blue[100],
                        selectedColor: Colors.lightBlue,
                        selectedTitleTextStyle:
                            const TextStyle(color: Colors.white),
                        selectedIconColor: Colors.white,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        backgroundColor: Theme.of(context).primaryColor),
                    items: [
                      SideMenuItem(
                        priority: 0,
                        title: 'Home',
                        onTap: () {
                          page.jumpToPage(0);
                        },
                        icon: const Icon(CustomIcons.home),
                        badgeContent: const Text(
                          '3',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SideMenuItem(
                        priority: 1,
                        title: 'Organization',
                        onTap: () {
                          page.jumpToPage(1);
                        },
                        icon: const Icon(CustomIcons.bookmark),
                      ),
                      SideMenuItem(
                        priority: 2,
                        title: 'Folder',
                        onTap: () {
                          page.jumpToPage(2);
                        },
                        icon: const Icon(CustomIcons.folder),
                      ),
                      SideMenuItem(
                        priority: 3,
                        title: 'Profile',
                        onTap: () {
                          page.jumpToPage(3);
                        },
                        icon: const Icon(CustomIcons.profile),
                      ),
                      SideMenuItem(
                        priority: 4,
                        title: 'Settings',
                        onTap: () {
                          page.jumpToPage(4);
                        },
                        icon: const Icon(Icons.settings),
                      ),
                    ],
                  ),
                  Expanded(
                    child: PageView(
                      controller: page,
                      children: [
                        HomeWrapper(),
                        OrgDirectoryWrapper(),
                        // MetaDataPage(),
                        DocumentCreation(),
                        Profile(),
                        Scanner(),
                      ],
                    ),
                  ),
                ],
              ),
            );
    });
  }
}
