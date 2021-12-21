import 'dart:convert';
import 'package:city_pickers/city_pickers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:yoga/api/request.dart';
import 'package:yoga/components/ProductSpecifications.dart';
import 'package:yoga/model/ProductPicture.dart';

class ProductDetails extends StatefulWidget {
  int id;
  String store;
  String store_icon;
  String product_name;
  String color;
  int price;
  int sales_volume;

  ProductDetails(
      {this.id,
      this.store,
      this.store_icon,
      this.product_name,
      this.sales_volume,
      this.price,
      this.color});

  ProductDetailsState createState() => ProductDetailsState(
      id: this.id,
      store: this.store,
      store_icon: this.store_icon,
      product_name: this.product_name,
      color: this.color,
      price: this.price,
      sales_volume: this.sales_volume);
}

class ProductDetailsState extends State<ProductDetails>
    with SingleTickerProviderStateMixin {
  int id;
  String store;
  String store_icon;
  String product_name;
  String color;
  int price;
  int sales_volume;

  ProductDetailsState(
      {this.id,
      this.store,
      this.store_icon,
      this.product_name,
      this.color,
      this.price,
      this.sales_volume});

  List images = [];

  List ImageList = [];

  List parameter1 = [
    '品牌',
    '适用年龄',
    '面料',
    '尺码',
    '领型',
    '主要颜色',
    '货号',
    '成分含量',
    '年份季节',
    '袖长',
    '衣长',
    '销售渠道类型',
    '材质成分'
  ];
  List parameter2 = [
    'UR',
    '25-29周岁 ',
    '棉 ',
    'S XS L M ',
    '圆领 ',
    '浅蓝 ',
    'YL17R4MN2003 ',
    '96%及以上 ',
    '2021年夏季 ',
    '短袖 ',
    '常规款',
    '商场同款(线上线下销售)',
    '棉100%'
  ];
  var Adress = '北京市朝阳区三环到四环之间';
  TabController tabController;
  int thumb_up_number = 1;
  Widget click = Icon(Icons.thumb_up_outlined);

  void get_picture() async {
    Response response =
        await RequestService.ProductDetails();

    if (response.statusCode == 200) {
      ProductPicture productpicture =
          ProductPicture.fromJson(json.decode(response.toString()));
      if (productpicture.productDetails == null) {
        print('没有此商品');
      } else {
        for (int i = 0; i < productpicture.productDetails.length; i++) {
          if (productpicture.productDetails[i].category == 'Carousel') {
            setState(() {
              images.add(productpicture.productDetails[i].picture);
            });
          } else {
            setState(() {
              ImageList.add(productpicture.productDetails[i].picture);
            });
          }
        }
      }
    }
  }

  void UpdateClickStauts() {
    setState(() {
      thumb_up_number++;
      click = Icon(Icons.thumb_up, color: Color(0xFFFFF176));
    });
  }

  List CommentImage = [
    'https://gtms03.alicdn.com/tps/i3/TB1yeWeIFXXXXX5XFXXuAZJYXXX-210-210.png',
    'https://gtms03.alicdn.com/tps/i3/TB1yeWeIFXXXXX5XFXXuAZJYXXX-210-210.png',
    'https://gtms03.alicdn.com/tps/i3/TB1yeWeIFXXXXX5XFXXuAZJYXXX-210-210.png',
    'https://gtms03.alicdn.com/tps/i3/TB1yeWeIFXXXXX5XFXXuAZJYXXX-210-210.png',
    'https://gtms03.alicdn.com/tps/i3/TB1yeWeIFXXXXX5XFXXuAZJYXXX-210-210.png',
    'https://gtms03.alicdn.com/tps/i3/TB1yeWeIFXXXXX5XFXXuAZJYXXX-210-210.png',
  ];
  List CommentName = [
    'Kay Totleben',
    'Mo Chun',
    'Gatsharan Sangrota',
    'Anton Brownstein',
    'Barbara Cotilla',
    'Jack'
  ];
  List CommentDate = [
    '2021-07-05 ',
    '2021-06-09 ',
    '2021-05-24 ',
    '2021-05-24',
    '2021-06-02',
    '2021-06-02'
  ];
  List CommentText = [
    '这件比另一件白色的厚一些，棉有点硬，手感不好，但上身效果不错',
    '颜色和拍照一样。厚实，挺喜欢的，质量很好。',
    '真的超级喜欢，非常支持，质量非常好，与卖家描述的完全一致，非常满意,真的很喜欢，完全超出期望值，发货速度非常快，包装非常仔细、严实，物流公司服务态度很好，运送速度很快，很满意的一次购物。',
    '衣衣漂亮，发货极快，购买体验极好，赞👍',
    '此用户没有填写评论!',
    '衣服好好看,下次还来购买'
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(vsync: this, length: 2);
    get_picture();
  }

  _tableRowList() {
    var count = parameter1.length;
    dynamic content;
    List<TableRow> Tlist = <TableRow>[];
    for (var i = 0; i < count; i++) {
      content = TableRow(
        children: [
          SizedBox(
            height: 25,
            child: Text(parameter1[i]),
          ),
          SizedBox(
            height: 25,
            child: Text(parameter2[i]),
          ),
        ],
      );
      Tlist.add(content);
    }
    return Tlist;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 12,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    //轮播图
                    Container(
                      height: 800,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            height: 400,
                            width: double.infinity,
                            child: (images != null && images.isNotEmpty)
                                ? Swiper(
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Image.network(
                                        images[index].toString(),
                                        fit: BoxFit.cover,
                                      );
                                    },
                                    itemCount: images.length,
                                    onTap: (int index) {
                                      print(index);
                                    },
                                  )
                                : Container(
                                    child: Text('暂无图片'),
                                  ),
                          ),
                          Positioned(
                            right: 10,
                            top: 20,
                            child: Container(
                              width: 35.0,
                              height: 35.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                //可以设置角度，BoxShape.circle直接圆形
                                color: Colors.white,
                              ),
                              child: Icon(
                                Icons.share,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Positioned(
                            right: 10,
                            top: 70,
                            child: Container(
                              width: 35.0,
                              height: 35.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                //可以设置角度，BoxShape.circle直接圆形
                                color: Colors.white,
                              ),
                              child: Icon(
                                Icons.favorite,
                                color: Colors.red,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 380,
                            left: 0,
                            right: 0,
                            child: Container(
                              height: 400,
                              width: double.infinity,
                              decoration: new BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30.0),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black12,
                                        offset: Offset(5.0, 5.0), //阴影y轴偏移量
                                        blurRadius: 10, //阴影模糊程度
                                        spreadRadius: 1 //阴影扩散程度
                                        )
                                  ]),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: 20, right: 20, bottom: 20, top: 10),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          '￥' + price.toString(),
                                          style: TextStyle(fontSize: 30),
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Container(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: <Widget>[
                                                  Icon(
                                                    Icons.star,
                                                    color: Colors.yellow[300],
                                                  ),
                                                  Text(
                                                    '4.9',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                ],
                                              ),
                                              width: 100,
                                            ),
                                            Row(
                                              children: <Widget>[
                                                Icon(
                                                  Icons.person_outline,
                                                  color: Colors.black12,
                                                ),
                                                Text(
                                                  sales_volume.toString() +
                                                      '人已购买',
                                                  style:
                                                      TextStyle(fontSize: 13),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      width: double.infinity,
                                      child: Text(
                                        product_name,
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    ProductSpecifications(
                                        titletext: '已选',
                                        text: color,
                                        onPress: () {
                                          showModalBottomSheet(
                                              builder: (BuildContext context) {
                                                //构建弹框中的内容
                                                return Container(
                                                  height: 500,
                                                  decoration: new BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius: new BorderRadius
                                                              .only(
                                                          topLeft: const Radius
                                                              .circular(25.0),
                                                          topRight: const Radius
                                                              .circular(25.0))),
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 20,
                                                        left: 20,
                                                        right: 20,
                                                        bottom: 0),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: <Widget>[
                                                        Row(
                                                          children: <Widget>[
                                                            Container(
                                                              height: 100,
                                                              width: 100,
                                                              child:
                                                                  Image.network(
                                                                'https://gw.alicdn.com/bao/uploaded/i4/2104668892/O1CN01hCrkOa2FYaUnhSpP9-2104668892.jpg',
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                            Column(
                                                              children: <
                                                                  Widget>[
                                                                Container(
                                                                  height: 30,
                                                                  width: 200,
                                                                  child: Row(
                                                                    children: <
                                                                        Widget>[
                                                                      Container(
                                                                        height:
                                                                            12,
                                                                        child:
                                                                            Text(
                                                                          '¥',
                                                                          style: TextStyle(
                                                                              color: Colors.red,
                                                                              fontSize: 12),
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        height:
                                                                            30,
                                                                        child:
                                                                            Text(
                                                                          '159',
                                                                          style: TextStyle(
                                                                              color: Colors.red,
                                                                              fontSize: 24),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                Container(
                                                                  width: 200,
                                                                  child: Row(
                                                                    children: <
                                                                        Widget>[
                                                                      Text(
                                                                        '已选',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.grey),
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            15,
                                                                      ),
                                                                      Text(
                                                                          '深蓝色印花, M ,1个'),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        Container(
                                                          width:
                                                              double.infinity,
                                                          child: Text('颜色'),
                                                        ),
                                                        Row(
                                                          children: <Widget>[
                                                            FlatButton(
                                                              child: Text(
                                                                  '深蓝色印花',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12)),
                                                              onPressed: () {},
                                                              color: Color(
                                                                  0x1AFF6631),
                                                              textColor:
                                                                  Colors.red,
                                                              disabledTextColor:
                                                                  Color(
                                                                      0xff999999),
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            20)),
                                                                side:
                                                                    BorderSide(
                                                                  color: Colors
                                                                      .red,
                                                                  width: 1.5,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Container(
                                                          width:
                                                              double.infinity,
                                                          child: Text('尺码'),
                                                        ),
                                                        Row(
                                                          children: <Widget>[
                                                            Container(
                                                              width: 50,
                                                              child: FlatButton(
                                                                child: Text(
                                                                    'XS',
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            12)),
                                                                onPressed:
                                                                    () {},
                                                                color: Color(
                                                                    0x1AFF6631),
                                                                textColor:
                                                                    Colors.red,
                                                                disabledTextColor:
                                                                    Color(
                                                                        0xff999999),
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.all(
                                                                          Radius.circular(
                                                                              20)),
                                                                  side:
                                                                      BorderSide(
                                                                    color: Colors
                                                                        .red,
                                                                    width: 1.5,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Container(
                                                              width: 40,
                                                              child:
                                                                  RaisedButton(
                                                                onPressed:
                                                                    () {},
                                                                child:
                                                                    Text('S'),
                                                                elevation: 0,
                                                                color: Color(
                                                                    0xFFF5F5F5),
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(20))),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Container(
                                                              width: 40,
                                                              child:
                                                                  RaisedButton(
                                                                onPressed:
                                                                    () {},
                                                                child:
                                                                    Text('M'),
                                                                elevation: 0,
                                                                color: Color(
                                                                    0xFFF5F5F5),
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(20))),
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Container(
                                                              width: 40,
                                                              child:
                                                                  RaisedButton(
                                                                onPressed:
                                                                    () {},
                                                                child:
                                                                    Text('L'),
                                                                elevation: 0,
                                                                color: Color(
                                                                    0xFFF5F5F5),
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(20))),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: <Widget>[
                                                            Text('数量'),
                                                            Row(
                                                              children: <
                                                                  Widget>[
                                                                GestureDetector(
                                                                  child:
                                                                      Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child:
                                                                        CircleAvatar(
                                                                      radius:
                                                                          15.0,
                                                                      backgroundColor:
                                                                          Color(
                                                                              0xFFF5F5F5),
                                                                      child:
                                                                          Text(
                                                                        '—',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontSize: 20),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  onTap: () {},
                                                                ),
                                                                SizedBox(
                                                                  width: 15,
                                                                ),
                                                                GestureDetector(
                                                                  child:
                                                                      Text('1'),
                                                                  onTap: () {},
                                                                ),
                                                                SizedBox(
                                                                  width: 15,
                                                                ),
                                                                GestureDetector(
                                                                  child:
                                                                      Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    child:
                                                                        CircleAvatar(
                                                                      radius:
                                                                          15.0,
                                                                      backgroundColor:
                                                                          Colors
                                                                              .yellow,
                                                                      child:
                                                                          Text(
                                                                        '+',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontSize: 20),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  onTap: () {},
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: <Widget>[
                                                            GestureDetector(
                                                              child: Container(
                                                                width: 150,
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            10),
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .red,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            (20.0))),
                                                                child: Text(
                                                                    '加入购物车',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            14)),
                                                              ),
                                                              onTap: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                            ),
                                                            GestureDetector(
                                                              child: Container(
                                                                width: 150,
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            10),
                                                                decoration: BoxDecoration(
                                                                    color: Colors
                                                                        .amber,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            (20.0))),
                                                                child: Text(
                                                                    '立即购买',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            14)),
                                                              ),
                                                              onTap: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                              backgroundColor:
                                                  Colors.transparent, //重要
                                              context: context);
                                        }),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    ProductSpecifications(
                                        titletext: '送至',
                                        text: Adress,
                                        onPress: () async {
                                          Result result =
                                              await CityPickers.showCityPicker(
                                                  context: context,
                                                  theme: Theme.of(context)
                                                      .copyWith(
                                                          primaryColor: Color(
                                                              0xfffe1314)),
                                                  // 设置主题
                                                  cancelWidget: Text(
                                                    '取消',
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xff999999)),
                                                  ),
                                                  confirmWidget: Text(
                                                    '确定',
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xfffe1314)),
                                                  ),
                                                  height: 220.0);
                                          if (result == null) {
                                            print('用户取消了选择配送地址');
                                          } else {
                                            setState(() {
                                              Adress = result.provinceName +
                                                  result.cityName +
                                                  result.areaName;
                                            });
                                          }
                                        }),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    ProductSpecifications(
                                        titletext: '服务',
                                        text: '30天无条件退货 · 假一赔十 · 全场包邮',
                                        onPress: () {
                                          showModalBottomSheet(
                                              builder: (BuildContext context) {
                                                //构建弹框中的内容
                                                return Container(
                                                  height: 400,
                                                  decoration: new BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius: new BorderRadius
                                                              .only(
                                                          topLeft: const Radius
                                                              .circular(25.0),
                                                          topRight: const Radius
                                                              .circular(25.0))),
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 20,
                                                        right: 20,
                                                        top: 10),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: <Widget>[
                                                        Text(
                                                          '服务',
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            Icon(
                                                              Icons
                                                                  .cloud_done_outlined,
                                                              color: Colors.red,
                                                              size: 18,
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            Text('商家发货&售后'),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: <Widget>[
                                                            SizedBox(
                                                              width: 22,
                                                            ),
                                                            Text(
                                                              '由UR官方旗舰店从 广东广州市 发货, 并提供售后服务',
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0XFF8c8c8c)),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            Icon(
                                                              Icons
                                                                  .cloud_done_outlined,
                                                              color: Colors.red,
                                                              size: 18,
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            Text('30天无条件退货'),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: <Widget>[
                                                            SizedBox(
                                                              width: 22,
                                                            ),
                                                            Text(
                                                              '正品保障，支持30天无条件退货',
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0XFF8c8c8c)),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            Icon(
                                                              Icons
                                                                  .cloud_done_outlined,
                                                              color: Colors.red,
                                                              size: 18,
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            Text('全场包邮'),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: <Widget>[
                                                            SizedBox(
                                                              width: 22,
                                                            ),
                                                            Text(
                                                              '支持全部地区包邮',
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0XFF8c8c8c)),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            Icon(
                                                              Icons
                                                                  .cloud_done_outlined,
                                                              color: Colors.red,
                                                              size: 18,
                                                            ),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            Text('假一赔十'),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: <Widget>[
                                                            SizedBox(
                                                              width: 22,
                                                            ),
                                                            Text(
                                                              '正品保障，假一赔十',
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0XFF8c8c8c)),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        GestureDetector(
                                                          child: Container(
                                                            width:
                                                                double.infinity,
                                                            padding:
                                                                EdgeInsets.all(
                                                                    10),
                                                            decoration: BoxDecoration(
                                                                color:
                                                                    Colors.red,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            (20.0))),
                                                            child: Text('确定',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        14)),
                                                          ),
                                                          onTap: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                              backgroundColor:
                                                  Colors.transparent, //重要
                                              context: context);
                                        }),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    ProductSpecifications(
                                        titletext: '参数',
                                        text: '品牌 适用年龄',
                                        onPress: () {
                                          showModalBottomSheet(
                                              builder: (BuildContext context) {
                                                //构建弹框中的内容
                                                return Container(
                                                  height: 500,
                                                  decoration: new BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius: new BorderRadius
                                                              .only(
                                                          topLeft: const Radius
                                                              .circular(25.0),
                                                          topRight: const Radius
                                                              .circular(25.0))),
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 20,
                                                        right: 20,
                                                        top: 0),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: <Widget>[
                                                        Text(
                                                          '基本信息',
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700),
                                                        ),
                                                        Container(
                                                          child: Table(
                                                            columnWidths: const {
                                                              0: FixedColumnWidth(
                                                                  100.0),
                                                              1: FixedColumnWidth(
                                                                  200.0),
                                                            },
                                                            children:
                                                                _tableRowList(),
                                                          ),
                                                          width:
                                                              double.infinity,
                                                        ),
                                                        // SizedBox(height: 10,),
                                                        GestureDetector(
                                                          child: Container(
                                                            width:
                                                                double.infinity,
                                                            padding:
                                                                EdgeInsets.all(
                                                                    10),
                                                            decoration: BoxDecoration(
                                                                color:
                                                                    Colors.red,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            (20.0))),
                                                            child: Text('确定',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        14)),
                                                          ),
                                                          onTap: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                              backgroundColor:
                                                  Colors.transparent, //重要
                                              context: context);
                                        }),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          height: 80,
                                          width: 80,
                                          child: Image.network(
                                            store_icon,
                                          ),
                                        ),
                                        Expanded(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Text(
                                                    '$store',
                                                    style:
                                                        TextStyle(fontSize: 19),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Container(
                                                    decoration:
                                                        new BoxDecoration(
                                                      color: Color(0xFFBDBDBD),
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(10.0),
                                                      ),
                                                    ),
                                                    child: Row(
                                                      children: <Widget>[
                                                        Text(
                                                          ' 综合体验',
                                                          style: TextStyle(
                                                              fontSize: 13,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        Icon(
                                                          Icons.star,
                                                          size: 12,
                                                          color: Colors.red,
                                                        ),
                                                        Icon(
                                                          Icons.star,
                                                          size: 12,
                                                          color: Colors.red,
                                                        ),
                                                        Icon(
                                                          Icons.star,
                                                          size: 12,
                                                          color: Colors.red,
                                                        ),
                                                        Icon(
                                                          Icons.star,
                                                          size: 12,
                                                          color: Colors.red,
                                                        ),
                                                        Icon(
                                                          Icons.star,
                                                          size: 12,
                                                          color: Colors.white,
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: <Widget>[
                                                  Text('宝贝描述4.8 平'),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text('卖家服务4.8 平'),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text('物流服务4.8 高'),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Expanded(
                                        child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        FlatButton(
                                          child: new Text('关注店铺'),
                                          shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                color: Colors.black12,
                                                width: 0.5,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          onPressed: () {},
                                        ),
                                        FlatButton(
                                          child: new Text('进入店铺'),
                                          shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                color: Colors.black12,
                                                width: 0.5,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          onPressed: () {},
                                        )
                                      ],
                                    )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListView.builder(
                        //根据内容大小显示高度
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            color: Colors.yellowAccent,
                            child: ImageList.length != 0
                                ? Image.network(
                                    ImageList[index].toString(),
                                    fit: BoxFit.fitWidth,
                                  )
                                : Container(
                                    child: Text('暂无图片'),
                                  ),
                          );
                        },
                        itemCount: ImageList.length),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    width: 1,
                  ),
                  GestureDetector(
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.comment),
                        Text('208'),
                      ],
                    ),
                    onTap: () {
                      showModalBottomSheet(
                          builder: (BuildContext context) {
                            //构建弹框中的内容
                            return Container(
                              height: 600,
                              decoration: new BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: new BorderRadius.only(
                                      topLeft: const Radius.circular(25.0),
                                      topRight: const Radius.circular(25.0))),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: 20, left: 0, right: 0, bottom: 0),
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 20, right: 20, bottom: 15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            '评论 (208)',
                                            style: TextStyle(fontSize: 20),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: <Widget>[
                                              Icon(
                                                Icons.star,
                                                color: Colors.yellow[300],
                                              ),
                                              Text(
                                                '4.9',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          width: 220,
                                          child: TabBar(
                                            controller: tabController,
                                            onTap: (index) {
                                              print(index);
                                            },
                                            unselectedLabelColor: Colors.grey,
                                            labelColor: Colors.black,
                                            isScrollable: false,
                                            indicator: const BoxDecoration(),
                                            tabs: <Widget>[
                                              Text(
                                                '好评 (206)',
                                              ),
                                              Text(
                                                '差评 (2)',
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(child: Container()),
                                      ],
                                    ),
                                    Expanded(
                                      child: SingleChildScrollView(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 20,
                                              right: 20,
                                              bottom: 0,
                                              top: 15),
                                          child: Container(
                                            height: 500,
                                            child: TabBarView(
                                              controller: tabController,
                                              children: <Widget>[
                                                ListView.builder(
                                                  itemCount: CommentText.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Column(
                                                        children: <Widget>[
                                                          Row(
                                                            children: <Widget>[
                                                              CircleAvatar(
                                                                //头像半径
                                                                radius: 24,
                                                                //头像图片
                                                                backgroundImage:
                                                                    NetworkImage(
                                                                  CommentImage[
                                                                      index],
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              Expanded(
                                                                  child: Column(
                                                                children: <
                                                                    Widget>[
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: <
                                                                        Widget>[
                                                                      Text(
                                                                        CommentName[
                                                                            index],
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.w600),
                                                                      ),
                                                                      Row(
                                                                        children: <
                                                                            Widget>[
                                                                          GestureDetector(
                                                                            child:
                                                                                click,
                                                                            onTap:
                                                                                () {
                                                                              UpdateClickStauts();
                                                                            },
                                                                          ),
                                                                          SizedBox(
                                                                            width:
                                                                                5,
                                                                          ),
                                                                          Text(
                                                                            thumb_up_number.toString(),
                                                                            style:
                                                                                TextStyle(fontSize: 15),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: <
                                                                        Widget>[
                                                                      Row(
                                                                        children: <
                                                                            Widget>[
                                                                          Icon(
                                                                            Icons.star,
                                                                            color:
                                                                                Color(0xFFFFF176),
                                                                          ),
                                                                          Icon(
                                                                            Icons.star,
                                                                            color:
                                                                                Color(0xFFFFF176),
                                                                          ),
                                                                          Icon(
                                                                            Icons.star,
                                                                            color:
                                                                                Color(0xFFFFF176),
                                                                          ),
                                                                          Icon(
                                                                            Icons.star,
                                                                            color:
                                                                                Color(0xFFFFF176),
                                                                          ),
                                                                          Icon(
                                                                            Icons.star,
                                                                            color:
                                                                                Color(0xFFFFF176),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Text(CommentDate[
                                                                          index]),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ))
                                                            ],
                                                          ),
                                                          Container(
                                                            width:
                                                                double.infinity,
                                                            child: Text(
                                                              CommentText[
                                                                  index],
                                                              maxLines: 2,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                ),
                                                ListView.builder(
                                                  itemCount:
                                                      CommentImage.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                          int index) {
                                                    return Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 10),
                                                      child: Column(
                                                        children: <Widget>[
                                                          Row(
                                                            children: <Widget>[
                                                              CircleAvatar(
                                                                //头像半径
                                                                radius: 24,
                                                                //头像图片
                                                                backgroundImage:
                                                                    NetworkImage(
                                                                  CommentImage[
                                                                      index],
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 10,
                                                              ),
                                                              Expanded(
                                                                  child: Column(
                                                                children: <
                                                                    Widget>[
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: <
                                                                        Widget>[
                                                                      Text(
                                                                        CommentName[
                                                                            index],
                                                                        style: TextStyle(
                                                                            fontWeight:
                                                                                FontWeight.w600),
                                                                      ),
                                                                      Icon(Icons
                                                                          .thumb_up_outlined),
                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: <
                                                                        Widget>[
                                                                      Row(
                                                                        children: <
                                                                            Widget>[
                                                                          Icon(
                                                                            Icons.star,
                                                                            color:
                                                                                Color(0xFFFFF176),
                                                                          ),
                                                                          Icon(
                                                                            Icons.star_border,
                                                                            color:
                                                                                Color(0xFFFFF176),
                                                                          ),
                                                                          Icon(
                                                                            Icons.star_border,
                                                                            color:
                                                                                Color(0xFFFFF176),
                                                                          ),
                                                                          Icon(
                                                                            Icons.star_border,
                                                                            color:
                                                                                Color(0xFFFFF176),
                                                                          ),
                                                                          Icon(
                                                                            Icons.star_border,
                                                                            color:
                                                                                Color(0xFFFFF176),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Text(CommentDate[
                                                                          index]),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ))
                                                            ],
                                                          ),
                                                          Container(
                                                            width:
                                                                double.infinity,
                                                            child: Text(
                                                              CommentText[
                                                                  index],
                                                              maxLines: 2,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          //全屏显示
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          context: context);
                    },
                  ),
                  Icon(Icons.code),
                  Icon(Icons.shopping_cart_outlined),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        height: 120,
                        width: 150,
                        color: Colors.yellowAccent,
                        child: Text('加入购物车'),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
