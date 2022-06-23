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
          title: Text("Profile Page",
              style: Theme.of(context).textTheme.headline3),
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
                  icon: Icon(CustomIcons.bell),
                  color: Theme.of(context).primaryColor),
            ),
          ],
        ),
        body: ListView(

              children: [ Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Column(
                      children: [
                        Container(
                          child: Icon(
                            Icons.supervised_user_circle,
                            size: 100,
                          ),
                          //   padding: EdgeInsets.all(10.0),
                          //
                          //   width: MediaQuery.of(context).size.width/4,
                          //   height: MediaQuery.of(context).size.width/4,
                          //   decoration: BoxDecoration(
                          //     border: Border.all(color: Colors.white,width: 5),
                          //     shape: BoxShape.circle,
                          //     color: Colors.white,
                          //     image: DecorationImage(
                          //       fit: BoxFit.cover,
                          //       image: AssetImage('assets/profile_image.webp'),
                          //     ),
                          //   ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 100,
                left: 30,
                right: 30,
                child: Form(
                  child: GetX<UserController>(
                    init: Get.put<UserController>(UserController()),
                    builder: (_) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text('NAME',
                              textAlign: TextAlign.start,
                              style: Theme.of(context).textTheme.headline5),
                          Container(
                            width: 600,
                            child: TextFormField(
                              enabled: false,
                              decoration: InputDecoration(
                                hintText:
                                    "${_.users[int.parse(index)].f_name} ${_.users[int.parse(index)].l_name}",
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(int.parse(("0xff3D3A3A"))),
                                      width: 2.0),
                                ),
                                fillColor: Color(int.parse(("0xff3D3A3A"))),
                                filled: true,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text('EMAIL',
                              textAlign: TextAlign.start,
                              style: Theme.of(context).textTheme.headline5),
                          Container(
                            width: 600,
                            child: TextField(
                              enabled: false,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(int.parse(("0xff3D3A3A"))),
                                      width: 2.0),
                                ),
                                // hintText: '${snapshot.data?.phoneNumber}',
                                hintText: "${_.users[int.parse(index)].email}",
                                fillColor: Color(int.parse(("0xff3D3A3A"))),
                                filled: true,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text('PHONE NUMBER',
                              textAlign: TextAlign.start,
                              style: Theme.of(context).textTheme.headline5),
                          Container(
                            width: 600,
                            child: TextField(
                              enabled: false,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(int.parse(("0xff3D3A3A"))),
                                      width: 2.0),
                                ),
                                // hintText: '${snapshot.data?.phoneNumber}',
                                hintText: "${_.users[int.parse(index)].phone}",
                                fillColor: Color(int.parse(("0xff3D3A3A"))),
                                filled: true,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text('DESIGNATION',
                              textAlign: TextAlign.start,
                              style: Theme.of(context).textTheme.headline5),
                          Container(
                            width: 600,
                            child: TextFormField(
                              enabled: false,
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color(int.parse(("0xff3D3A3A"))),
                                      width: 2.0),
                                ),
                                // hintText: '${snapshot.data?.address}',
                                hintText:
                                    "${_.users[int.parse(index)].designation}",
                                fillColor: Color(int.parse(("0xff3D3A3A"))),
                                filled: true,
                              ),
                            ),
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
                  // key: _formkey,
                ),
              ),
        ],
        ),
      ),
        );

     }
}
