import 'package:flutter/material.dart';

class ScreenController {
  bool isLoginScreen = true;

  // 切換螢幕並返回相應的路由名稱
  String toggleScreen() {
    if (isLoginScreen) {
      isLoginScreen = false;
      return "/login";
    } else {
      isLoginScreen = true;
      return "/todolist";
    }
  }
}
