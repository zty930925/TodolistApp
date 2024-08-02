import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:android_app_hw/models/todo.dart';
//json轉dart可操作的dart map > jsondecode
//dart可操作的 dart map 轉 json > jsonencode

//----------------------------------------------------------------------------------

//建立函式todolocalfile > 用來建立「管理本地」的資料儲存區
class Todolocalfile extends ChangeNotifier {
  //定義資料傳輸的路徑
  //定義變數_localPath使用異步處理，提升用戶載具裝置的運算使用率
  //_localPath接async表示_localPath是異步函數
  Future<String> get _localPath async {
    //使用final聲明directory
    //使用final聲明的變數，只能賦值一次
    //directory使用await，表示directory是等待異步函數完成
    final directory = await getApplicationDocumentsDirectory();
    //回傳directory變數的路徑，以便後續將用戶輸入的內容以此路徑傳到本地資料儲存區
    return directory.path;
  }

  //定義本地的資料要透過哪一個傳輸路徑取得
  Future<File> get _localFile async {
    //使用final聲明path，path接await > 等待異步函數完成
    //利用變數path取得資料的傳輸路徑
    final path = await _localPath;
    //在本地儲存區下創建一個名為todos.json的文件，並將取得到的資料傳到todos.json文件
    return File('$path/todos.json');
  }

  //讀取json文件並將其轉換為相應的todo欄位內容
  //建立函式read_todo，並使用異步處理
  Future<List<Todo>> read_todo() async {
    //使用try、catch來處理錯誤
    try {
      //使用final聲明變數file
      //調用_localFile函式，從todos.json文件中取出使用者輸入的項目資料
      final file = await _localFile;
      //條件判斷
      if (await file.exists()) {
        //讀取文件內容為字符串
        final contents = await file.readAsString();
        //將字符串內容解析為JSON數據
        final jsonData = json.decode(contents);
        //將JSON數據轉換為todo對象列表並返回
        return (jsonData as List)
            .map((json) => Todo.create_jsontype(json))
            .toList();
      } else {
        // 如果文件不存在，返回一個空列表
        return [];
      }
      //捕獲異常的問題
    } catch (e) {
      //輸出錯誤信息
      print('Error reading todos: $e');
      //同樣也是返回一個空列表
      return [];
    }
  }

  //將todo對象列表寫入JSON文件
  Future<void> write_todo(List<Todo> todos) async {
    // 使用final聲明變數file
    // 調用_localFile函式，從todos.json文件中取出使用者輸入的項目資料
    final file = await _localFile;
    // 將todo對象列表，透過調用override_json函式，轉換為JSON字符串
    final jsonData =
        json.encode(todos.map((todo) => todo.override_json()).toList());
    // 將JSON字符串寫入文件
    await file.writeAsString(jsonData);
  }
}
