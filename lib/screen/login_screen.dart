import 'package:android_app_hw/components/common_drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:android_app_hw/daos/user_dao_local_file.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        drawer: CommonDrawer.getDrawer(context),
        body: TextButton(
            onPressed: () {
              Navigator.pushNamed(context, "/todolist");
            },
            child: Text("登入")));
  }
}
