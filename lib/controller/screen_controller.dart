import 'package:flutter/material.dart';
import '../screen/complete_todolist_screen.dart';
import '../screen/login_screen.dart';
import '../screen/todo_list_screen.dart';

class ScreenController extends StatelessWidget {
  const ScreenController({super.key});

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
