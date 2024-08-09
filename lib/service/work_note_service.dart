import '../models/todo.dart';
//import '../models/user.dart';
import '../daos/todo_dao_local_file.dart';
import '../daos/user_dao_local_file.dart';
//該檔案才是真正修改json資料的(通則：先讀，讀到了才可以進行修改)
//當用戶新增todo的時候， 會記錄用戶有幾個todo，會記錄todo內容
//當用戶刪除todo的時候，要減去用戶有幾個todo

class WorkNoteService {
  //建立本地文件存取的數據訪問對象
  final TodoDaoLocalFile _todoDao = TodoDaoLocalFile();
  final UserDaoLocalFile _userDao = UserDaoLocalFile();

  //新增todo
  //會去寫入todo.json和user.json
  Future<void> addTodo(Todo todo) async {
    final todos = await _todoDao.readTodos();
    todos.add(todo);
    await _todoDao.writeTodos(todos);

    final user = await _userDao.readUser();
    user.totalTodos++;
    await _userDao.writeUser(user);
  }

  //刪除todo
  //會去更新todo.json和user.json
  Future<void> deleteTodoAtIndex(int index) async {
    final todos = await _todoDao.readTodos();
    final todo = todos[index];
    todos.removeAt(index);
    await _todoDao.writeTodos(todos);

    final user = await _userDao.readUser();
    user.totalTodos--;
    if (todo.isComplete == true) {
      user.completeTodos--;
    }
    await _userDao.writeUser(user);
  }

  //更新todo的狀態
  //會去更新todo.json和user.json
  Future<void> updateTodoStatus(int index, String status) async {
    final todos = await _todoDao.readTodos();
    final todo = todos[index];
    todo.isComplete;
    if (todo.isComplete == true) {
      todo.creationTime = DateTime.now();
    }
    await _todoDao.writeTodos(todos);

    final user = await _userDao.readUser();
    if (todo.isComplete == true) {
      user.completeTodos++;
    } else if (todo.isComplete == false) {
      user.completeTodos--;
    }
    await _userDao.writeUser(user);
  }
}
