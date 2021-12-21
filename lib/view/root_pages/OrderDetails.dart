import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderDetails extends StatefulWidget {
  OrderDetailsState createState() => OrderDetailsState();
}

class OrderDetailsState extends State<OrderDetails> {
  List TextList = ['【Acana】爱肯拿五谷鸡肉鱼配方全猫粮 1.8kg', '【Nutram】纽顿无谷低升糖全龄猫粮 5.45kg'];
  List kouweiList = ['鸡肉味嘎嘣脆 1.8kg', '鸡肉味嘎嘣脆5.45kg'];
  List moneyList = ['￥228', '￥520'];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(children: <Widget>[
            //返回键
            Container(
              alignment: Alignment(-0.98, 0),
              width: double.infinity,
              color: Colors.white,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios),
              ),
            ),
            //页面标题
            Container(
              width: double.infinity,
              color: Colors.white,
              child: Text(
                '    订单已确认',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              width: double.infinity,
              color: Colors.white,
              height: 10,
            ),
            SizedBox(
              height: 10,
            ),
            //收货地址
            Container(
              color: Colors.white,
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.all(25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '收货地址',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '黄焖鸡 18516566171',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      '广东省广州市越秀区泰兴商业大厦',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            //订单详情
            Container(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            '包裹',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            '已发货',
                            style: TextStyle(color: Colors.lightGreenAccent),
                          ),
                        ]),
                    SizedBox(
                      height: 10,
                    ),
                    //物流信息
                    Container(
                      width: 400,
                      decoration: BoxDecoration(
                        color: Color(0xFFFAFAFA),
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                '猫猫说HongKang物流中心已发货,正在前往清关口岸',
                                style: TextStyle(
                                  color: Colors.black38,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                '2021-06-09 17:05',
                                style: TextStyle(
                                  color: Colors.black38,
                                ),
                              ),
                            ],
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    //店铺
                    Container(
                        child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.home_filled,
                          color: Color(0xFFBDBDBD),
                          size: 17,
                        ),
                        Text(
                          '喜乐购官方自营店',
                          style: TextStyle(
                            color: Colors.black38,
                          ),
                        ),
                      ],
                    )),
                    SizedBox(
                      height: 10,
                    ),
                    //购买得订单
                    ScrollConfiguration(
                        behavior: CusBehavior(), // 自定义的 behavior
                        child: ListView.builder(
                          itemCount: 2,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Column(children: <Widget>[
                              Container(
                                height: 115, //设置item的高度
                                padding: EdgeInsets.all(5), //设置item的边距
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      height: 80,
                                      width: 80,
                                      margin: EdgeInsets.all(5), //设置图片的边距
                                      child: Image.network(
                                        'https://img14.360buyimg.com/n5/s200x200_jfs/t1/110381/1/8322/80006/5e6845d7E2308a308/c4bc985d94b8551e.jpg',
                                        fit: BoxFit.cover,
                                      ),
                                    ), //涉及到widget的大小或者边框的时候，使用container包裹
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Container(
                                          width: 240,
                                          color: Colors.white,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                width: 240,
                                                child: Text(TextList[index]),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: 242,
                                          color: Colors.white,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                child: Text(kouweiList[index]),
                                              ),
                                              Container(
                                                // width: 72,
                                                child: Text('x1'),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          // color: Colors.red,
                                          width: 240,
                                          height: 25,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Container(
                                                child: Text(
                                                  moneyList[index],
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 15),
                                                ),
                                              ),
                                              FlatButton(
                                                child: new Text('申请退货'),
                                                shape: RoundedRectangleBorder(
                                                    side: BorderSide(
                                                      color: Colors.black12,
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                onPressed: () {},
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ]);
                          },
                        ),
                      ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 2,
            ),
            //确认收货等功能键
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0))),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    GestureDetector(
                      child: Text('催包裹'),
                      onTap: () {},
                    ),
                    Container(
                      width: 1,
                      height: 20,
                      color: Color(0xFFECEFF1),
                    ),
                    Text('联系客服'),
                    Container(
                      width: 1,
                      height: 20,
                      color: Color(0xFFECEFF1),
                    ),
                    Text('查看物流'),
                    Container(
                      width: 1,
                      height: 20,
                      color: Color(0xFFECEFF1),
                    ),
                    Text('确认收货'),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            //价格明细
            Container(
              color: Colors.white,
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.all(25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '价格明细',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('订单编号'),
                            Text('274939208'),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('下单时间'),
                            Text('2019-04-01 08:23:39'),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('支付方式'),
                            Text('支付宝'),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('支付编号'),
                            Text('385939292'),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 25),
                    child: FlatButton(
                      child: new Text('删除订单'),
                      shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Colors.black12,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(20)),
                      onPressed: () {},
                    ),
                  )
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class CusBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    if (Platform.isAndroid || Platform.isFuchsia) return child;
    return super.buildViewportChrome(context, child, axisDirection);
  }
}