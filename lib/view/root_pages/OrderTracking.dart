import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class OrderTracking extends StatefulWidget {
  OrderTrackingState createState() => OrderTrackingState();
}

class OrderTrackingState extends State<OrderTracking> {
  List mdata = ['待收货', '已发货', '备货中', '已下单'];
  List datas = [
    '[收货地址]广州市泰兴大厦',
    '猫猫说物流中心已发货,正在前往清关口岸 14:44',
    '订单正在打包 14:46',
    '支付成功,系统正在处理 14:44'
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(children: <Widget>[
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
          Container(
            width: double.infinity,
            color: Colors.white,
            child: Text(
              '    订单跟踪',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Stack(
                children: <Widget>[
                  Container(
                    color: Colors.black26,
                  ),
                  Positioned(
                      left: 10,
                      top: 10,
                      right: 10,
                      child: Container(
                        height: 90,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: 80,
                              width: 80,
                              margin: EdgeInsets.all(5), //设置图片的边距
                              child: Image.network(
                                'https://img14.360buyimg.com/n5/s200x200_jfs/t1/110381/1/8322/80006/5e6845d7E2308a308/c4bc985d94b8551e.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 10,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(width: 130,child: Text('已发货',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),),
                                SizedBox(height: 10,),
                                Text('EMS:  36373894997',style: TextStyle(color: Colors.grey),),
                              ],
                            ),
                          ],
                        ),
                      ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 400,
            child: ListView.builder(
                physics:NeverScrollableScrollPhysics(),
                itemCount: mdata.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: <Widget>[
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        child: Text('04-29'),
                      ),
                      // PaintCirLineItem(
                      //   35,
                      //   index,
                      //   // 时间轴部件
                      //   leftWidget: Icon(
                      //     Icons.circle,
                      //     size: 10,
                      //     color: Colors.black12,
                      //   ),
                      //   isDash: true,
                      //   marginLeft: 5,
                      //   leftLineColor: Colors.black12,
                      //   contentLeft: 50,
                      //   // mygradient: gradient,
                      //   alignment: Alignment.centerLeft,
                      //   //虚线长度
                      //   // DottedSpacing:5,
                      //   cententWight: Column(
                      //     children: <Widget>[
                      //       Container(
                      //         width: 250,
                      //         child: Text(mdata[index]),
                      //       ),
                      //       SizedBox(
                      //         height: 10,
                      //       ),
                      //       Container(
                      //         width: 250,
                      //         decoration: BoxDecoration(
                      //           color: Color(0xFFFAFAFA),
                      //           borderRadius:
                      //               BorderRadius.all(Radius.circular(8.0)),
                      //         ),
                      //         child: Padding(
                      //           padding: EdgeInsets.all(10),
                      //           child: Text(
                      //             datas[index],
                      //             maxLines: 2,
                      //           ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      //   timeAxisLineWidth: 2,
                      // ),
                    ],
                  );
                }),
          ),
        ]),
      ),
    );
  }
}
