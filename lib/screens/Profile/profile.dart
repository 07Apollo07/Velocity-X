import 'package:flutter/material.dart';
import 'package:velocityx/assets/custom_icons_icons.dart';
import 'package:velocityx/shared/icon_logo.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
          // backgroundColor: Theme.of(context).primaryColor,
          // appBar: AppBar(
          //   leading: IconButton(
          //     icon: Icon(Icons.arrow_back, color: Colors.white),
          //     onPressed: () => Navigator.of(context).pop(),
          //   ),
          //   title: Text('User Information'),
          //   centerTitle: true,
          //   backgroundColor: Color.fromRGBO(36, 36, 36, 1.0),
          // ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 10, 70),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(12, 25, 15, 12),
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
                            width: 60,
                          ),
                          Text(
                            'Demo_user',
                            style:TextStyle(color: Colors.black, fontSize: 22,fontWeight: FontWeight. bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  // DefaultTabController(
                  //   length: 3,
                  //   child: Scaffold(
                  //     appBar: AppBar(
                  //       bottom: const TabBar(
                  //         tabs: [
                  //           Tab(icon: Icon(Icons.directions_car)),
                  //           Tab(icon: Icon(Icons.directions_transit)),
                  //           Tab(icon: Icon(Icons.directions_bike)),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Row(
                    children: [

                      TextButton(
                        onPressed: () {  },
                        child: Text(
                          'Information',
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),

                      ),
                      SizedBox(width: 10,),
                      TextButton(
                        onPressed: () {  },
                        child: Text(
                          'Documents',
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        ),

                      ),


                    ],
                  ),
                  Divider(
                    color: Colors.grey,

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
                    style: TextStyle(color: Colors.black, fontSize: 16),
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