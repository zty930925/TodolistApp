import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Todo的屬性要有狀態，描述，新增時間，完成時間
class Todo {
  //一個布林值(資料型態)，用來判斷todo項目是否完成
  bool isComplete;
  //定義任務內容的文本是String字串(資料型態)
  String content;
  //抓取行為執行時的時間
  DateTime GetTime;
  //建構子:用來初始化todolist類別的屬性
  //接收兩個參數:isComplete、content
  //使用this來簡化屬性的賦值
  Todo(this.isComplete, this.content, this.GetTime);

  //將todo清單中的資料(使用建構子的語法糖factory)逐一建立個別的json格式
  factory Todo.create_jsontype(Map<String, dynamic> json) {
    return Todo(
      json['isComplete'],
      json['content'],
      DateTime.parse(json['GetTime']),
    );
  }
  //將todo清單中的資料，以json格式覆寫上去
  Map<String, dynamic> override_json() {
    return {
      'isComplete': isComplete,
      'content': content,
      'GetTime': GetTime,
    };
  }
}

//建立todo的資料站存區
//provider套件中有ChangeNotifier，此蕾別具有notifyListeners函數
class todo_storage extends ChangeNotifier {
  //總資料存區
  List<Todo> todolist = [];
  //建立一個函式，用來回傳todolist資料暫存區
  List<Todo> gettodos() {
    return todolist;
  }

  //新增todo項目，指定新增的項目是字串、新增的項目本身
  void addtodo(String inputContent) {
    //新增todo項目，並添增到todolist中
    //新增todo項目，我們直接使用「在第12行建立的建構子」來新增todo項目即可
    todolist.add(Todo(false, inputContent, DateTime.now()));
    //通知訂閱者，重建ChangeNotifier，並更新狀態
    notifyListeners();
  }

  //更新todo項目，指定更新哪裡的項目、更新的項目本身
  void updatetodo(Todo newtodo) {
    //直接修改newtodo的GetTime，屬性為當前的時間。
    newtodo.GetTime = DateTime.now();
    //找到並更新指定的todo項目
    //使用indexOf()方法來找到項目的索引，然後用新的項目替換它
    todolist[todolist.indexOf(newtodo)] = newtodo;
    //通知訂閱者，重建ChangeNotifier，並更新狀態
    notifyListeners();
  }
}

//在函式外建立一個todo_storage，讓user.dart可以調用，以計算數量
//為一個全域的todo_storage
final todo_storage forcount_storage = todo_storage();
