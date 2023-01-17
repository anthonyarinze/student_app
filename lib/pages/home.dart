import 'package:flutter/material.dart';
import 'package:student_app/theme/palette.dart';
import 'package:student_app/theme/theme_service.dart';
import 'package:student_app/utils/widgets.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController controller = TextEditingController();
  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Morning';
    }
    if (hour < 17) {
      return 'Afternoon';
    }
    return 'Evening';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add, size: 32),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            //Top row greeting
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => ThemeService().switchTheme(),
                    icon: const Icon(
                      Icons.nightlight,
                    ),
                  ),
                  const Text(
                    'Good ',
                    style: TextStyle(fontSize: 21),
                  ),
                  Text(
                    greeting(),
                    style: const TextStyle(fontSize: 21),
                  ),
                  const Text(
                    ', Anthony',
                    style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            //Search Bar
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const BuildSearchBar(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.filter_alt_outlined,
                      size: 32,
                      color: Palette.kLightThemeColor,
                    ),
                  ),
                ],
              ),
            ),

            //Your Classes & See all
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 30, 15, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Your Classes',
                    style: TextStyle(fontSize: 22),
                  ),
                  Text(
                    'See all',
                    style: TextStyle(
                        fontSize: 16, color: Palette.kLightThemeColor),
                  ),
                ],
              ),
            ),
            BuildClassWidget(),
          ],
        ),
      ),
    );
  }
}
