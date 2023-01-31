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
  final User? user;
  Profile({super.key, this.backgroundImage, this.user});

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
                    onTap: () => dialogBuilder(
                      context,
                      'Are you sure you want to delete your account? '
                      'This will delete all data related to your account on our end.',
                      () async => await user?.delete(),
                    ),
                    leadingIcon:
                        const Icon(Icons.delete_forever_outlined, size: 25),
                    title: 'Delete Account',
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
                    leadingIcon:
                        const Icon(Icons.nightlight_outlined, size: 25),
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
}
