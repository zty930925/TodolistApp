import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:android_app_hw/models/user.dart';

//使用本地檔案來儲存和讀取 User 清單的資料

class UserDaoLocalFile {
  //取得本地儲存檔案的路徑
  Future<String> GetLocalPath() async {
    //使用final宣告directory，讓directory實踐「路徑取得」
    final directory = await getApplicationDocumentsDirectory();
    //回傳該路徑
    return directory.path;
  }

  //定義本地儲存檔案的位置
  Future<File> GetLocalFile() async {
    //用final宣告path，調用當前的路徑取得檔案
    final path = await GetLocalPath();
    //回傳一個資料夾，在該路徑下建立user.json
    return File('$path/user.json');
  }

  //從user.json中讀取User清單資料
  //Future<User> readUser() async {
  //try {
  //使用final宣告file，用於取得user.json
  //final file = await GetLocalFile();
  //使用final宣告contents，用於讀取user.json字符串(dart不可用)
  //final contents = await file.readAsString();
  //使用final宣告jsonData，將字符串解碼成dart可用的資料結構
  //final jsonData = jsonDecode(contents);
  //將每個Json物件轉換為User物件並返回
  //return User.fromJson(jsonData);
  //} catch (e) {
  //return User(totalTodos: 0, completeTodos: 0);
  //}
  //}

  Future<User> readUser() async {
    try {
      final file = await GetLocalFile();
      final contents = await file.readAsString();
      final jsonData = jsonDecode(contents);
      final user = User.fromJson(jsonData);

      // 確保completeTodos和totalTodos不會是負數
      if (user.completeTodos < 0) {
        user.completeTodos = 0;
      }
      if (user.totalTodos < 0) {
        user.totalTodos = 0;
      }

      return user;
    } catch (e) {
      return User(totalTodos: 0, completeTodos: 0);
    }
  }

  //將User清單寫入到user.json檔案中
  Future<File> writeUser(User user) async {
    final file = await GetLocalFile();
    return file.writeAsString(jsonEncode(user.toJson()));
  }
}
