import 'package:flutter/material.dart';

//建立登入面
class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //建立文字按鈕
        body: TextButton(
            //點擊時，跳轉至todolist頁面
            onPressed: () {
              Navigator.pushNamed(context, "/todolist");
            },
            //按鈕中的文字內容為「登入」
            child: Text("登入")));
  }
}
