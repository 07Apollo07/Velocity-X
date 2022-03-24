import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:velocityx/models/user.dart';
import 'package:velocityx/screens/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:velocityx/services/auth.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
  // runApp(MaterialApp(
  //   initialRoute: '/SignIn',s
  //   routes: {
  //     '/wrapper':(context) => Wrapper(),
  //     '/SignIn':(context) => SignIn(),
  //     '/home':(context) => Home(),
  //     '/MetaData':(context) => MetaDataPage(),
  //   } ,

  // ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<MyUser?>.value(
      initialData: null,
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}
