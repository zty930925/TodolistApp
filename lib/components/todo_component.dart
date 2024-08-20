import 'package:flutter/material.dart';
import '../models/todo.dart';
import '../service/work_note_service.dart';

class TodoComponent extends StatefulWidget {
  //帶狀態的核心資料
  Todo todo;
  int index;
  //建構子
  TodoComponent(this.todo, this.index);

  //有重新渲染畫面的需求
  //因此建立一函數createState，指定目前要使用的狀態
  //建立變數_TodoComponentState，後續再調用
  @override
  State createState() {
    return _TodoComponentState();
  }
}

//為_TodoComponentState建立畫面/畫面狀態
class _TodoComponentState extends State<TodoComponent> {
  //建立本地文件存取的數據訪問對象
  final WorkNoteService _workNoteService = WorkNoteService();

  //實作Build方法
  @override
  Widget build(BuildContext context) {
    Widget listTodo = ListTile(
      title: Text(
        this.widget.todo.content,
        style: (this.widget.todo.isComplete == true)
            ? TextStyle(decoration: TextDecoration.lineThrough)
            : TextStyle(),
      ),
      leading: Checkbox(
        value: this.widget.todo.isComplete,
        onChanged: (usercheck) {
          if (usercheck != null) {
            _workNoteService.updateTodoStatus(
                this.widget.index, usercheck.toString());
            setState(() {
              this.widget.todo.isComplete = usercheck;
            });
          }
        },
      ),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () {
          _workNoteService.deleteTodoAtIndex(this.widget.index);
          setState(() {});
        },
      ),
    );

    return Container(
      width: 500,
      child: listTodo,
    );
  }
}
