import 'package:flutter/material.dart';
import '../components/todo_component.dart'; // Import the new component
import '../models/todo.dart';
import '../models/user.dart';
import '../components/common_drawer.dart';
import '../daos/todo_dao_local_file.dart';
import '../daos/user_dao_local_file.dart';
import '../service/work_note_service.dart';
//import 'package:intl/intl.dart';

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final TodoDaoLocalFile _todoDao = TodoDaoLocalFile();
  final UserDaoLocalFile _userDao = UserDaoLocalFile();
  final WorkNoteService _workNoteService = WorkNoteService();
  final TextEditingController _controller = TextEditingController();

  List<Todo> _todos = [];
  User _user = User(totalTodos: 0, completeTodos: 0);

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final todos = await _todoDao.readTodos();
    final user = await _userDao.readUser();
    setState(() {
      _todos = todos;
      _user = user;
    });
  }

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
      _controller.clear();
    }
  }

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

  void _toggleTodoStatus(int index) async {
    final todo = _todos[index];
    setState(() {
      if (todo.isComplete) {
        todo.isComplete = false;
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
  //畫面的視覺呈現
  //實現build方法
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('完整代辦清單'),
      ),
      //建置側邊選單
      drawer: CommonDrawer.getDrawer(context),
      body: Column(
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
                return TodoComponent(
                  todo: todo,
                  index: index,
                  onDelete: _deleteTodo,
                  onToggle: _toggleTodoStatus,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(50),
            child:
                Text('項目總數: ${_user.totalTodos}, 已完成: ${_user.completeTodos}項'),
          ),
        ],
      ),
    );
  }
}
