import 'package:flutter/material.dart';
import 'package:todo/pages/Home.dart';

class AddTaskPage extends StatefulWidget {
  Function add;
  AddTaskPage(this.add);

  @override
  _AddTaskPageState createState() => _AddTaskPageState(add);
}

class _AddTaskPageState extends State<AddTaskPage> {
  Function add;
  _AddTaskPageState(this.add);

  String title = '';
  String text = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('task'),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                if (title != '' && text != '') {
                  add(title, text);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                } else {
                  showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                            title: Text('error'),
                            content: Text('text and title should not be empty'),
                          ));
                }
              })
        ],
      ),
      body: Padding(
          padding: EdgeInsets.all(5.0),
          child: Column(children: [
            Flexible(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
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
                child: TextField(
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
          ])),
    );
  }
}
