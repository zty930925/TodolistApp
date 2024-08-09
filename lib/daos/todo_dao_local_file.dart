import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/todo.dart';

//會讀寫更新本地todos.json

class TodoDaoLocalFile {
  //取得檔案路徑
  Future<String> GetLocalPath() async {
    //用final宣告directory，讓directory實踐「路徑取得」
    final directory = await getApplicationDocumentsDirectory();
    //回傳該路徑
    return directory.path;
  }

  //定義從哪裡取得檔案
  Future<File> GetLocalFile() async {
    //用final宣告path，調用當前的路徑取得檔案
    final path = await GetLocalPath();
    //回傳一個資料夾，在該路徑下建立todo.json
    return File('$path/todo.json');
  }

  //讀取Todo清單中的資料成todo.json
  Future<List<Todo>> readTodos() async {
    //try、catch處理錯誤
    try {
      //用final宣告file，用於取得todo.json
      final file = await GetLocalFile();
      //用final宣告contents，用於將檔案讀取成字符串(dart不可直接用)
      final contents = await file.readAsString();
      //Todo清單的資料型態較多元，使用dynamic
      //將JSON字符串解碼成Dart 的原生資料結構map、list...，這樣dart才可使用
      List<dynamic> jsonData = jsonDecode(contents);
      // 將每個JSON物件轉換為Todo物件並返回
      return jsonData.map((json) => Todo.fromJson(json)).toList();
      //若抓到錯誤(e for error)
    } catch (e) {
      //回傳一個空清單
      return [];
    }
  }

  //寫入todo.json檔案
  Future<File> writeTodos(List<Todo> todos) async {
    //寫入todo.json，必須先知道該檔案在哪裡，故調用GetLocalFile取得位置
    final file = await GetLocalFile();
    //逐一將todo項目轉成json格式，並寫入todo.json，並加入清單中
    return file
        .writeAsString(jsonEncode(todos.map((todo) => todo.toJson()).toList()));
  }
}
