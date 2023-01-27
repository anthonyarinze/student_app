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
import 'package:student_app/utils/widgets.dart';

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

  MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    _taskController.getTasks();
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          elevation: 2.0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(5.0),
              bottomRight: Radius.circular(5.0),
            ),
          ),

          //ListView used to ensure user can scroll if there isn't enough vertical real estate.
          child: ListView(
            //Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              const SizedBox(height: 25),
              DrawerHeader(
                decoration: const BoxDecoration(color: Colors.white),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(40)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(13, 20, 0, 20),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          foregroundColor: Colors.white,
                          backgroundColor: Color(0xFF26005f),
                          radius: 40,
                          child: Icon(
                            Icons.person,
                            size: 45,
                          ),
                        ),
                        Flexible(
                          child: Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.fromLTRB(0, 20, 80, 0),
                                child: Text(
                                  "John Doe",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "john_doe@gmail.com",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.grey.shade700,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => dialogBuilder(context, "Testing"),
                child: ListTile(
                  leading: Icon(
                    Icons.lock,
                    color: Colors.grey.shade700,
                  ),
                  title: const Text(
                    "Change password",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  trailing:
                      const Icon(Icons.arrow_forward_ios, color: Colors.grey),
                ),
              ),
              ListTile(
                onTap: () => FirebaseAuth.instance.signOut(),
                leading: Icon(
                  Icons.logout_rounded,
                  color: Colors.grey.shade700,
                ),
                title: const Text(
                  "Sign Out",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                trailing:
                    const Icon(Icons.arrow_forward_ios, color: Colors.grey),
              ),
            ],
          ),
        ),
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

  void _changePassword(BuildContext context, String password) {
    //Create an instance of the current user.
    User? user = FirebaseAuth.instance.currentUser;

    //Pass in the password to updatePassword.
    user?.updatePassword(password).then((_) async {
      await dialogBuilder(context, "Successfully changed password");
    }).catchError((error) async {
      await dialogBuilder(context, "Password can't be changed$error");
      //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
    });
  }
}
