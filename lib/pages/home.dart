import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:student_app/controllers/task_controller.dart';
import 'package:student_app/pages/add_task.dart';
import 'package:student_app/theme/palette.dart';
import 'package:student_app/theme/theme.dart';
import 'package:student_app/theme/theme_service.dart';
import 'package:student_app/utils/notif_services.dart';
import 'package:student_app/utils/widgets.dart';

import '../models/model.dart';

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
  final _taskController = Get.put(TaskController());
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
        onPressed: () async {
          await Get.to(() => const AddTaskPage());
          _taskController.getTasks();
        },
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

            _showTasks(),
          ],
        ),
      ),
    );
  }

  _showTasks() {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      child: Obx(
        () {
          return ListView.builder(
            itemCount: _taskController.taskList.length,
            itemBuilder: (_, index) {
              Task task = _taskController.taskList[index];
              if (task.repeat == 'Daily') {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                    child: FadeInAnimation(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _showBottomSheet(context, task);
                            },
                            child: TaskTile(task),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
              if (task.date == DateFormat.yMd().format(selectedDate)) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                    child: FadeInAnimation(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _showBottomSheet(context, task);
                            },
                            child: TaskTile(task),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return Container();
              }
            },
          );
        },
      ),
    );
  }

  _bottomSheetButton({
    required String label,
    required Function() onTap,
    required Color color,
    // ignore: unused_element
    bool isClose = false,
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        height: 55,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          color: isClose == true ? Colors.transparent : color,
          border: Border.all(
            width: 2,
            color: isClose == true
                ? Get.isDarkMode
                    ? Colors.grey[600]!
                    : Colors.grey[300]!
                : color,
          ),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Center(
          child: Text(
            label,
            style: isClose
                ? TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                  )
                : TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                  ).copyWith(
                    color: Colors.white,
                  ),
          ),
        ),
      ),
    );
  }

  _showBottomSheet(BuildContext context, Task task) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.only(top: 4.0),
        height: task.isCompleted == 1
            ? MediaQuery.of(context).size.height * 0.24
            : MediaQuery.of(context).size.height * 0.32,
        color: Get.isDarkMode ? darkgreyClr : Colors.white,
        child: Column(
          children: [
            Container(
              height: 6,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Get.isDarkMode ? Colors.grey[600] : Colors.grey[300],
              ),
            ),
            const Spacer(),
            task.isCompleted == 1
                ? Container()

                //Task Completed Button
                : _bottomSheetButton(
                    label: "Task Completed",
                    onTap: () {
                      _taskController.markTaskCompleted(task.id!);
                      Get.back();
                    },
                    color: primaryClr,
                    context: context,
                  ),

            //Delete Task Button
            _bottomSheetButton(
              label: "Delete Task",
              onTap: () {
                _taskController.delete(task);
                Get.back();
              },
              color: Colors.red[300]!,
              context: context,
            ),

            const SizedBox(height: 20),

            //Close BottomSheet Button
            _bottomSheetButton(
              label: "Close",
              onTap: () {
                Get.back();
              },
              color: Colors.red[300]!,
              isClose: true,
              context: context,
            ),
            const SizedBox(height: 10),
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
          setState(() {
            selectedDate = date;
          });
        },
      ),
    );
  }
}
