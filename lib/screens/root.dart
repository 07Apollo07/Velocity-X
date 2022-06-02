import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocityx/controllers/authController.dart';
import 'package:velocityx/controllers/userController.dart';
import 'package:velocityx/controllers/wrapperController.dart';
import 'package:velocityx/screens/Home/home.dart';
import 'package:velocityx/screens/authenticate/sign_in.dart';
import 'package:velocityx/screens/wrapper.dart';

class Root extends GetWidget<AuthController> {
  @override
  Widget build(BuildContext context) {
    return GetX<AuthController>(
      initState: (_) async {
        Get.put<UserController>(UserController());
      },
      builder: (_) {
        // print(AuthController().user);
        // print(AuthController().user.runtimeType);
        if (Get.find<AuthController>().user == null) {
          return SignIn();
        } else {
          return Wrapper();
        }
      },
    );
  }
}
