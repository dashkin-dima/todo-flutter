import 'package:flutter/material.dart';
import 'package:todo/model/Task.dart';
import 'package:todo/pages/Task.dart';

class TaskList extends StatefulWidget {
  TaskList();

  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: TaskModel.getTasks(),
        builder: (context, snapshot) {
          return Container(
            child: ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, int index) {
                  return Dismissible(
                      direction: DismissDirection.endToStart,
                      background: Container(color: Colors.red),
                      child: Card(
                          elevation: 2.0,
                          margin:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          child: Container(
                            constraints: BoxConstraints.expand(
                              height: 50,
                            ),
                            padding: const EdgeInsets.fromLTRB(0, 2, 12, 2),
                            child: ListTile(
                                title: GestureDetector(
                                    onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => TaskPage(
                                                snapshot.data[index]['id'],
                                                snapshot.data[index]['title'],
                                                snapshot.data[index]['text'],
                                                edit))),
                                    child: Text(snapshot.data[index]['title'],
                                        overflow: TextOverflow.ellipsis))),
                          )),
                      key: UniqueKey(),
                      onDismissed: (direction) =>
                          TaskModel.deleteTask(snapshot.data[index]['id']));
                }),
          );
        });
  }

  void edit(String id, String title, String text) {
    TaskModel.editTask(id, title, text);
    setState(() {});
  }
}
