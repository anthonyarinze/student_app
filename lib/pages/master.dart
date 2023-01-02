import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:student_app/pages/calendar.dart';
import 'package:student_app/pages/home.dart';
import 'package:student_app/pages/metric.dart';
import 'package:student_app/pages/profile.dart';
import 'package:student_app/utils/palette.dart';

class Master extends StatefulWidget {
  const Master({super.key});

  @override
  State<Master> createState() => _MasterState();
}

class _MasterState extends State<Master> {
  int index = 1;
  final screens = [
    const Home(),
    const Calendar(),
    const Metric(),
    const Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: Container(
        color: Palette.kLightThemeColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          child: GNav(
            gap: 8.0,
            padding: const EdgeInsets.all(16.0),
            activeColor: Colors.white,
            tabBackgroundColor: Palette.kLightThemeColorAccent,
            textStyle: const TextStyle(color: Colors.white),
            onTabChange: (value) {
              setState(() {
                index = value;
              });
            },
            tabs: const [
              GButton(
                  icon: Icons.home_rounded,
                  text: 'Home',
                  iconColor: Colors.white),
              GButton(
                  icon: Icons.calendar_month_rounded,
                  text: 'Calendar',
                  iconColor: Colors.white),
              GButton(
                  icon: Icons.calculate_rounded,
                  text: 'Metrics',
                  iconColor: Colors.white),
              GButton(
                  icon: Icons.person_rounded,
                  text: 'Profile',
                  iconColor: Colors.white),
            ],
          ),
        ),
      ),
      body: screens[index],
    );
  }
}
