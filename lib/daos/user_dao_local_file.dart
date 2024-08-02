import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart'; // 导入 ChangeNotifier
import 'package:android_app_hw/models/user.dart';

class UserLocalFile extends ChangeNotifier {
  User _user = User(0, 0); // 默認用户

  User get user => _user;

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/user.json');
  }

  Future<void> readUser() async {
    try {
      final file = await _localFile;
      if (await file.exists()) {
        final contents = await file.readAsString();
        final jsonData = json.decode(contents);
        _user = User.create_jsontype(jsonData);
      } else {
        _user = User(0, 0); // 默認用户
      }
      notifyListeners(); // 通知监听器数据已更新
    } catch (e) {
      print('Error reading user: $e');
      _user = User(0, 0); // 默認用户
      notifyListeners(); // 通知监听器数据已更新
    }
  }

  Future<void> writeUser(User userData) async {
    final file = await _localFile;
    final jsonData = json.encode(userData.override_json());
    await file.writeAsString(jsonData);
    _user = userData;
    notifyListeners(); // 通知监听器数据已更新
  }
}
