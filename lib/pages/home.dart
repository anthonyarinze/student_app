import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_app/pages/add_task.dart';
import 'package:student_app/theme/palette.dart';
import 'package:student_app/theme/theme_service.dart';
import 'package:student_app/utils/notif_services.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DateTime selectedDate = DateTime.now();
  var notifyHelper;
  @override
  void initState() {
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();
  }

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
        backgroundColor: Palette.kLightThemeColor,
        onPressed: () => Get.to(() => const AddTaskPage()),
        child: const Icon(Icons.add, size: 32, color: Colors.white),
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
                  //Theme Switch
                  IconButton(
                    onPressed: () {
                      ThemeService().switchTheme();
                      notifyHelper.displayNotification(
                        title: "Theme Changed",
                        body: Get.isDarkMode
                            ? "Activated Light Mode"
                            : "Activated Dark Mode",
                      );
                      notifyHelper.scheduledNotification();
                    },
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

            // //Search Bar
            // Padding(
            //   padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       const BuildSearchBar(),
            //       IconButton(
            //         onPressed: () {},
            //         icon: const Icon(
            //           Icons.filter_alt_outlined,
            //           size: 32,
            //           color: Palette.kLightThemeColor,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),

            _addDateBar(),

            //Your Classes & See all
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 30, 15, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Your Classes',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'See all',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            //BuildClassWidget(),
          ],
        ),
      ),
    );
  }

  Container _addDateBar() {
    // ignore: avoid_unnecessary_containers
    return Container(
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: Palette.kLightThemeColor,
        selectedTextColor: Colors.white,
        dateTextStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        ),
        dayTextStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        ),
        monthTextStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        ),
        onDateChange: (date) {
          selectedDate = date;
        },
      ),
    );
  }
}
