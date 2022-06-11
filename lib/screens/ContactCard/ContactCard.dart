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
  const ContactPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        // backgroundColor: Color.fromRGBO(36, 36, 36, 1.0),
        appBar: AppBar(
          leading: BackButton(
            color: Theme.of(context).primaryColor,
          ),
          title: Text(
            "Profile Page",
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
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
        body: Container(
          child: Stack(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 250,
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
                  // key: _formkey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 30, 280, 5),
                        child: Text(
                          'NAME',
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Container(
                        width: 600,
                        child: TextFormField(
                          enabled: false,
                          // controller: nameController,
                          // onChanged: (val){
                          //   setState(() {
                          //     name = val;
                          //   });
                          // },
                          validator: (String? val) {
                            if (val!.isEmpty) {
                              return "Enter your Name";
                            } else {
                              return null;
                            }
                          },

                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(int.parse(("0xff3D3A3A"))),
                                  width: 2.0),
                            ),
                            // hintText: '${snapshot.data?.name}',
                            hintText: 'User Name',
                            fillColor: Color(int.parse(("0xff3D3A3A"))),
                            filled: true,
                          ),
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.fromLTRB(0,20,280,5),
                      //   child: Text(
                      //     'EMAIL',
                      //     textAlign: TextAlign.start,
                      //   ),
                      // ),
                      // Container(
                      //   width: 600,
                      //   child: TextField(
                      //     decoration: InputDecoration(
                      //       enabledBorder: OutlineInputBorder(
                      //         borderSide: BorderSide(color: Color(int.parse(("0xff3D3A3A"))),width: 2.0),
                      //       ),
                      //       hintText: 'antsav@gmail.com',
                      //       fillColor: Color(int.parse(("0xff3D3A3A"))),
                      //       filled: true,
                      //
                      //
                      //     ),
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 280, 5),
                        child: Text(
                          'Email',
                          textAlign: TextAlign.start,
                        ),
                      ),
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
                            hintText: 'Email Addresss',
                            fillColor: Color(int.parse(("0xff3D3A3A"))),
                            filled: true,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 220, 5),
                        child: Text(
                          'PHONE NUMBER',
                          textAlign: TextAlign.start,
                        ),
                      ),
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
                            hintText: 'Phone Number',
                            fillColor: Color(int.parse(("0xff3D3A3A"))),
                            filled: true,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 270, 5),
                        child: Text(
                          'Designation',
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Container(
                        width: 600,
                        child: TextFormField(
                          enabled: false,
                          // controller: addressController,
                          // onChanged: (val){
                          //   setState(() {
                          //     address = val;
                          //   });
                          // },
                          validator: (String? val) {
                            if (val!.isEmpty) {
                              return "Enter your Address";
                            } else {
                              return null;
                            }
                          },

                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(int.parse(("0xff3D3A3A"))),
                                  width: 2.0),
                            ),
                            // hintText: '${snapshot.data?.address}',
                            hintText: 'Designation',
                            fillColor: Color(int.parse(("0xff3D3A3A"))),
                            filled: true,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      TextButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color(int.parse("0xff4784F1")),
                            padding: EdgeInsets.fromLTRB(40, 20, 40, 20),
                            shadowColor: Colors.cyan,
                          ),
                          child: Text(
                            "EDIT",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            // widget.toggleView();

                            // if (_formkey.currentState!.validate()){
                            //
                            //   // setState(() {
                            //   //   loading = true;
                            //   // });
                            //
                            //   print(addressController.text);
                            //   print(nameController.text);
                            //
                            //   final user = Provider.of<MyUser?>(context,listen: false);
                            //
                            //   print(user?.uid);
                            //
                            //   await DatabaseService(uid: user?.uid).updateUserData(addressController.text, nameController.text, '${snapshot.data?.phoneNumber}');

                            // if (result == null ){
                            //   setState(() {
                            //     error = "Enter valid Email";
                            //     loading = false;
                            //   });
                            // }
                          }

                          // }

                          ),
                      SizedBox(
                        height: 20,
                      ),
                      // Text(
                      //   error,
                      //   style: TextStyle(color: Colors.red, fontSize: 14.0),
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
