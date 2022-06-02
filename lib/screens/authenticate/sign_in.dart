import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocityx/controllers/authController.dart';

class SignIn extends GetWidget<AuthController> {
  const SignIn({Key? key}) : super(key: key);

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
                "Welcome",
                style: TextStyle(
                    fontFamily: 'Segoe',
                    fontSize: 38,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF78D6FF)),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "VelocityX next gen document handler ",
                style: TextStyle(
                  fontFamily: 'Segoe',
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(
                height: 23,
              ),
              ElevatedButton(
                onPressed: () {
                  // Navigator.pushNamed(context, '/home');
                  controller.signInWithGoogle();
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 12, 15, 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/images/google.png',
                        width: 20,
                        height: 20,
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      const Text(
                        'Login with google',
                        style: TextStyle(color: Colors.black, fontSize: 17),
                      ),
                    ],
                  ),
                ),
                style: ElevatedButton.styleFrom(
                    shape: StadiumBorder(), primary: Color(0xFF78D6FF)),
              ),
              Divider(
                thickness: 1.5,
                color: Colors.black,
              ),
              const Text(
                'Login With Email and Password',
                style: TextStyle(color: Colors.white, fontSize: 17),
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
              ElevatedButton(
                child: Text("Log In"),
                onPressed: () {
                  controller.login(
                      emailController.text, passwordController.text);
                },
              ),
              ElevatedButton(
                child: Text("Sign Up"),
                onPressed: () {
                  controller.createUser(
                      emailController.text, passwordController.text);
                },
              ),
            ],
          ),
        )
      ],
    ));
  }
}
