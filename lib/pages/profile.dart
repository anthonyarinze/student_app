import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_app/auth/login.dart';
import 'package:student_app/theme/palette.dart';
import 'package:student_app/theme/theme_service.dart';
import 'package:student_app/utils/notif_services.dart';
import 'package:student_app/utils/widgets.dart';

class Profile extends StatelessWidget {
  final notifyHelper = NotifyHelper();

  Profile({super.key, this.backgroundImage});

  final ImageProvider? backgroundImage;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 15.0),
                child: CircleAvatar(
                  radius: 75,
                  backgroundColor: Palette.kLightThemeColor,
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Palette.kDarkGreyColor,
                      child: Icon(Icons.camera_alt, size: 20.0),
                    ),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: Center(
                child: Text('John Doe', style: TextStyle(fontSize: 25)),
              ),
            ),
            Expanded(
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 15.0, bottom: 10.0),
                    child: Text(
                      'Personal',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  BuildProfileListTile(
                    onTap: () {},
                    leadingIcon: const Icon(Icons.email_outlined, size: 25),
                    title: 'Email Address',
                    trailingIcon: const Icon(Icons.arrow_forward_ios, size: 20),
                  ),
                  const Padding(
                    padding:
                        EdgeInsets.only(left: 15.0, bottom: 10.0, top: 15.0),
                    child: Text(
                      'Security',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  BuildProfileListTile(
                    onTap: () {},
                    leadingIcon: const Icon(Icons.password_outlined, size: 25),
                    title: 'Password Reset',
                    trailingIcon: const Icon(Icons.arrow_forward_ios, size: 20),
                  ),
                  const Padding(
                    padding:
                        EdgeInsets.only(left: 15.0, bottom: 10.0, top: 15.0),
                    child: Text(
                      'App Settings',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  BuildProfileListTile(
                    onTap: () {
                      ThemeService().switchTheme();
                      notifyHelper.displayNotification(
                        title: "Theme Changed",
                        body: Get.isDarkMode
                            ? "Activated Light Mode"
                            : "Activated Dark Mode",
                      );
                    },
                    leadingIcon: const Icon(Icons.nightlight, size: 25),
                    title: 'Change Theme',
                    trailingIcon: const Icon(Icons.arrow_forward_ios, size: 20),
                  ),
                  BuildProfileListTile(
                    onTap: () => dialogBuilder(
                      context,
                      'Are you sure you want to sign out?',
                      () async {
                        await FirebaseAuth.instance.signOut();
                        Get.to(() => const Login());
                      },
                    ),
                    leadingIcon: const Icon(Icons.email_outlined, size: 25),
                    title: 'Sign Out',
                    trailingIcon: const Icon(Icons.arrow_forward_ios, size: 20),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _changePassword(BuildContext context, String password) {
    //Create an instance of the current user.
    User? user = FirebaseAuth.instance.currentUser;

    //Pass in the password to updatePassword.
    user?.updatePassword(password).then((_) async {
      await dialogBuilder(context, "Successfully changed password", () {});
    }).catchError((error) async {
      await dialogBuilder(context, "Password can't be changed$error", () {});
      //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
    });
  }
}
