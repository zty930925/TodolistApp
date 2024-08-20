//引入核心套件
import 'package:flutter/material.dart';

//建立類別函數CommonDrawer
class CommonDrawer {
  //使用getDrawer靜態函數，不用建立物件就可調用
  static Drawer getDrawer(BuildContext context) {
    //設置Drawer，並放置ListView，畫面超出時仍可滑動
    //為ListView分別放入ListTile，點擊時會跳轉到指定頁面
    return Drawer(
      //避免按鍵過多，超出畫面而異常，故使用ListView
      child: (ListView(
        //放入ListView專用的所有相關設定
        children: [
          ListTile(
            //按鈕名稱
            title: const Text('登入'),
            //設定要跳轉的頁面
            onTap: () {
              //要跳轉至色塊變化頁面，初步展示StatefulWudget
              Navigator.pushNamed(context, '/login');
            },
          ),
          ListTile(
            title: const Text('完整代辦清單'),
            onTap: () {
              Navigator.pushNamed(context, '/todolist');
            },
          ),
          ListTile(
            title: const Text('已完成項目'),
            onTap: () {
              Navigator.pushNamed(context, '/completed_todo');
            },
          ),
        ],
      )),
    );
  }
}
