import 'package:flutter/material.dart';
import 'package:android_app_hw/models/todo.dart';

//建立類別TodoComponent類別，並繼承StatefulWidget
//將用來讀取Todo，並進行組件渲染
class TodoComponent extends StatefulWidget {
  Todo todo;
  TodoComponent(this.todo);

  //由於會更新任務是否完成，因此這個組件會有重新渲染的需求
  //關聯檔案：todo_dao.dart檔
  @override
  //有重新渲染畫面的需求
  //因此建立一函數createState，指定目前要使用的狀態(建立_TodoComponentState變數，在調用)
  State createState() {
    return _TodoComponentState();
  }
}

//為_TodoComponentState建立狀態類別
class _TodoComponentState extends State<TodoComponent> {
  @override
  //視覺化目的:希望Todo有效轉成具有勾選框、任務文字描述的組件
  Widget build(BuildContext context) {
    Widget checkTaskCompletBox = Container(
      //建立Checkbox
      child: Checkbox(
        //給定value
        value: this.widget.todo.isComplete,
        //給定onChanged:放入帶有參數的函數
        //userCheck為bool型態，用戶勾選時:true;未勾選:false
        onChanged: (userCheck) {
          //用戶點擊時，會將偵測到的內容值更新回原組件todo的isComplete屬性
          //並使用setState從新渲染畫面
          setState(() {
            this.widget.todo.isComplete = userCheck!;
          });
        },
      ),
    );

    //設定文字，並依照todo的iscomplete作為樣式的判斷，true:有刪除縣;false:無刪除線
    //條件判斷除了if、else，也可用:
    //var abc = (條件) ? 若為true的傳回值 ; 若為flase的回傳值
    Widget taskText = Container(
      child: Text(this.widget.todo.content,
          style: (this.widget.todo.isComplete == true)
              ? TextStyle(decoration: TextDecoration.lineThrough)
              : TextStyle()),
    );

    //將兩個小組件(checkTaskCompletBox、taskText)整合起來，放進Row中(組件以水平方式排列)
    //完成TodoComponent、將Todo從資料轉化成Widget的過程
    return Container(
      width: 500,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [checkTaskCompletBox, taskText],
      ),
    );
  }
}
