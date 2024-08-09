import 'package:flutter/material.dart';
import 'package:android_app_hw/models/todo.dart';
import 'package:android_app_hw/models/user.dart';
import 'package:android_app_hw/daos/todo_dao_local_file.dart';
import 'package:android_app_hw/daos/user_dao_local_file.dart';
import '../service/work_note_service.dart';
import 'package:intl/intl.dart';

// todo的一覽頁
// 使用StatefulWidget來讓畫面可以刷新(與時俱進)
class TodoListScreen extends StatefulWidget {
  @override
  //定義一個畫面，展示與管理todo清單
  _TodoListScreenState createState() => _TodoListScreenState();
}

//定義狀態類，用於管理畫面的狀態變化
class _TodoListScreenState extends State<TodoListScreen> {
  //建立本地文件存取的數據訪問對象
  final TodoDaoLocalFile _todoDao = TodoDaoLocalFile();
  final UserDaoLocalFile _userDao = UserDaoLocalFile();
  final WorkNoteService _workNoteService = WorkNoteService();

  //設定文字輸入框的控制器，負責讀取和管理用戶的輸入
  final TextEditingController _controller = TextEditingController();

  //初始化To-Do清單和使用者的數據
  List<Todo> _todos = [];
  User _user = User(totalTodos: 0, completeTodos: 0);

  //初始化狀態時，自動載入本地的Todo和使用者數據
  @override
  void initState() {
    super.initState();
    //調用方法載入數據
    _loadData();
  }

  //從本地檔案中讀取Todo清單和使用者數據
  Future<void> _loadData() async {
    //讀取todo清單
    final todos = await _todoDao.readTodos();
    //讀取使用者數據
    final user = await _userDao.readUser();
    setState(() {
      _todos = todos; //更新狀態中的todo清單
      _user = user; //更新狀態中的使用者數據
    });
  }

  //_addTodo、_deleteTodo、_toggleTodoStatus對_user、_todos的操作只有更新畫面而已
  //真正去修改json的是service/work_note_service.dart

  // 新增todo
  // 會去寫入todo.json和user.json
  void _addTodo() async {
    final description = _controller.text; //取得用戶輸入的描述
    if (description.isNotEmpty) {
      //輸入建構子縮需欄位，建立一個新的todo項目
      final newTodo = Todo(
        isComplete: false,
        content: description,
        creationTime: DateTime.now(),
      );
      setState(() {
        _todos.add(newTodo); //將新項目加入清單
        _user.totalTodos++; //更新使用者的總todo數量
      });
      _workNoteService.addTodo(newTodo);
      _controller.clear(); //清空文字輸入框
    }
  }

  // 刪除todo
  // 會去更新todo.json和user.json
  void _deleteTodo(int index) async {
    if (_todos[index].isComplete) {
      _user.completeTodos--;
    }
    setState(() {
      _todos.removeAt(index);
      _user.totalTodos--;
    });
    _workNoteService.deleteTodoAtIndex(index);
  }

  // 更新todo的狀態
  // 會去更新todo.json和user.json
  void _toggleTodoStatus(int index) async {
    final todo = _todos[index];
    setState(() {
      if (todo.isComplete) {
        todo.isComplete = false; //若已完成，則標記為未完成
        todo.finishTime = null; //清空完成時間
        _user.completeTodos--; //減少已完成數量
      } else {
        todo.isComplete = true;
        todo.finishTime = DateTime.now();
        _user.completeTodos++;
      }
    });
    await _todoDao.writeTodos(_todos); //將更新後的Todo清單寫回本地檔案
    await _userDao.writeUser(_user); //將更新後的使用者數據寫回本地檔案
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('代辦清單'),
      ),
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: '輸入代辦項目',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: _addTodo,
              child: Text('新增項目'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _todos.length,
                itemBuilder: (context, index) {
                  final todo = _todos[index];
                  final creationTimeFormatted = DateFormat('yyyy-MM-dd – kk:mm')
                      .format(todo.creationTime);
                  //final deletTimeFormatted =
                  //DateFormat('yyyy-MM-dd – kk:mm').format(todo.finishTime!);
                  return ListTile(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          //'完成時間:$deletTimeFormatted',
                          todo.content,
                          style: TextStyle(
                            decoration: todo.isComplete
                                ? TextDecoration.lineThrough // 已完成則添加刪除線
                                : TextDecoration.none, // 未完成則無任何裝飾
                          ),
                        ),
                        Text(
                          '新增時間: $creationTimeFormatted', // 顯示創建時間
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                    leading: Checkbox(
                      value: todo.isComplete, // 顯示該項目是否已完成
                      onChanged: (_) => _toggleTodoStatus(index), // 切換完成狀態
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete), // 刪除按鈕
                      onPressed: () => _deleteTodo(index), // 點擊後刪除該項目
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(50),
              child: Text(
                  '項目總數: ${_user.totalTodos}, 已完成: ${_user.completeTodos}項'),
            ),
          ],
        ),
      ),
    );
  }
}
