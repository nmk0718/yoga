import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'VerificationCode.dart';

class Register extends StatelessWidget {
  String input_phone = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          elevation: 0,
          title: Container(
            width: double.infinity,
            child: Text(
              '邮箱注册',
              style: TextStyle(fontSize: 13),
              textAlign: TextAlign.end,
            ),
          )),
      body: Padding(
        padding: EdgeInsets.only(left: 40, right: 40, top: 80, bottom: 0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: Text(
                '请输入您的手机号',
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            TextField(
              maxLength: 11,
              keyboardType: TextInputType.number,
              onChanged: (text) {
                input_phone = text;
              },
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              width: double.infinity,
              height: 50,
              child: RaisedButton(
                color: Color(0xFFFFF176),
                child: Text(
                  '下一步',
                  style: TextStyle(color: Colors.black),
                ),
                elevation: 0.0,
                onPressed: () {
                  if (input_phone !='') {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return VerificationCode(input_phone: input_phone);
                    }));
                  } else {
                    Fluttertoast.showToast(
                      msg: "请输入手机号",
                      toastLength: Toast.LENGTH_SHORT,
                    );
                  }
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
            Container()
          ],
        ),
      ),
    );
  }
}
