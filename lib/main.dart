import 'package:flutter/material.dart';
import 'package:android_app_hw/screen/login_screen.dart';
import 'package:android_app_hw/screen/todo_list_screen.dart';
import 'package:android_app_hw/screen/complete_todolist_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        "/login": (BuildContext context) => LoginScreen(),
        "/todolist": (BuildContext context) => TodoListScreen(),
        "/completed_todo": (BuildContext context) => CompleteTodolistScreen(),
      },
      initialRoute: "/login",
    );
  }
}
