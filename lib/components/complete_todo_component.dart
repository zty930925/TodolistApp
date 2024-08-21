import 'package:flutter/material.dart';
import '../models/todo.dart';

//已完成的Todo項目列表頁面
class CompleteTodoComponent extends StatefulWidget {
  //傳入要處理的核心資料（Todo項目和索引）
  final Todo todo; //Todo清單中的todo項目
  final int index; //Todo清單中的todo項目索引

  //建構函數 > 初始化已完成的Todo項目
  CompleteTodoComponent(this.todo, this.index);

  //因為後續需要頻繁更新畫面，故使用State來管理組件的狀態
  @override
  State createState() {
    return _CompleteTodoComponentState();
  }
}

//管理CompleteTodoComponent的狀態
class _CompleteTodoComponentState extends State<CompleteTodoComponent> {
  //實作build方法，用於建構畫面
  @override
  Widget build(BuildContext context) {
    //建立一個名為completeListTodo的Widget，代表已完成Todo項目的視覺呈現
    Widget completeListTodo =
        //使用ListTile設定每個已完成項目的內容和樣式
        ListTile(
            //顯示Todo項目的內容
            title: Text(
              this.widget.todo.content,
            ),
            //顯示已完成的圖示
            leading: Icon(
              Icons.check,
              color: Color.fromARGB(235, 255, 0, 0),
            ));
    //回傳一個Container > 將completeListTodo包裹起來
    return Container(
      child: completeListTodo,
    );
  }
}
