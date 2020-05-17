import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:todo/pages/addTask.dart';
import 'package:todo/pages/task.dart';

import 'package:todo/models/task.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('TODO')),
      ),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<Task>('TODO').listenable(),
        builder: (context, Box<Task> tasks, _) {
          if (tasks.values.isEmpty)
            return Center(
              child: Text("Todo list is empty"),
            );
          return ListView.builder(
            itemCount: tasks.values.length,
            itemBuilder: (context, index) {
              Task task = tasks.getAt(index);
              return Dismissible(
                  background: Container(color: Colors.red),
                  key: UniqueKey(),
                  onDismissed: (direction) {
                    task.delete();
                  },
                  child: Card(
                    elevation: 2.0,
                    margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Container(
                      constraints: BoxConstraints.expand(
                        height: 50,
                      ),
                      padding: const EdgeInsets.all(15),
                      child: GestureDetector(
                          child: Text(task.title),
                          onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => TaskPage(index)))),
                    ),
                  ));
            },
          );
          
        },
      ),
      
      floatingActionButton: IconButton(
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => AddTask())),
        icon: Icon(Icons.add),
      ),
    );
  }
}
