import 'package:flutter/material.dart';
import '../models/todo.dart';
import '../service/work_note_service.dart';

//所有todo項目(含已/未完成項目)的一覽頁
class TodoComponent extends StatefulWidget {
  //傳入要處理的核心資料（Todo項目和索引）
  final Todo todo; //Todo清單中的todo項目
  final int index; //Todo清單中的todo項目索引
  //建構函數 > 初始化Todo項目
  TodoComponent(this.todo, this.index);

  @override
  State createState() {
    return _TodoComponentState();
  }
}

//為_TodoComponentState建立畫面/畫面狀態
class _TodoComponentState extends State<TodoComponent> {
  //建立本地文件存取的數據訪問對象
  final WorkNoteService _workNoteService = WorkNoteService();

  //實作build方法，用於建構畫面
  @override
  Widget build(BuildContext context) {
    //建立一個名為listTodo的Widget，代表單一Todo項目的視覺呈現
    Widget listTodo =
        //設定每一todo項目的內容及樣式
        ListTile(
      title: Text(
        this.widget.todo.content,
        //如果Todo項目已完成，則在文字上加刪除線，否則使用普通樣式
        style: (this.widget.todo.isComplete == true)
            //「?」代表條件為真(true)時...
            //如果Todo已完成，則在文字上加刪除線
            ? TextStyle(decoration: TextDecoration.lineThrough)
            //「:」代表條件為假(false)時...
            //如果Todo未完成，則使用普通樣式(維持默認樣式)
            : TextStyle(),
      ),
      //用Checkbox顯示並控制todo項目完成狀態
      leading: Checkbox(
        //value > Checkbox的屬性 > 顯示Todo項目的完成狀態
        value: this.widget.todo.isComplete,
        //當用戶點擊一下後
        onChanged: (usercheck) {
          //更新當前todo的完成狀態
          if (usercheck != null) {
            _workNoteService.updateTodoStatus(
                this.widget.index, usercheck.toString());
            setState(() {
              this.widget.todo.isComplete = usercheck;
            });
          }
        },
      ),
      //用IconButton顯示刪除按鈕並刪除todo項目
      trailing: IconButton(
        icon: Icon(Icons.delete),
        //當點擊時 > 會觸發WorkNoteService類別中的刪除方法
        //提取項目索引值並刪除
        onPressed: () {
          //更新本地存儲中的Todo狀態
          _workNoteService.deleteTodoAtIndex(this.widget.index);
          //從新渲染畫面 > 反映狀態變更
          //通知flutter，State物件的某些屬性發生了變化 > flutter重新執行build方法更新畫面
          setState(() {});
        },
      ),
    );

    //使用Container包裹listTodo
    return Container(
      child: listTodo,
    );
  }
}
