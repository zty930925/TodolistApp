import 'package:flutter/material.dart';
import 'package:android_app_hw/screen/login_screen.dart';
import 'package:android_app_hw/screen/todo_list_screen.dart';
//import 'package:android_app_hw/daos/todo_dao_local_file.dart';
//import 'package:android_app_hw/daos/user_dao_local_file.dart';
import 'package:provider/provider.dart';
import 'package:android_app_hw/models/todo.dart';
import 'package:android_app_hw/models/user.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => todo_storage()), // 添加 todo_storage 提供程序
        Provider(create: (_) => User(0, 0)), // 初始化 User 类的实例
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Todo_List_App",
      theme: ThemeData(primarySwatch: Colors.blue),
      routes: {
        "/login": (BuildContext context) => LoginScreen(),
        "/todolist": (BuildContext context) => TodoListScreen(),
      },
      initialRoute: "/login",
    );
  }
}
