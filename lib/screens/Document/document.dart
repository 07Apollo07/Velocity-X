import 'package:flutter/material.dart';
import 'package:velocityx/assets/custom_icons_icons.dart';
import 'package:velocityx/shared/icon_logo.dart';

class Document extends StatelessWidget {
  const Document({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      backgroundColor: Color.fromRGBO(36, 36, 36, 1.0),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Add Document'),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(36, 36, 36, 1.0),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 70, 10, 70),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 12, 15, 12),
                  child: Row(
                    children: [
                      Icon(
                        Icons.account_circle_sharp,
                        color: Colors.blue,
                        size: 100.0,
                        semanticLabel:
                            'Text to announce in accessibility modes',
                      ),
                      SizedBox(
                        height: 15,
                        width: 100,
                      ),
                      Text(
                        'Demo_user',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Information',
                style: TextStyle(color: Colors.white, fontSize: 20),
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
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              SizedBox(
                height: 280,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconLogo(
                      color: Color(0xFF4784F1), icon: CustomIcons.search_1),
                  IconLogo(
                      color: Color(0xFF4784F1), icon: CustomIcons.bookmark),
                  IconLogo(color: Color(0xFF4784F1), icon: CustomIcons.bell),
                  IconLogo(color: Color(0xFF4784F1), icon: CustomIcons.home),
                ],
              )
            ],
          ),
        ),
      ),
    ));
  }
}
