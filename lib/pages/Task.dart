import 'package:flutter/material.dart';
import 'package:todo/pages/Home.dart';
import 'package:todo/model/Task.dart';

class TaskPage extends StatefulWidget {
  String id;
  String title;
  String text;
  Function edit;
  TaskPage(this.id, this.title, this.text, this.edit);

  @override
  _TaskPageState createState() => _TaskPageState(id, title, text, edit);
}

class _TaskPageState extends State<TaskPage> {
  String id;
  String title;
  String text;
  Function edit;
  _TaskPageState(this.id, this.title, this.text, this.edit);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('task'), actions: [
          IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                if (title != '' && text != '') {
                  edit(id, title, text);
                  Navigator.pop(context);
                } else {
                  showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                            title: Text('error'),
                            content: Text('enter text and title'),
                          ));
                }
              })
        ]),
        body: Padding(
            padding: EdgeInsets.all(5.0),
            child: Column(children: [
              Flexible(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextFormField(
                    initialValue: title,
                    onChanged: (String value) => setState(() {
                      title = value;
                    }),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration.collapsed(
                        hintText: "Enter your title here"),
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: TextFormField(
                    initialValue: text,
                    onChanged: (String value) => setState(() {
                      text = value;
                    }),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration.collapsed(
                        hintText: "Enter your text here"),
                  ),
                ),
              ),
            ])));
  }
}
