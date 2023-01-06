import 'package:flutter/material.dart';
import 'package:student_app/auth/forgot_password.dart';
import 'package:student_app/auth/signup.dart';
import '../utils/palette.dart';
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
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
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
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 12, 0, 0),
              child: Text(
                "Log into your account to enjoy exclsusive features and many more :)",
                style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  child: Row(
                    children: [
                      Checkbox(
                          value: rememberMe,
                          onChanged: (value) {
                            setState(() {
                              rememberMe = !rememberMe;
                              //TODO: Add Functionality
                            });
                          }),
                      const Text(
                        'Remember me',
                        style: TextStyle(fontSize: 19),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ForgotPassword()));
                    },
                    child: Text(
                      'Forgot password?',
                      style:
                          TextStyle(fontSize: 18, color: Colors.grey.shade700),
                    ),
                  ),
                ),
              ],
            ),
            //Sign up button
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 40, 18, 20),
              child: SizedBox(
                height: 56,
                width: MediaQuery.of(context).size.width,
                child: TextButton(
                  onPressed: () {
                    //TODO: Add Functionality
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
                  onPressed: () {},
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
                  Text(
                    "New to Smart Study?",
                    style: TextStyle(
                      color: Colors.grey.shade700,
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
    );
  }
}
