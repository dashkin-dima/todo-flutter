import 'package:flutter/material.dart';
import 'package:todo/model/Task.dart';
import 'package:todo/pages/AddTask.dart';
import 'package:todo/widgets/TaskList.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
            title: Center(child: Text('TODO', textAlign: TextAlign.center))),
        body: TaskList(),
        floatingActionButton: IconButton(
            icon: Icon(Icons.add),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddTaskPage(add)))),
      ),
    );
  }

  void add(String title, String text) {
    TaskModel.addTask(title, text);
    setState(() {});
  }
}
