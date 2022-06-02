import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocityx/controllers/authController.dart';
import 'login_page.dart';

class Login extends GetWidget<AuthController> {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final AuthController _auth = AuthController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
        body: Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/images/loginBg.png'),
            fit: BoxFit.cover,
          )),
        ),
        Positioned(
          top: 300,
          left: 30,
          right: 30,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Login With Email and Password",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Segoe',
                  fontSize: 35,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF78D6FF),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              TextFormField(
                decoration: InputDecoration(hintText: "Email"),
                controller: emailController,
              ),
              SizedBox(
                height: 40,
              ),
              TextFormField(
                decoration: InputDecoration(hintText: "Password"),
                controller: passwordController,
                obscureText: true,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  ElevatedButton(
                    child: Text("Log In"),
                    onPressed: () {
                      controller.login(
                          emailController.text, passwordController.text);
                    },
                  ),
                  SizedBox(width: 20,),
                  ElevatedButton(
                    child:  Text("Sign Up"),
                    onPressed: () {
                      controller.createUser(
                          emailController.text, passwordController.text);
                    },
                  ),
                ]),
              ),
            ],
          ),
        )
      ],
    ));
  }
}
