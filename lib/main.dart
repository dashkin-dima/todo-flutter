import 'package:flutter/material.dart';
import 'package:todo/pages/Home.dart';

void main() => runApp(TodoListApp());

class TodoListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Todo',
        theme: ThemeData(
          primaryColor: Color.fromRGBO(50, 65, 85, 1),
          textTheme: TextTheme(headline5: TextStyle(color: Colors.white)),
        ),
        home: HomePage());
  }
}
