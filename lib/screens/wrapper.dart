import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velocityx/assets/custom_icons_icons.dart';
import 'package:velocityx/screens/FileInformation/file_information.dart';
import 'package:velocityx/screens/Home/home.dart';
import 'package:velocityx/screens/Scanner/Scanner.dart';
import 'package:velocityx/screens/authenticate/sign_in.dart';
import 'package:velocityx/screens/metadata/meta_data.dart';
import 'package:velocityx/services/auth.dart';

import '../models/user.dart';
import 'authenticate/sign_in.dart';

class Wrapper extends StatefulWidget {
  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  final AuthService _auth = AuthService();

  var _bottomNavIndex = 0;
  //default index of a first screen
  bool _floatingActive = false;

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
    Scanner(),
  ];

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);

    // return either the Home or Authenticate widget
    if (user == null) {
      return SignIn();
    } else {
    return Scaffold(
        // backgroundColor: Color.fromRGBO(36, 36, 36, 1.0),
        appBar: AppBar(
          // backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
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
                    _auth.signOut();
                  },
                  icon: Icon(CustomIcons.bell),
                  color: Theme.of(context).primaryColor),
            ),
          ],
        ),
        body: screen[_bottomNavIndex],
        // floatingActionButton: FloatingButton(
        //   floatingActive: floatingActive,
        // ),
        // bottomNavigationBar: BottomNavBar(
        //   bottomNavIndex: bottomNavIndex,
        //   floatingActive: floatingActive,
        // ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(
            Icons.qr_code_scanner_sharp,
            color: _floatingActive ? Colors.white : Colors.black,
          ),
          onPressed: () {
            _floatingActive = !_floatingActive;
            // Navigator.pushNamed(context, '/Scanner');
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => Scanner()));
            setState(() {});
            // _bottomNavIndex = 5;
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: AnimatedBottomNavigationBar.builder(
          tabBuilder: (int index, bool isActive) {
            final color =
                isActive && !_floatingActive ? Colors.white : Colors.black;
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
          activeIndex: _bottomNavIndex,
          gapLocation: GapLocation.center,
          notchSmoothness: NotchSmoothness.softEdge,
          leftCornerRadius: 32,
          rightCornerRadius: 32,
          onTap: (index) => setState(() {
            _bottomNavIndex = index;
            _floatingActive = false;
          }),
        ));
  }
  }
}
