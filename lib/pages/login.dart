import 'package:flutter/material.dart';

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
    return Scaffold(
      body: Column(
        children: [
          //Log in and icon
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 50, 0, 0),
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
                padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Forgot password?',
                    style: TextStyle(fontSize: 18, color: Colors.grey.shade700),
                  ),
                ),
              ),
            ],
          ),
          //Sign up button
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 40, 18, 0),
            child: SizedBox(
              height: 56,
              width: MediaQuery.of(context).size.width,
              child: TextButton(
                onPressed: () {},
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
        ],
      ),
    );
  }
}
