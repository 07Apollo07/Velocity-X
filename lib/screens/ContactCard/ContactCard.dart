import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocityx/assets/custom_icons_icons.dart';
import 'package:velocityx/controllers/authController.dart';
import 'package:velocityx/controllers/metaDataController.dart';
import 'package:velocityx/controllers/userController.dart';
import 'package:velocityx/models/files.dart';
import 'package:velocityx/routes/app_pages.dart';
import 'package:velocityx/shared/constants.dart';
import 'package:velocityx/shared/icon_logo.dart';

class ContactPage extends GetWidget<UserController> {
  String index;
  ContactPage({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      // backgroundColor: Color.fromRGBO(36, 36, 36, 1.0),
      appBar: AppBar(
        leading: BackButton(
          color: Theme.of(context).primaryColor,
        ),
        title:
            Text("Profile Page", style: Theme.of(context).textTheme.headline3),
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
                  AuthController.instance.signOut();
                },
                icon: Icon(Icons.brightness_4_outlined),
                color: Theme.of(context).primaryColor),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.supervised_user_circle,
                  size: 100,
                ),
              ],
            ),
            Column(
              children: [
                GetX<UserController>(
                  init: Get.put<UserController>(UserController()),
                  builder: (_) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('NAME',
                                    textAlign: TextAlign.start,
                                    style:
                                        Theme.of(context).textTheme.headline5),
                                SizedBox(height: 5.0),
                                Container(
                                  width: 400,
                                  child: TextFormField(
                                    enabled: false,
                                    decoration: InputDecoration(
                                      hintText:
                                          "${_.users[int.parse(index)].f_name} ${_.users[int.parse(index)].l_name}",
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(
                                                int.parse(("0xff3D3A3A"))),
                                            width: 2.0),
                                      ),
                                      fillColor:
                                          Color(int.parse(("0xff3D3A3A"))),
                                      filled: true,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('EMAIL',
                                    textAlign: TextAlign.start,
                                    style:
                                        Theme.of(context).textTheme.headline5),
                                SizedBox(height: 5.0),
                                Container(
                                  width: 400,
                                  child: TextFormField(
                                    enabled: false,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(
                                                int.parse(("0xff3D3A3A"))),
                                            width: 2.0),
                                      ),
                                      // hintText: '${snapshot.data?.phoneNumber}',
                                      hintText:
                                          "${_.users[int.parse(index)].email}",
                                      fillColor:
                                          Color(int.parse(("0xff3D3A3A"))),
                                      filled: true,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('PHONE NUMBER',
                                    textAlign: TextAlign.start,
                                    style:
                                        Theme.of(context).textTheme.headline5),
                                SizedBox(height: 5.0),
                                Container(
                                  width: 400,
                                  child: TextFormField(
                                    enabled: false,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(
                                                int.parse(("0xff3D3A3A"))),
                                            width: 2.0),
                                      ),
                                      // hintText: '${snapshot.data?.phoneNumber}',
                                      hintText:
                                          "${_.users[int.parse(index)].phone}",
                                      fillColor:
                                          Color(int.parse(("0xff3D3A3A"))),
                                      filled: true,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('DESIGNATION',
                                    textAlign: TextAlign.start,
                                    style:
                                        Theme.of(context).textTheme.headline5),
                                SizedBox(height: 5.0),
                                Container(
                                  width: 400,
                                  child: TextFormField(
                                    enabled: false,
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(
                                                int.parse(("0xff3D3A3A"))),
                                            width: 2.0),
                                      ),
                                      // hintText: '${snapshot.data?.address}',
                                      hintText:
                                          "${_.users[int.parse(index)].designation}",
                                      fillColor:
                                          Color(int.parse(("0xff3D3A3A"))),
                                      filled: true,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        // Text(
                        //   error,
                        //   style: TextStyle(color: Colors.red, fontSize: 14.0),
                        // ),
                      ],
                    );
                  },
                ),
              ],
              // key: _formkey,
            ),
          ],
        ),
      ),
    ));
  }
}
