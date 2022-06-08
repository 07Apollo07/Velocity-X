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
import 'package:velocityx/screens/Scanner/Scanner.dart';
import 'package:velocityx/screens/UserProfile/profile.dart';
import 'package:velocityx/screens/authenticate/sign_in.dart';
import 'package:velocityx/screens/metadata/meta_data.dart';
import 'package:velocityx/controllers/authController.dart';
import 'package:velocityx/screens/Organization/Orgdirectory.dart';

class Wrapper extends StatelessWidget {
  PageController page = PageController();
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
      return (MediaQuery.of(context).size.width < 600)
          ? Scaffold(
              body: SafeArea(
                child: IndexedStack(
                  index: controller.tabIndex,
                  children: [
                    HomeWrapper(),
                    Organization(),
                    // MetaDataPage(),
                    FileInformation(),
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
                title: Text("widget"),
                centerTitle: true,
              ),
              body: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SideMenu(
                    controller: page,
                    onDisplayModeChanged: (mode) {
                      print(mode);
                    },
                    style: SideMenuStyle(
                      displayMode: SideMenuDisplayMode.auto,
                      hoverColor: Colors.blue[100],
                      selectedColor: Colors.lightBlue,
                      selectedTitleTextStyle:
                          const TextStyle(color: Colors.white),
                      selectedIconColor: Colors.white,
                      // decoration: BoxDecoration(
                      //   borderRadius: BorderRadius.all(Radius.circular(10)),
                      // ),
                      // backgroundColor: Colors.blueGrey[700]
                    ),
                    title: Column(
                      children: [
                        ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxHeight: 150,
                            maxWidth: 150,
                          ),
                          child: Image.asset(
                            'assets/images/easy_sidemenu.png',
                          ),
                        ),
                        const Divider(
                          indent: 8.0,
                          endIndent: 8.0,
                        ),
                      ],
                    ),
                    footer: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'mohada',
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    items: [
                      SideMenuItem(
                        priority: 0,
                        title: 'Dashboard',
                        onTap: () {
                          page.jumpToPage(0);
                        },
                        icon: const Icon(Icons.home),
                        badgeContent: const Text(
                          '3',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SideMenuItem(
                        priority: 1,
                        title: 'Users',
                        onTap: () {
                          page.jumpToPage(1);
                        },
                        icon: const Icon(Icons.supervisor_account),
                      ),
                      SideMenuItem(
                        priority: 2,
                        title: 'Files',
                        onTap: () {
                          page.jumpToPage(2);
                        },
                        icon: const Icon(Icons.file_copy_rounded),
                      ),
                      SideMenuItem(
                        priority: 3,
                        title: 'Download',
                        onTap: () {
                          page.jumpToPage(3);
                        },
                        icon: const Icon(Icons.download),
                      ),
                      SideMenuItem(
                        priority: 4,
                        title: 'Settings',
                        onTap: () {
                          page.jumpToPage(4);
                        },
                        icon: const Icon(Icons.settings),
                      ),
                      SideMenuItem(
                        priority: 6,
                        title: 'Exit',
                        onTap: () async {},
                        icon: const Icon(Icons.exit_to_app),
                      ),
                    ],
                  ),
                  Expanded(
                    child: PageView(
                      controller: page,
                      children: [
                        Container(
                          color: Colors.white,
                          child: const Center(
                            child: Text(
                              'Dashboard',
                              style: TextStyle(fontSize: 35),
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          child: const Center(
                            child: Text(
                              'Users',
                              style: TextStyle(fontSize: 35),
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          child: const Center(
                            child: Text(
                              'Files',
                              style: TextStyle(fontSize: 35),
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          child: const Center(
                            child: Text(
                              'Download',
                              style: TextStyle(fontSize: 35),
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          child: const Center(
                            child: Text(
                              'Settings',
                              style: TextStyle(fontSize: 35),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
    });
  }
}
