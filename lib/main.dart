import 'package:flutter/material.dart';
import '../controller/screen_controller.dart';

//將用戶訪問路徑轉到對應controller
void main() {
  //初始化flutter框架
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ScreenController());
}
