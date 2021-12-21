import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yoga/root_page.dart';

class UserInfo extends StatefulWidget {
  UserInfoState createState() => UserInfoState();
}

class UserInfoState extends State<UserInfo> {

  File headimage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          elevation: 0,
          title: Container(
              width: double.infinity,
              child: GestureDetector(
                child: Text(
                  '以后再说',
                  style: TextStyle(fontSize: 13),
                  textAlign: TextAlign.end,
                ),
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return RootPage();
                  }));
                },
              ))),
      body: Padding(
        padding: EdgeInsets.only(left: 40, right: 40, top: 80, bottom: 0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: Text(
                '请完善个人信息',
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: <Widget>[
                GestureDetector(
                  child: CircleAvatar(
                    //头像半径
                    radius: 40,
                    //头像图片
                    backgroundColor: headimage != null ?null:Color(0xFFB39DDB),
                    backgroundImage: headimage != null ?FileImage(File(headimage.path)):null,
                    child: Icon(Icons.camera_alt_outlined,color: Colors.white,),
                  ),
                  onTap: () async {
                   var image = await ImagePicker().pickImage(source: ImageSource.gallery);
                   headimage = File(image.path);
                   setState(() {
                   });
                  },
                )
              ],
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                hintText: '用户名',
              ),
            ),
            SizedBox(height: 40),
            Container(
              width: double.infinity,
              height: 50,
              child: RaisedButton(
                color: Color(0xFFFFF176),
                child: Text(
                  '完成注册',
                  style: TextStyle(color: Colors.black),
                ),
                elevation: 0.0,
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      new MaterialPageRoute(builder: (context) => RootPage()),
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
          ],
        ),
      ),
    );
  }
}
