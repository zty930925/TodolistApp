//import 'package:flutter/material.dart';

//頁面控制器(controller)
class ScreenController {
  //使用布林值，在兩個頁面之間做切換
  bool isLoginScreen = true;

  // 切換螢幕並返回相應的頁面
  String toggleScreen() {
    //如果isLoginScreen( = true)
    if (isLoginScreen) {
      //現在非登入頁面(在todolist頁面)，那我就要前往登入頁面
      isLoginScreen = false;
      return "/login";
    } else {
      //現在是登入頁面(非todolist頁面)，那我就要前往todolist頁面
      isLoginScreen = true;
      return "/todolist";
    }
  }
}
