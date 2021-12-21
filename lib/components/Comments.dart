import 'package:flutter/material.dart';


class Comments extends StatefulWidget {
  @override
  _CommentsState createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  bool keyboard = false;


  @override
  Widget build(BuildContext context) {

    return Container(
              width: double.infinity, //设置宽度
                      child: Padding(
                        padding: EdgeInsets.only(top: 5,left: 10,right: 10,bottom: 10),
                        child:
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextField(
                              maxLines: null,
                              keyboardType: TextInputType.multiline,
                              style: TextStyle( //设置字体、颜色
                                fontSize: 16,
                              ),
                              decoration: InputDecoration( //设置提示内容，字体颜色、大小等
                                hintText: "发布回复推文",
                                hintStyle: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey,
                                ),
                                suffixIcon: keyboard == false ?Icon(Icons.camera_alt_outlined,color: Colors.blue,):null,
                              ),
                              onChanged: (text) {
                                // 获取时时输入框的内容
                                print(text);
                              },
                              onTap: (){
                                setState(() {
                                  keyboard = true;
                                });
                              },
                            ) ,
                            keyboard == false ? Container():SizedBox(height: 10,),
                            keyboard == false ? Container():Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Icon(Icons.image_outlined,color: Colors.blue,size: 25,),
                               GestureDetector( //点赞按钮样式
                                 onTap: () {
                                   FocusScope.of(context).requestFocus(FocusNode());//关闭键盘
                                   setState(() {
                                     keyboard = false;
                                   });
                                 },
                                 child: Container(
                                   height: 25,
                                   width: 50,
                                   alignment: Alignment.center,
                                   decoration: new BoxDecoration(
                                     color: Colors.blue,
                                     borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                   ),
                                     child: Text('回复',style: TextStyle(color: Colors.white),),
                                 ),
                               ),
                             ],
                           )
                          ],
                        ),
                      ),
              decoration: new BoxDecoration(
                border: Border(top: BorderSide(color:Color(0xffEDEDED),width: 1.5,),),
              ),
    );
  }
}
