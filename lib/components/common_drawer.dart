//引入核心套件
import 'package:flutter/material.dart';

//建立類別函數CommonDrawer
//這是一個側邊選單
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
          //第一個按鈕
          ListTile(
            //按鈕名稱
            title: const Text('登入'),
            //設定欲跳轉的頁面
            onTap: () {
              //跳轉至登入頁面
              Navigator.pushNamed(context, '/login');
            },
          ),
          //第二個按鈕
          ListTile(
            //按鈕名稱
            title: const Text('完整代辦清單'),
            //設定欲跳轉的頁面
            onTap: () {
              //跳轉至todolist一覽頁
              Navigator.pushNamed(context, '/todolist');
            },
          ),
          //第三個按鈕
          ListTile(
            //按鈕名稱
            title: const Text('已完成項目'),
            //設定欲跳轉的頁面
            onTap: () {
              //跳轉至completed_todo的一覽頁(只顯示已完成的項目)
              Navigator.pushNamed(context, '/completed_todo');
            },
          ),
        ],
      )),
    );
  }
}
