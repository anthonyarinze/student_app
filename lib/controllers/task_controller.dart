import 'package:get/get.dart';
import 'package:student_app/db/db_helper.dart';
import 'package:student_app/models/model.dart';

class TaskController extends GetxController {
  @override
  // ignore: unnecessary_overrides
  void onReady() {
    super.onReady();
  }

  var taskList = <Task>[].obs;

  Future<int> addTask({Task? task}) async {
    return await DBHelper.insert(task);
  }

  //get all data from table
  void getTasks() async {
    List<Map<String, dynamic>> tasks = await DBHelper.query();
    taskList.assignAll(
      tasks.map((data) => Task.fromJSON(data)).toList(),
    );
  }

  void delete(Task task) async {
    DBHelper.delete(task);
  }
}
