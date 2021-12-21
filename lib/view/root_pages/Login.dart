import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yoga/root_page.dart';

import 'Register.dart';

class Login extends StatefulWidget {
  const Login({
    Key key,
  }) : super(key: key);

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(ScreenUtil().setWidth(40)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              children: [
                Container(
                  width: double.infinity,
                  child: Text(
                    '喵~',
                    style: TextStyle(fontSize: 45.sp),
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: Text(
                    '欢迎来到喜来购',
                    style: TextStyle(fontSize: 45.sp),
                  ),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    hintText: '手机/邮箱',
                    hintStyle:
                        TextStyle(color: Color(0xFFBDBDBD), fontSize: 30.sp),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                TextField(
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    hintText: '请输入密码',
                    hintStyle:
                        TextStyle(color: Color(0xFFBDBDBD), fontSize: 30.sp),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  width: double.infinity,
                  child: Text(
                    '忘记密码',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 25.sp,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Container(
                  width: 400.w,
                  child: RaisedButton(
                    color: Color(0xFFFFF176),
                    child: Text(
                      '登 录',
                      style: TextStyle(color: Colors.black),
                    ),
                    elevation: 0.0,
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          new MaterialPageRoute(
                              builder: (context) => RootPage()),
                          (route) => route == null);
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0),
                        bottomLeft: Radius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '还没有账户?',
                      style: TextStyle(
                        fontSize: 28.sp,
                      ),
                    ),
                    GestureDetector(
                      child: Text(
                        ' 立即注册',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Color(0xFFFFF176),
                          fontSize: 28.sp,
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return Register();
                        }));
                      },
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      width: 230.w,
                      height: 50.h,
                      child: Row(
                        children: <Widget>[
                          Container(
                            height: 1,
                            width: 230.w,
                            color: Color(0xFFBDBDBD),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      left: 20,
                      bottom: 2,
                      child: Container(
                        color: Colors.white,
                        width: 80,
                        child: Text(
                          '第三方登录',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFFBDBDBD),
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 50.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      width: 100.r,
                      height: 100.r,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle, //可以设置角度，BoxShape.circle直接圆形
                        color: Color(0xFFEEEEEE),
                      ),
                      child: Icon(
                        Icons.favorite,
                        color: Colors.grey,
                      ),
                    ),
                    Container(
                      width: 100.r,
                      height: 100.r,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle, //可以设置角度，BoxShape.circle直接圆形
                        color: Color(0xFFEEEEEE),
                      ),
                      child: Icon(
                        Icons.star,
                        color: Colors.grey,
                      ),
                    ),
                    Container(
                      width: 100.r,
                      height: 100.r,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle, //可以设置角度，BoxShape.circle直接圆形
                        color: Color(0xFFEEEEEE),
                      ),
                      child: Icon(
                        Icons.wb_cloudy,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
