import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:student_app/auth/login.dart';
import 'package:student_app/controllers/task_controller.dart';
import 'package:student_app/db/db_helper.dart';
import 'package:student_app/pages/master.dart';
import 'package:student_app/theme/theme.dart';
import 'package:student_app/theme/theme_service.dart';
import 'package:student_app/utils/firebase_options.dart';
import 'package:student_app/utils/notif_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBHelper.initDb();
  await GetStorage.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeService().theme,
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  final _taskController = Get.put(TaskController());
  final notifyHelper = NotifyHelper();

  MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    _taskController.getTasks();
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const Master();
            } else {
              return const Login();
            }
          },
        ),
      ),
    );
  }
}
