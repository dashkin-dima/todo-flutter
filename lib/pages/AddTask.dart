import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo/models/task.dart';

class AddTask extends StatefulWidget {

  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  String title;
  String text;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('add task'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _add,
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

  void _add() {
    final form = _formKey.currentState;
    if (form.validate()) {
      Box<Task> contactsBox = Hive.box<Task>('TODO');
      contactsBox.add(Task(title: title, text: text));
      Navigator.of(context).pop();
    } else {
      print('form is invalid');
    }
  }

}
