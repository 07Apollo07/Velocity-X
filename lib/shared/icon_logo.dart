import 'package:velocityx/assets/custom_icons_icons.dart';
import 'package:flutter/material.dart';

class IconLogo extends StatelessWidget {
  Color color;
  var icon;

  IconLogo({required this.color, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
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
            onPressed: () {},
            icon: Icon(
              icon,
              color: color,
            )));
  }
}
