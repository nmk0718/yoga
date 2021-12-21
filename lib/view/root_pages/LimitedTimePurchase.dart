import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class LimitedPurchase extends StatefulWidget {
  LimitedPurchaseState createState() => LimitedPurchaseState();
}

class LimitedPurchaseState extends State<LimitedPurchase> {
  var imgs = [
    'images/banner1.png',
    'images/banner2.png',
    'images/banner3.png',
    'images/banner4.png'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0.0,
        ),
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 80,
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                child: Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 600,
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            left: 50,
                            top: 100,
                            bottom: 50,
                            right: 50,
                            child: Container(
                              decoration: new BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black12,
                                        offset: Offset(5.0, 5.0), //阴影y轴偏移量
                                        blurRadius: 10, //阴影模糊程度
                                        spreadRadius: 1 //阴影扩散程度
                                    )
                                  ],
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 100,
                            left: 100,
                            child: Image.asset(
                              imgs[index],
                              fit: BoxFit.cover,
                              height: 250,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: imgs.length,
                ),
              ),
            ),
          ],
        ));
  }
}
