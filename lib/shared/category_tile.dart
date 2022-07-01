import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

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
            Center(
              child: Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.headline5,
                  textAlign: TextAlign.left,
                   overflow: TextOverflow.ellipsis
                ),
              ),
            ),
            SizedBox(
              height: 70,
            ),
            Row(
              children: [
                SizedBox(width: 110),
                Icon(Icons.arrow_forward, color: Theme.of(context).primaryColor),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
