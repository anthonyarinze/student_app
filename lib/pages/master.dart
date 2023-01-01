import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:student_app/pages/home.dart';
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
    const Home(),
    const Home(),
  ];

  final items = <Widget>[
    const Icon(
      Icons.class_rounded,
      size: 30,
      color: Palette.kLightButtonColor,
    ),
    const Icon(
      Icons.scale,
      size: 30,
      color: Palette.kLightButtonColor,
    ),
    const Icon(
      Icons.calendar_today_rounded,
      size: 30,
      color: Palette.kLightButtonColor,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: CurvedNavigationBar(
        items: items,
        index: index,
        height: 60,
        onTap: ((index) => setState(() => this.index = index)),
        backgroundColor: Palette.kLightButtonColor,
        animationDuration: const Duration(milliseconds: 300),
      ),
      body: screens[index],
    );
  }
}
