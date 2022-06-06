import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velocityx/screens/FileInformation/file_information.dart';
import 'package:velocityx/screens/Home/home.dart';
import 'package:velocityx/screens/Scanner/Scanner.dart';
import 'package:velocityx/screens/authenticate/sign_in.dart';
import 'package:velocityx/screens/metadata/meta_data.dart';
import 'package:velocityx/screens/Document/document.dart';

import '../models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser?>(context);

    // return either the Home or Authenticate widget
    if (user == null) {
      return Home();
    } else {
      // return Scanner();
      return MaterialApp(
        initialRoute: '/Document',
        routes: {
          // '/wrapper': (context) => Wrapper(),
          // '/SignIn': (context) => SignIn(),
          '/home': (context) => Home(),
          '/MetaData': (context) => MetaDataPage(),
          '/Scanner': (context) => Scanner(),
          // "/Profile":(context) => Profile
          '/FileInfo': (context) => FileInformation(),
          '/Document': (context) => Document(),
        },
      );
    }
  }
}
