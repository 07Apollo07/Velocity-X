import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:velocityx/assets/custom_icons_icons.dart';

class BottomNavBar extends StatefulWidget {
  bool floatingActive;
  int bottomNavIndex;
  BottomNavBar(
      {Key? key, required this.bottomNavIndex, required this.floatingActive})
      : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final iconList = <IconData>[
    CustomIcons.home,
    CustomIcons.bookmark,
    CustomIcons.folder,
    CustomIcons.profile,
  ];
  @override
  Widget build(BuildContext context) {
    return AnimatedBottomNavigationBar.builder(
      tabBuilder: (int index, bool isActive) {
        final color =
            isActive && !widget.floatingActive ? Colors.white : Colors.black;
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(iconList[index]),
              onPressed: () {
                if (index == 0) {
                  Navigator.pushNamed(context, "/home");
                }
              },
              iconSize: 24,
              focusColor: color,
              // size: 24,
              color: color,
            ),
            // const SizedBox(height: 2),
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
      backgroundColor: const Color.fromRGBO(71, 132, 241, 1.0),
      activeIndex: widget.bottomNavIndex,
      gapLocation: GapLocation.center,
      notchSmoothness: NotchSmoothness.softEdge,
      leftCornerRadius: 32,
      rightCornerRadius: 32,
      onTap: (index) => setState(() {
        widget.bottomNavIndex = index;
        widget.floatingActive = false;
      }),
    );
  }
}
