import 'package:flutter/material.dart';
import 'package:velocityx/assets/custom_icons_icons.dart';
import 'package:velocityx/shared/icon_logo.dart';

class MetaDataPage extends StatelessWidget {
  const MetaDataPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        // backgroundColor: Color.fromRGBO(36, 36, 36, 1.0),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 70, 10, 70),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    height: 140.0,
                    width: 340.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        width: 4,
                        color: Theme.of(context).primaryColor,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15.0, 105, 90, 5),
                      child: Text(
                        "Document_1.pdf",
                        style:
                            TextStyle(color: Colors.black, letterSpacing: 1.8),
                      ),
                    )),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'File Properties:',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '''Name : Document_1.pdf,
        Size : 246kb ,
        File Owner : User_example
        Created : Jan 31, 2021
        Modified : Jun 24, 2021
        Permission : User1, user2 .''',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  height: 200,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconLogo(
                        color: Theme.of(context).primaryColor,
                        icon: CustomIcons.search_1),
                    IconLogo(
                        color: Theme.of(context).primaryColor,
                        icon: CustomIcons.bookmark),
                    IconLogo(
                        color: Theme.of(context).primaryColor,
                        icon: CustomIcons.bell),
                    IconLogo(
                        color: Theme.of(context).primaryColor,
                        icon: CustomIcons.home),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
