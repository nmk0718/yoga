import 'dart:io';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yoga/view/root_pages/Login.dart';

void main() {
  runApp(MyApp());
  //状态栏
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      // statusBarColor: Colors.transparent,  //设置为透明
    );
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(750, 1624),
      builder: () => MaterialApp(
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.white,
          textTheme: TextTheme(button: TextStyle(fontSize: 30.sp)),
        ),
        debugShowCheckedModeBanner: false,
        title: 'yoga',
        home: Login(),
      ),
    );
  }
}
