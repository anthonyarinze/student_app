import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:student_app/pages/calendar.dart';
import 'package:student_app/pages/home.dart';
import 'package:student_app/pages/metric.dart';

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
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: GNav(
        gap: 18.0,
        onTabChange: (value) {
          setState(() {
            index = value;
          });
        },
        tabs: const [
          GButton(icon: Icons.home, text: 'Home'),
          GButton(
            icon: Icons.favorite_border,
            text: 'Likes',
          ),
          GButton(
            icon: Icons.search,
            text: 'Search',
          ),
        ],
      ),
      body: screens[index],
    );
  }
}
