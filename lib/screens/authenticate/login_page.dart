// import 'dart:html';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocityx/controllers/authController.dart';
import 'register_page.dart';

class Login extends GetWidget<AuthController> {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final AuthController _auth = AuthController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final GlobalKey<FormState> _form = GlobalKey<FormState>();

    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: true,
            backgroundColor: Color.fromARGB(255, 0, 7, 12),
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Get.back(),
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
              top: 170,
              left: 30,
              right: 30,
              child: Form(
                key: _form,
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
                    Container(
                      width: 400,
                      child: TextFormField(
                          decoration: InputDecoration(
                              hintText: "Email", icon: Icon(Icons.email)),
                          cursorColor: Colors.white,
                          style: TextStyle(
                            color: Color(0xFF78D6FF),
                          ),
                          controller: emailController,
                          validator: (val) {
                            if (val != null &&
                                val.isEmpty &&
                                !val.contains("@"))
                              return "Enter a Valid Eamil Address";
                            return null;
                          }),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      width: 400,
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText: "Password", icon: Icon(Icons.password)),
                        cursorColor: Colors.white,
                        style: TextStyle(
                          color: Color(0xFF78D6FF),
                        ),
                        controller: passwordController,
                        obscureText: true,
                        validator: (val) {
                          if (val != null && val.isEmpty) {
                            return "Please Enter a Password";
                          } else if (val != null && val.length < 8) {
                            return "Password must be atleast 8 characters long";
                          } else {
                            return null;
                          }
                        },
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
                                if (_form.currentState!.validate()) {
                                  controller.login(emailController.text,
                                      passwordController.text);
                                }
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
                                Get.to(() => Register());
                              },
                            ),
                          ]),
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
