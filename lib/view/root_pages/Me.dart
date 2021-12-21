import 'dart:ui';

import 'package:flutter/material.dart';

import 'OrderList.dart';

class MePage extends StatefulWidget {
  MePageState createState() => MePageState();
}

class MePageState extends State<MePage> {
  String dropdownValue = 'One';
  List me = ['联系客服', '收货地址', '售后服务', '设置'];
  List icons = [
    Icon(Icons.phone_enabled_rounded),
    Icon(Icons.add_location),
    Icon(Icons.email),
    Icon(Icons.build)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              '我的',
              textAlign: TextAlign.left,
            ),
            Text(
              '编辑',
              textAlign: TextAlign.right,
              style: TextStyle(color: Colors.black38, fontSize: 15),
            ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Column(
            children: <Widget>[
              //圆形头像
              CircleAvatar(
                //头像半径
                radius: 40,
                //头像图片
                backgroundImage: NetworkImage(
                    'https://pic2.zhimg.com/v2-639b49f2f6578eabddc458b84eb3c6a1.jpg'),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                '养猫少女',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              FlatButton(
                child: new Text('积分 1024'),
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.black12,
                      width: 0.5,
                    ),
                    borderRadius: BorderRadius.circular(20)),
                onPressed: () {},
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(
                  width: 10,
                ),
                Column(children: <Widget>[
                  Text(
                    '2',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '优惠券',
                    style: TextStyle(color: Colors.black54),
                  ),
                ]),
                Container(
                  width: 1,
                  height: 30,
                  color: Colors.black12,
                ),
                Column(children: <Widget>[
                  Text(
                    '34',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '收藏夹',
                    style: TextStyle(color: Colors.black54),
                  ),
                ]),
                Container(
                  width: 1,
                  height: 30,
                  color: Colors.black12,
                ),
                Column(children: <Widget>[
                  Text(
                    '45',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '足迹',
                    style: TextStyle(color: Colors.black54),
                  ),
                ]),
                SizedBox(
                  width: 10,
                ),
              ],
            ),
          SizedBox(
            height: 15,
          ),
          Container(
            height: 10,
            width: double.infinity,
            color: Colors.grey.withOpacity(0.1),
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(15),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "我的订单",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    GestureDetector(
                      child: Row(
                        children: <Widget>[
                          Text(
                            "全部订单",
                            style:
                                TextStyle(fontSize: 13, color: Colors.black45),
                          ),
                          Icon(Icons.keyboard_arrow_right,
                              color: Colors.black26),
                        ],
                      ),
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return OrderList();
                        }));
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(children: <Widget>[
                      Icon(Icons.monetization_on),
                      Text(
                        '待付款',
                        style: TextStyle(color: Colors.black54),
                      ),
                    ]),
                    Column(children: <Widget>[
                      Icon(Icons.shopping_bag),
                      Text(
                        '待发货',
                        style: TextStyle(color: Colors.black54),
                      ),
                    ]),
                    Column(children: <Widget>[
                      Icon(Icons.directions_car),
                      Text(
                        '待收货',
                        style: TextStyle(color: Colors.black54),
                      ),
                    ]),
                    Column(children: <Widget>[
                      Icon(Icons.favorite),
                      Text(
                        '待评价',
                        style: TextStyle(color: Colors.black54),
                      ),
                    ]),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: 10,
            width: double.infinity,
            color: Colors.grey.withOpacity(0.1),
          ),
          ListView.builder(
            itemCount: 4,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return ListTile(
                leading: icons[index],
                title: Transform(
                  transform: Matrix4.translationValues(-20, 0.0, 0.0),
                  child: Text(
                    me[index],
                    style: TextStyle(fontSize: 13),
                  ),
                ),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {},
              );
            },
          ),
        ],
      ),
    );
  }
}
