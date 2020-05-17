import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo/models/task.dart';

class TaskPage extends StatefulWidget {
  final int index;

  TaskPage(this.index);
  @override
  _TaskPageState createState() => _TaskPageState(index);
}

class _TaskPageState extends State<TaskPage> {
  Task task;

  String title;
  String text;

  int index;

  _TaskPageState(this.index);

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _getTask();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('task'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: _edit,
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    autofocus: true,
                    initialValue: title,
                    decoration: const InputDecoration(
                      labelText: 'Task',
                    ),
                    onChanged: (value) {
                      setState(() {
                        title = value;
                      });
                    },
                    validator: (value) {
                      return value.trim().isEmpty
                          ? 'title should not be empty'
                          : null;
                    },
                  ),
                  TextFormField(
                    initialValue: text,
                    decoration: const InputDecoration(
                      labelText: 'Note',
                    ),
                    onChanged: (value) {
                      setState(() {
                        text = value == null ? '' : value;
                      });
                    },
                    validator: (value) {
                      return value.trim().isEmpty
                          ? 'text should not be empty'
                          : null;
                    }
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _getTask() {
    Box<Task> tasks = Hive.box<Task>('TODO');
    Task task = tasks.getAt(index);
    title = task.title;
    text = task.text;
  }

  void _edit() {
    final form = _formKey.currentState;
    if (form.validate()) {
      task.title = title;
      task.text = text;
      task.save();
      Navigator.of(context).pop();
    } else {
      print('form is invalid');
    }
  }
}
