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

    // 確保已完成項目數不會變成負數
    if (todo.isComplete && user.completeTodos > 0) {
      user.completeTodos--;
    }

    await _userDao.writeUser(user);
  }

  //更新todo的狀態
  //會去更新todo.json和user.json
  Future<void> updateTodoStatus(int index, bool isComplete) async {
    final todos = await _todoDao.readTodos();
    final todo = todos[index];

    // 檢查完成狀態是否更新
    if (todo.isComplete != isComplete) {
      todo.isComplete = isComplete;
      await _todoDao.writeTodos(todos);

      final user = await _userDao.readUser();

      // 若狀態是已完成，則增加完成項目數
      if (isComplete) {
        user.completeTodos++;
      }
      // 若狀態從已完成變為未完成，且已完成項目大於0，則減少
      else if (!isComplete && user.completeTodos > 0) {
        user.completeTodos--;
      }
      await _userDao.writeUser(user);
    }
  }
}
