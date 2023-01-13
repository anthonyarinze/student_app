import 'package:flutter/material.dart';
import 'package:student_app/utils/palette.dart';

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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            //Top row greeting
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
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
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      height: 55,
                      width: MediaQuery.of(context).size.width / 1.5,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: TextField(
                        autocorrect: false,
                        controller: controller,
                        decoration: const InputDecoration(
                          hintText: 'Search',
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Palette.kLightThemeColor),
                          ),
                          contentPadding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.pink,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          hintStyle: TextStyle(),
                          suffixIcon: Icon(Icons.search),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.filter_alt_outlined,
                        size: 35,
                        color: Palette.kLightThemeColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //Your Classes
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
          ],
        ),
      ),
    );
  }
}
