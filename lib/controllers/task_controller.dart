import 'package:get/get.dart';
import 'package:student_app/db/db_helper.dart';
import 'package:student_app/models/model.dart';

class TaskController extends GetxController {
  @override
  // ignore: unnecessary_overrides
  void onReady() {
    super.onReady();
  }

  Future<int> addTask({Task? task}) async {
    return await DBHelper.insert(task);
  }
}
