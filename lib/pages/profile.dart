import 'package:flutter/material.dart';
import 'package:student_app/theme/palette.dart';
import 'package:student_app/utils/widgets.dart';

class Profile extends StatelessWidget {
  const Profile({super.key, this.backgroundImage});

  final ImageProvider? backgroundImage;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            const Center(
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
                    leadingIcon: const Icon(Icons.email_outlined, size: 25),
                    title: 'Email Address',
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
