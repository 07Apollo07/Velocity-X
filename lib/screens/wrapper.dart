import 'package:side_navigation/side_navigation.dart';
import 'package:velocityx/screens/PdfViewer/pdf_viewer.dart';
import 'package:velocityx/screens/QRCodeGeneration/QrCreator.dart';
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
import 'package:velocityx/shared/constants.dart';

import 'DocumentCreation/document_creation.dart';
import 'PdfViewerWeb/pdf_viewer_web.dart';
import 'TextEditor/text_editor.dart';

class Wrapper extends StatefulWidget {
  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  PageController page = PageController();

  final iconList = <IconData>[
    CustomIcons.home,
    Icons.people,
    Icons.add_card,
    CustomIcons.profile,
  ];
  List<Widget> views = [
    HomeWrapper(),
    OrgDirectoryWrapper(),
    Scanner(),
    // MetaDataPage(),
    DocumentCreation(),
    ProfileWrapper(),
    // QrCreator(qrCodeOfInput: "Null"),
    // PdfViewerWeb()
    // HtmlEditorExample(title: 'Flutter HTML Editor Example'),
    // Viewer(),
  ];

  /// The currently selected index of the bar
  int selectedIndex = 0;
  // final screen = [
  @override
  Widget build(BuildContext context) {
    TextEditingController textController = TextEditingController();
    if ((context.width <= 800)) {
      print("saw them");
      return GetBuilder<WrapperController>(builder: (controller) {
        final _wrapperId = GlobalKey<ScaffoldState>();
        print("Screen Created small");
        return Scaffold(
          resizeToAvoidBottomInset: false,
          key: _wrapperId,
          body: SafeArea(
            child: IndexedStack(
              index: controller.tabIndex,
              children: [
                HomeWrapper(),
                OrgDirectoryWrapper(),
                // MetaDataPage(),
                DocumentCreation(),
                ProfileWrapper(),
                // PdfViewerWeb(),
                // HtmlEditorExample(title: 'Flutter HTML Editor Example'),
                // Viewer(),
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
                            return "Directory";
                          } else if (index == 2) {
                            return "Create";
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
    } else {
      return GetBuilder<WrapperController>(builder: (controller) {
        final _wrapperId = GlobalKey<ScaffoldState>();
        print("Screen Created big");
        return Scaffold(
          body: Row(
            children: [
              /// Pretty similar to the BottomNavigationBar!
              SideNavigationBar(
                selectedIndex: selectedIndex,
                items: const [
                  SideNavigationBarItem(
                    icon: CustomIcons.home,
                    label: 'Dashboard',
                  ),
                  SideNavigationBarItem(
                    icon: Icons.people,
                    label: 'Directory',
                  ),
                  SideNavigationBarItem(
                    icon: Icons.qr_code_scanner_sharp,
                    label: 'Scanner',
                  ),
                  SideNavigationBarItem(
                    icon: Icons.add_card,
                    label: 'Create Document',
                  ),
                  SideNavigationBarItem(
                    icon: CustomIcons.profile,
                    label: 'Profile',
                  ),
                ],
                onTap: (index) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
              ),

              /// Make it take the rest of the available width
              Expanded(
                child: views.elementAt(selectedIndex),
              )
            ],
          ),
        );
      });
    }
  }
}
