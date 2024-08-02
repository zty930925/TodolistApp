import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:android_app_hw/components/common_drawer.dart';
import 'package:android_app_hw/components/todo_component.dart';
import 'package:android_app_hw/models/todo.dart'; // 导入 todo_storage

class TodoListScreen extends StatefulWidget {
  @override
  State createState() {
    return _TodoListScreen();
  }
}

class _TodoListScreen extends State<TodoListScreen> {
  @override
  Widget build(BuildContext context) {
    var textEditController = TextEditingController();

    //文字输入框
    Widget userInputTextField = Container(
      width: 500,
      child: TextField(
        decoration: InputDecoration(
            border: OutlineInputBorder(), hintText: "输入代辦事項..."),
        controller: textEditController,
        onSubmitted: (inputValue) {
          setState(() {
            context.read<todo_storage>().addtodo(inputValue);
            textEditController.clear();
          });
        },
      ),
    );

    return Scaffold(
      appBar: AppBar(),
      drawer: CommonDrawer.getDrawer(context),
      body: Container(
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            userInputTextField,
            Expanded(
              child: ListView(
                children: context
                    .watch<todo_storage>()
                    .gettodos()
                    .map((taskTodo) => Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TodoComponent(taskTodo),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 45.0), // 與Checkbox對其
                                child: Text(
                                  "現在時間: ${taskTodo.GetTime.toString()}",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                              Divider(),
                            ],
                          ),
                        ))
                    .toList(),
              ),
            ),
            Text(
                "目前的Todo數量為: " +
                    context.read<todo_storage>().gettodos().length.toString(),
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w400))
          ],
        ),
      ),
    );
  }
}
