import 'package:flutter/material.dart';
import 'package:android_app_hw/models/user.dart';

class UserComponent extends StatefulWidget {
  User user;
  UserComponent(this.user);
  @override
  State createState() {
    return _UserComponentState();
  }
}

class _UserComponentState extends State<UserComponent> {
  @override
  Widget build(BuildContext context) {
    Widget userText = Container(
      child: Text(
        "目前的Todo數量為: " +
            this.widget.user.all_todo.toString() +
            "/n目前完成的Todo數量為: " +
            this.widget.user.done_todo.toString(),
        style: TextStyle(fontSize: 28, fontWeight: FontWeight.w400),
      ),
    );
    return Container(
      width: 500,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [userText],
      ),
    );
  }
}
