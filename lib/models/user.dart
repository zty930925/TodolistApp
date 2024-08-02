import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:android_app_hw/models/todo.dart';

class User {
  int all_todo;
  int done_todo;
  User(this.all_todo, this.done_todo);
  factory User.create_jsontype(Map<String, dynamic> json) {
    return User(
      json['all_todo'],
      json['done_todo'],
    );
  }

  Map<String, dynamic> override_json() {
    return {'all_todo': all_todo, 'done_todo': done_todo};
  }

  // 獲取全部todo項目的數量
  int getAllTodoCount() {
    //回傳todolist暫存區的所有項目數量
    return forcount_storage.gettodos().length;
  }

  // 獲取已完成的todo項目的數量
  int getDoneTodoCount() {
    //回傳todolist暫存區中，已完成的todo項目有多少個
    return forcount_storage.gettodos().where((todo) => todo.isComplete).length;
  }
}
