import 'package:logger/logger.dart';
import 'package:sqflite/sqflite.dart';
import 'package:student_app/models/model.dart';

class DBHelper implements StackTrace {
  static Database? _db;
  static const int _version = 1;
  static const String _tableName = "tasks";
  static var logger = Logger();

  static Future<void> initDb() async {
    if (_db != null) {
      return;
    }
    try {
      String path = '${await getDatabasesPath()}tasks.db';
      _db = await openDatabase(
        path,
        version: _version,
        onCreate: (db, version) {
          return db.execute(
            "CREATE TABLE $_tableName("
            "id INTEGER PRIMARY KEY AUTOINCREMENT, "
            "title STRING, note TEXT, date STRING, "
            "startTime STRING, endTime STRING, "
            "remind INTEGER, repeat STRING, "
            "color INTEGER, "
            "isCompleted INTEGER)",
          );
        },
      );
    } catch (e) {
      logger.log(Level.verbose, e.toString());
    }
  }

//insert data into table
  static Future<int> insert(Task? task) async {
    return await _db?.insert(_tableName, task!.toJSON()) ?? 1;
  }

//query data from table
  static Future<List<Map<String, dynamic>>> query() async {
    return await _db!.query(_tableName);
  }

//delete data
  static delete(Task task) async {
    return await _db?.delete(_tableName, where: 'id=?', whereArgs: [task.id]);
  }

//update data
  static update(int id) async {
    return await _db!.rawUpdate('''
      UPDATE tasks
      SET isCompleted = ?
      WHERE id = ?
''', [1, id]);
  }
}
