import 'package:flutter/material.dart';
import 'package:student_app/utils/widgets.dart';
import '../utils/palette.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            //Header Icon & text
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 50, 0, 0),
              child: Row(
                children: const [
                  Icon(
                    Icons.lock_rounded,
                    color: Palette.kLightButtonColor,
                    size: 50,
                  ),
                  Padding(
                    padding: EdgeInsets.all(13.0),
                    child: Text(
                      "Forgot password?",
                      style: TextStyle(fontSize: 28),
                    ),
                  ),
                ],
              ),
            ),

            //Reset text
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 12, 0, 0),
              child: Text(
                "Enter the email you used to register so we can send you a link to reset your password.",
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

            //Email
            BuildTextFormField(
              controller: emailController,
              hintText: 'Email',
              obscureText: false,
            ),

            //Reset Link TextButton
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 40, 18, 20),
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
                    'Send Link',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
