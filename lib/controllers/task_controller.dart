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

//add task to table
  Future<int> addTask({Task? task}) async {
    return await DBHelper.insert(task);
  }

  //get all data from table
  Future<void> getTasks() async {
    List<Map<String, dynamic>> tasks = await DBHelper.query();
    taskList.assignAll(
      tasks.map((data) => Task.fromJSON(data)).toList(),
    );
  }

//delete data from table
  void delete(Task task) async {
    DBHelper.delete(task);
    getTasks();
  }

//mark data as complete
  void markTaskCompleted(int id) async {
    await DBHelper.update(id);
    getTasks();
  }
}
