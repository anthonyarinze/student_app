import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:student_app/auth/forgot_password.dart';
import 'package:student_app/auth/signup.dart';
import 'package:student_app/utils/firebase_services.dart';
import '../pages/master.dart';
import '../theme/palette.dart';
import '../utils/widgets.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool rememberMe = false;

  Future signin() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Master(),
        ),
      );
    } on FirebaseAuthException catch (exception) {
      AlertDialog(
        title: const Text("Error"),
        content: Text(exception.message.toString()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              //Log in and icon
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 20, 0, 0),
                child: Row(
                  children: const [
                    Icon(
                      Icons.switch_account_rounded,
                      color: Palette.kLightButtonColor,
                      size: 50,
                    ),
                    Padding(
                      padding: EdgeInsets.all(13.0),
                      child: Text(
                        "Log in",
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                  ],
                ),
              ),

              //Create text
              const Padding(
                padding: EdgeInsets.fromLTRB(22, 12, 0, 0),
                child: Text(
                  "Log into your account to enjoy exclsusive features and many more :)",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              //Email Text
              const Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 25, 0, 0),
                  child: Text(
                    "Email",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),

              //TextFormField
              BuildTextFormField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false),
              const Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text(
                    "Password",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
              BuildTextFormField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true),

              //Remember me & Forgot Password
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ForgotPassword(),
                        ),
                      );
                    },
                    child: const Text(
                      'Forgot password?',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ),
              //Sign up button
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 40, 18, 20),
                child: SizedBox(
                  height: 56,
                  width: MediaQuery.of(context).size.width,
                  child: TextButton(
                    onPressed: () {
                      signin();
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Palette.kLightButtonColor,
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                    child: const Text(
                      'Log in',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ),
              ),

              //Spacer
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 2.5,
                      width: MediaQuery.of(context).size.width / 2.5,
                      decoration: const BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
                  ),
                  const Text('or'),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 2.5,
                      width: MediaQuery.of(context).size.width / 2.5,
                      decoration: const BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
                  ),
                ],
              ),

              //Google button
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 40, 18, 20),
                child: Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width - 20,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.5),
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: TextButton(
                    onPressed: () {
                      FirebaseServices().signInWithGoogle();
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: const Color(0xFFfdfdfd),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('images/google.png'),
                        const SizedBox(width: 20),
                        Text(
                          'Google',
                          style: TextStyle(
                              color: Colors.grey.shade700, fontSize: 25),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              //Sign up redirect
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "New to Smart Study?",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUp(),
                          ),
                        );
                      },
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Palette.kLightButtonColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
