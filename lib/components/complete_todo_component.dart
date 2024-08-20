import 'package:flutter/material.dart';
import '../models/todo.dart';

class CompleteTodoComponent extends StatefulWidget {
  //帶狀態的核心資料
  Todo todo;
  int index;

  //建構子
  CompleteTodoComponent(this.todo, this.index);

  //指定依託的狀態
  @override
  State createState() {
    return _CompleteTodoComponentState();
  }
}

class _CompleteTodoComponentState extends State<CompleteTodoComponent> {
  //實作Build方法
  @override
  Widget build(BuildContext context) {
    Widget completeListTodo = ListTile(
        title: Text(
          this.widget.todo.content,
        ),
        leading: Icon(
          Icons.check,
          color: Colors.red,
        ));

    return Container(
      width: 500,
      child: completeListTodo,
    );
  }
}
