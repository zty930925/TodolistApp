import 'package:flutter/material.dart';

class CommonDrawer {
  static Drawer getDrawer(BuildContext context) {
    return Drawer(
        child: ListView(
      children: [
        ListTile(
          title: const Text('執行清單'),
          onTap: () {
            Navigator.pushNamed(context, "/todolist");
          },
        )
      ],
    ));
  }
}
