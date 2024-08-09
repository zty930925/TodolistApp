import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:android_app_hw/models/user.dart';

//使用本地檔案來儲存和讀取 User 清單的資料

class UserDaoLocalFile {
  //取得本地儲存檔案的路徑
  Future<String> GetLocalPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  //定義本地儲存檔案的位置
  Future<File> GetLocalFile() async {
    final path = await GetLocalPath();
    return File('$path/user.json');
  }

  //從user.json中讀取User清單資料
  Future<User> readUser() async {
    try {
      final file = await GetLocalFile();
      final contents = await file.readAsString();
      final jsonData = jsonDecode(contents);
      return User.fromJson(jsonData);
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
