import 'package:flutter/material.dart';
import 'package:android_app_hw/models/todo.dart';
import 'package:android_app_hw/models/user.dart';
import 'package:android_app_hw/daos/todo_dao_local_file.dart';
import 'package:android_app_hw/daos/user_dao_local_file.dart';
import '../service/work_note_service.dart';
import 'package:intl/intl.dart';

// todo的一覽頁
// 使用StatefulWidget來讓畫面可以刷新
class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final TodoDaoLocalFile _todoDao = TodoDaoLocalFile();
  final UserDaoLocalFile _userDao = UserDaoLocalFile();
  final WorkNoteService _workNoteService = WorkNoteService();

  // 設定文字輸入框的控制器
  final TextEditingController _controller = TextEditingController();

  // 設定初始值
  List<Todo> _todos = [];
  User _user = User(totalTodos: 0, completeTodos: 0);

  // 每次刷新都去重新讀取todo.json和user.json
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  // 讀取todo.json和user.json
  Future<void> _loadData() async {
    final todos = await _todoDao.readTodos();
    final user = await _userDao.readUser();
    setState(() {
      _todos = todos;
      _user = user;
    });
  }

  // 新增todo
  // 會去寫入todo.json和user.json
  void _addTodo() async {
    final description = _controller.text;
    if (description.isNotEmpty) {
      final newTodo = Todo(
        isComplete: false,
        content: description,
        creationTime: DateTime.now(),
      );
      setState(() {
        _todos.add(newTodo);
        _user.totalTodos++;
      });
      _workNoteService.addTodo(newTodo);
      /* await _todoDao.writeTodos(_todos);
      await _userDao.writeUser(_user); */
      _controller.clear();
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
        todo.isComplete = false;
        todo.finishTime = null;
        _user.completeTodos--;
      } else {
        todo.isComplete = true;
        todo.finishTime = DateTime.now();
        _user.completeTodos++;
      }
    });
    await _todoDao.writeTodos(_todos);
    await _userDao.writeUser(_user);
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
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                          ),
                        ),
                        Text(
                          '新增時間: $creationTimeFormatted',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                    leading: Checkbox(
                      value: todo.isComplete,
                      onChanged: (_) => _toggleTodoStatus(index),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _deleteTodo(index),
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
