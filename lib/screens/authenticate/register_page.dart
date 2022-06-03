import 'dart:html';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocityx/controllers/authController.dart';

class Register extends GetWidget<AuthController> {
  const Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final AuthController _auth = AuthController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: true,
            backgroundColor: Color.fromARGB(255, 0, 7, 12),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context, false),
            )),
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 0, 7, 12),
                  Color.fromARGB(255, 7, 39, 99),
                ],
              )),
            ),
            Positioned(
              top: 70,
              left: 30,
              right: 30,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Register With Your details",
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
                  Container(
                    width: 400,
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: "First Name", icon: Icon(Icons.person)),
                      controller: emailController,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    width: 400,
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: "Last Name", icon: Icon(Icons.person)),
                      controller: emailController,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    width: 400,
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: "Email", icon: Icon(Icons.email)),
                      controller: emailController,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    width: 400,
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: "Password", icon: Icon(Icons.password)),
                      controller: passwordController,
                      obscureText: true,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    width: 400,
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: "Confirm Password",
                          icon: Icon(Icons.password)),
                      controller: passwordController,
                      obscureText: true,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
                              shape: const StadiumBorder(
                                side: BorderSide(
                                  width: 3,
                                  color: Color(0xFF78D6FF),
                                ),
                              ),
                              primary: Color.fromARGB(0, 120, 215, 255),
                            ),
                            child: const Text(
                              "Log In",
                              style: TextStyle(
                                fontFamily: 'Segoe',
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF78D6FF),
                              ),
                            ),
                            onPressed: () {
                              controller.login(emailController.text,
                                  passwordController.text);
                            },
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
                              shape: const StadiumBorder(
                                side: BorderSide(
                                  width: 3,
                                  color: Color(0xFF78D6FF),
                                ),
                              ),
                              primary: Color.fromARGB(0, 120, 215, 255),
                            ),
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                fontFamily: 'Segoe',
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF78D6FF),
                              ),
                            ),
                            onPressed: () {
                              controller.createUser(emailController.text,
                                  passwordController.text);
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
