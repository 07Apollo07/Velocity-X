import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocityx/binding/bindings.dart';
import 'package:velocityx/models/user.dart';
import 'package:velocityx/routes/app_pages.dart';
import 'package:velocityx/screens/splash.dart';
import 'package:velocityx/screens/root.dart';
import 'package:velocityx/screens/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:velocityx/controllers/authController.dart';
import 'firebase_options.dart';
import 'custom_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) => Get.put(AuthController(), permanent: true));
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
    return GetMaterialApp(
      initialBinding: StoreBindings(),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      // initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: CustomTheme.darkTheme,
      darkTheme: CustomTheme.darkTheme,
      themeMode: ThemeMode.system,
    );
  }
}
