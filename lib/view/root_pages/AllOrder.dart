import 'package:flutter/material.dart';

import 'OrderDetails.dart';
import 'OrderTracking.dart';

class AllOrder extends StatefulWidget {
  AllOrderState createState() => AllOrderState();
}

class AllOrderState extends State<AllOrder> {
  List TextList = ['【Acana】爱肯拿五谷鸡肉鱼配方全猫粮 1.8kg', '【Nutram】纽顿无谷低升糖全龄猫粮 5.45kg'];
  List kouweiList = ['鸡肉味嘎嘣脆 1.8kg', '鸡肉味嘎嘣脆5.45kg'];
  List moneyList = ['￥228', '￥520'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0))),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('订单号:  274939208'),
                  Text('待评价'),
                ],
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 2,
          ),
          GestureDetector(
            child: Container(
              height: 240,
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: ListView.builder(
                  itemCount: 2,
                  // itemExtent: 100,
                  itemBuilder: (context, index) {
                    return Column(children: <Widget>[
                      Container(
                        height: 110, //设置item的高度
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
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Container(
                                  width: 252,
                                  color: Colors.white,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        width: 180,
                                        child: Text(TextList[index]),
                                      ),
                                      Container(
                                        child: Text(
                                          moneyList[index],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 252,
                                  color: Colors.white,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        // width: 180,
                                        child: Text(kouweiList[index]),
                                      ),
                                      Container(
                                        // width: 72,
                                        child: Text('x1'),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        height: 0,
                        // Divider 组件高度
                        thickness: 0.5,
                        // 分割线线宽，分割线居于 Divider 中心
                        indent: 85,
                        // 分割线左侧间距
                        endIndent: 0,
                        // 分割线右侧间距
                        color: Colors.black12, // 分割线颜色
                      ),
                    ]);
                  },
                ),
              ),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return OrderDetails();
              }));
            },
          ),
          Container(
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text('共2件 合计'),
                  Text('￥748'),
                ],
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 2,
          ),
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
                    child: Text('订单跟踪'),
                    onTap: () {
                      Navigator.of(context)
                          .push(
                          MaterialPageRoute(builder: (context) {
                        return OrderTracking();
                      }
                      ));
                    },
                  ),
                  Container(
                    width: 1,
                    height: 20,
                    color: Color(0xFFECEFF1),
                  ),
                  Text('评价'),
                  Container(
                    width: 1,
                    height: 20,
                    color: Color(0xFFECEFF1),
                  ),
                  Text('再次购买')
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
