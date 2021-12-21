import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:yoga/view/root_pages/UserInfo.dart';

class VerificationCode extends StatelessWidget {
  String input_phone;
  String input_code = '';

  VerificationCode({this.input_phone});

  final _formKey = GlobalKey<FormState>();
  final _pinPutController = TextEditingController();
  final _pinPutFocusNode = FocusNode();
  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: Color(0xFFEEEEEE),
    borderRadius: BorderRadius.circular(5.0),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 40,right: 40,top: 80,bottom: 0),
        child: Column(children: [
          Container(
            width: double.infinity,
            child: Text(
              '请输入验证码',
              style: TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(height: 10,),
          Container(
            width: double.infinity,
            child: Text(
              '已发送4位验证码到${input_phone}',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 13,
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            height: 70,
            // color: Colors.redAccent,
            margin: const EdgeInsets.all(10.0),
            padding: const EdgeInsets.all(10.0),
            child: PinPut(
              fieldsCount: 4,
              onSubmit: (String pin) {
                print(pin);
              },
              onChanged: (text) {
                input_code = text;
              },
              focusNode: _pinPutFocusNode,
              controller: _pinPutController,
              submittedFieldDecoration: pinPutDecoration,
              selectedFieldDecoration: pinPutDecoration,
              followingFieldDecoration: pinPutDecoration,
            ),
            // child: onlySelectedBorderPinPut(),
          ),
          SizedBox(height: 20),
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
                if (input_code != '') {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return UserInfo();
                  }));
                } else {
                  Fluttertoast.showToast(
                    msg: "请输入验证码",
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
          SizedBox(height: 10),
          Container(
            width: double.infinity,
            child: Text(
              '重新获取',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
              textAlign: TextAlign.start,
            ),
          ),
        ]),
      ),
    );
  }
}
