import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryTile extends StatelessWidget {
  String title;
  CategoryTile({required this.title});

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Container(
        height: 150.0,
        width: 150.0,
        decoration: BoxDecoration(
          border: Border.all(
            width: 3,
            color: Theme.of(context).primaryColor,
          ),
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 20),
                Text(title,
                    style: GoogleFonts.josefinSans(
                        textStyle: TextStyle(
                            fontSize: 24,
                            color: Theme.of(context).secondaryHeaderColor)),
                    // textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
