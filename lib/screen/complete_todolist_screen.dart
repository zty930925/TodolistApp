import 'package:flutter/material.dart';
import '../components/common_drawer.dart';
import '../models/user.dart';
import '../models/todo.dart';
import '../daos/todo_dao_local_file.dart';
import '../daos/user_dao_local_file.dart';
import '../components/complete_todo_component.dart';

class CompleteTodolistScreen extends StatefulWidget {
  @override
  _CompleteTodolistScreenState createState() => _CompleteTodolistScreenState();
}

class _CompleteTodolistScreenState extends State<CompleteTodolistScreen> {
  final TodoDaoLocalFile _todoDao = TodoDaoLocalFile();
  final UserDaoLocalFile _userDao = UserDaoLocalFile();

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

  @override
  Widget build(BuildContext context) {
    _loadData();

    List<Todo> tmpTodo = [];
    for (int i = 0; i < _todos.length; i++) {
      if (_todos[i].isComplete == true) {
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
