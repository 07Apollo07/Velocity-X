import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocityx/controllers/authController.dart';
import 'login_page.dart';

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
          bottom: (MediaQuery.of(context).size.width > 600) ? 300 : 80,
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
                    fontSize: 45,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF78D6FF)),
              ),
              const SizedBox(
                height: 15,
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
                height: 40,
              ),
              ElevatedButton(
                onPressed: () {
                  // Navigator.pushNamed(context, '/home');
                  controller.signInWithGoogle();
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 10, 15, 12),
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
                  shape: StadiumBorder(),
                  primary: Color(0xFF78D6FF),
                  fixedSize: const Size(340, 42),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => const Login()));
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 12, 15, 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Login with Email and password',
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                    ],
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  shape: const StadiumBorder(
                    side: BorderSide(
                      width: 3,
                      color: Color(0xFF78D6FF),
                    ),
                  ),
                  primary: Color.fromARGB(0, 0, 0, 0),
                  fixedSize: const Size(340, 42),
                ),
              )
              // Divider(
              //   thickness: 1.5,
              //   color: Colors.black,
              // ),
              // const Text(
              //   'Login With Email and Password',
              //   style: TextStyle(color: Colors.white, fontSize: 17),
              // ),
              // TextFormField(
              //   decoration: InputDecoration(hintText: "Email"),
              //   controller: emailController,
              // ),
              // SizedBox(
              //   height: 40,
              // ),
              // TextFormField(
              //   decoration: InputDecoration(hintText: "Password"),
              //   controller: passwordController,
              //   obscureText: true,
              // ),
              // ElevatedButton(
              //   child: Text("Log In"),
              //   onPressed: () {
              //     controller.login(
              //         emailController.text, passwordController.text);
              //   },
              // ),
              // ElevatedButton(
              //   child: Text("Sign Up"),
              //   onPressed: () {
              //     controller.createUser(
              //         emailController.text, passwordController.text);
              //   },
              // ),
            ],
          ),
        )
      ],
    ));
  }
}
