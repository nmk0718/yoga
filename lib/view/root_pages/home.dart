import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:yoga/api/request.dart';
import 'package:yoga/model/BannerData.dart';
import 'package:yoga/model/IconsDatas.dart';
import 'LimitedTimePurchase.dart';
import 'SearchShopping.dart';

class HomePage extends StatefulWidget {
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _currentPageIndex = 0;

  void get_HomeDatas() async {

    Response Banner = await RequestService.SearchBanner();
    BannerData bannerdata = BannerData.fromJson(json.decode(Banner.toString()));
    setState(() {
      bannerdatas = bannerdata;
    });

    Response Icons = await RequestService.SearchIcons();
    IconsDatas iconsdata = IconsDatas.fromJson(json.decode(Icons.toString()));
    setState(() {
      iconsdatas = iconsdata;
    });
  }

  BannerData bannerdatas;
  IconsDatas iconsdatas;
  PageController controller;
  int selectindex = 0;

  @override
  void initState() {
    super.initState();
    get_HomeDatas();
    controller = PageController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "首页",
          textAlign: TextAlign.left,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => SearchShopping()));
            },
          ),
          IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
        ],
      ),
      body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                //第一区域
                Container(
                  height: 150,
                  child: PhysicalModel(
                    color: Colors.transparent, //设置背景底色透明
                    borderRadius: BorderRadius.circular(12),
                    clipBehavior: Clip.antiAlias, //注意这个属性
                    child: Container(
                      child: Swiper(
                          itemBuilder: (BuildContext context, int index) {
                            return Image.network(
                              bannerdatas.banners[index].bannerUrl,
                              fit: BoxFit.cover,
                            );
                          },
                          itemCount:
                          bannerdatas == null ? 0 : bannerdatas.banners.length,
                          autoplay: true,
                          loop: false,
                          duration: 200,
                          onTap: (int index) {
                            print(index);
                          },
                          onIndexChanged: (index) {
                            setState(() {
                              _currentPageIndex = index;
                            });
                          }),
                    ),
                  ),
                ),
                //第二区域
                SizedBox(
                  height: 20,
                ),
                Container(
                  // color: Colors.red,
                  width: double.infinity,
                  height: 180.0,
                  child: GridView.builder(
                    physics: new NeverScrollableScrollPhysics(),
                    gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                      //横轴元素个数
                      crossAxisCount: 4,
                      //主轴间隔
                      mainAxisSpacing: 0.0,
                      //横轴间隔
                      crossAxisSpacing: 0.0,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            new Image.network(
                              iconsdatas.jingang[index].iconUrl,
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                            ),
                            Container(
                              alignment: Alignment.center,
                              height: 35.0,
                              child: Text(
                                iconsdatas.jingang[index].iconText,
                                style: TextStyle(fontSize: 12.0),
                              ),
                            ),
                          ],
                        ),
                        onTap: () {
                          print(index);
                        },
                      );
                    },
                    itemCount: iconsdatas == null ? 0 : iconsdatas.jingang.length,
                  ),
                ),
                //第三区域
                Row(
                  children: <Widget>[
                    GestureDetector(
                      child: Container(
                        height: 250,
                        width: 150,
                        decoration: new BoxDecoration(
                          color: Color(0xFFFAFAFA),
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: <Widget>[
                              Container(
                                child: Text(
                                  '品质限时购',
                                  style: TextStyle(fontSize: 18),
                                ),
                                width: double.infinity,
                              ),
                              Container(
                                child: Text(
                                  '20:20:20',
                                  style: TextStyle(fontSize: 18),
                                ),
                                width: double.infinity,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Image.network(
                                'https://img20.360buyimg.com/mobilecms/s300x300_jfs/t1/188282/33/12129/53304/60e53b53E2ae7726c/47a4f9d53af50463.png',
                                fit: BoxFit.fitWidth,
                              ),
                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return LimitedPurchase();
                        }));
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 15,
                      ),
                      child: Column(
                        children: <Widget>[
                          GestureDetector(
                            child: Container(
                              height: 120,
                              width: 185,
                              decoration: new BoxDecoration(
                                color: Colors.black12,
                                borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                              ),
                            ),
                            onTap: () {},
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          GestureDetector(
                            child: Container(
                              height: 120,
                              width: 185,
                              decoration: new BoxDecoration(
                                color: Colors.black12,
                                borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                              ),
                            ),
                            onTap: () {},
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                //第四区域
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  child: Text(
                    '    好物说',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  color: Colors.black12,
                  width: double.infinity,
                  height: 200.0,
                ),
                //第五区域
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  child: Text(
                    '    猜你喜欢',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        color: Colors.yellow,
                        height: 200,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.red,
                        height: 200,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.blue,
                        height: 200,
                      ),
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }
}
