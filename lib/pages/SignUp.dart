import 'package:flutter/material.dart';
import 'package:student_app/utils/palette.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //Sign up and icon
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 50, 0, 0),
            child: Row(
              children: const [
                Icon(
                  Icons.account_circle_rounded,
                  color: Colors.blueAccent,
                  size: 50,
                ),
                Padding(
                  padding: EdgeInsets.all(13.0),
                  child: Text(
                    "Sign Up",
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              ],
            ),
          ),

          //Create text
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 12, 0, 0),
            child: Text(
              "Create an account to enjoy our services with the most up-to-date features :)",
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

          //Sign up button
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 70, 18, 0),
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
                  'Sign Up',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
          ),

          //Login redirect
          Padding(
            padding: const EdgeInsets.fromLTRB(80, 20, 10, 0),
            child: Row(
              children: [
                Text(
                  "Already have an account?",
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
                    "Login",
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
    );
  }
}

class BuildTextFormField extends StatelessWidget {
  const BuildTextFormField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(13.0),
      child: Container(
        height: 80,
        width: double.infinity,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: TextFormField(
          autocorrect: false,
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hintText,
            contentPadding: const EdgeInsets.all(10),
            border: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey,
                width: 4.0,
              ),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            errorBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
          ),
        ),
      ),
    );
  }
}
