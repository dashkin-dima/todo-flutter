import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:uuid/uuid.dart';

class TaskModel {
  static SharedPreferences _preferences;

  static void getInstance() async {
    if (_preferences == null) {
      _preferences = await SharedPreferences.getInstance();
    }
  }

  static getTasks() async {
    TaskModel.getInstance();
    _preferences = await SharedPreferences.getInstance();
    List<dynamic> jsonData = _preferences.getString('tasks') != null
        ? jsonDecode(_preferences.getString('tasks'))
        : [];
    print(jsonData);    
    return jsonData;
  }

  static addTask(String title, String text) async {
    List<dynamic> tasks = await TaskModel.getTasks();
    tasks.add(
        {'id': Uuid().v1(), 'title': title, 'text': text});
    _preferences.setString('tasks', jsonEncode(tasks));
  }

  static editTask(String id, String title, String text) async {
    List<dynamic> tasks = await TaskModel.getTasks();
    tasks.forEach((task) {
      if (task['id'] == id) {
        task['title'] = title;
        task['text'] = text;
      }
    });
    _preferences.setString('tasks', jsonEncode(tasks));
  }

  static deleteTask(String id) async {
    List<dynamic> tasks = await TaskModel.getTasks();
    tasks.removeWhere((task) => task['id'] == id);
    _preferences.setString('tasks', jsonEncode(tasks));
  }
}
