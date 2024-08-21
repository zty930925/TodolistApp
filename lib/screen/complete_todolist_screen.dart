import 'package:flutter/material.dart';
import '../components/common_drawer.dart';
import '../models/user.dart';
import '../models/todo.dart';
import '../daos/todo_dao_local_file.dart';
import '../daos/user_dao_local_file.dart';
import '../components/complete_todo_component.dart';

//已完成todo項目的一覽頁
//會過濾/篩選出已完成的todo項目
class CompleteTodolistScreen extends StatefulWidget {
  @override
  _CompleteTodolistScreenState createState() => _CompleteTodolistScreenState();
}

class _CompleteTodolistScreenState extends State<CompleteTodolistScreen> {
  //建立本地待辦事項和使用者的數據訪問對象
  final TodoDaoLocalFile _todoDao = TodoDaoLocalFile();
  final UserDaoLocalFile _userDao = UserDaoLocalFile();

  //初始化todo清單與使用者資料
  List<Todo> _todos = [];
  User _user = User(totalTodos: 0, completeTodos: 0);

  //畫面美更新一次，就調用此方法進行畫面渲染
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  //異步方法，將本地文件數據加載近來
  Future<void> _loadData() async {
    //從本地文件讀取所有待辦事項
    final todos = await _todoDao.readTodos();
    //從本地文件讀取使用者資料
    final user = await _userDao.readUser();
    setState(() {
      _todos = todos; //更新待辦事項列表
      _user = user; //更新使用者資料
    });
  }

  @override
  //實現build方法
  //加載資料並過濾已完成的待辦事項
  Widget build(BuildContext context) {
    _loadData();
    //篩選出已完成的todo項目

    //先建立一個新的列表tmpTodo > 用於儲存已完成的todo項目
    List<Todo> tmpTodo = [];
    //使用for迴圈，逐一讀取_todos列表中的todo項目( i++ )
    //直到將整個_todos列表中的todo項目都讀過一次( i < _todos.length )
    //宣告並初始化一個變數i( int i = 0 ) > 表示目前迴圈的索引(index)
    for (int i = 0; i < _todos.length; i++) {
      //如果地i個索引值為真(true)
      if (_todos[i].isComplete == true) {
        //就將已完成的待辦事項加入已完成todo項目的列表tmpTodo中
        tmpTodo.add(_todos[i]);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('已完成項目'),
      ),
      drawer: CommonDrawer.getDrawer(context),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: tmpTodo.length,
              itemBuilder: (context, index) {
                final todo = tmpTodo[index];
                return CompleteTodoComponent(todo, index);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('已完成: ${_user.completeTodos}個項目'),
          ),
        ],
      ),
    );
  }
}
