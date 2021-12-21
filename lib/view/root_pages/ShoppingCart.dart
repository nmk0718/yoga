import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:yoga/api/request.dart';
import 'package:yoga/model/ReturnCode.dart';
import 'package:yoga/model/ShoppingData.dart';

class ShoppingCartPage extends StatefulWidget {
  ShoppingCartPageState createState() => ShoppingCartPageState();
}

class ShoppingCartPageState extends State<ShoppingCartPage> {
  bool _value = false;
  ShoppingData data;
  int storelength = 0;
  int totalmoney = 0;
  String input_text;
  int totalnumber = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('进入购物车页面');
    reload_shopping();
  }

  void reload_shopping() async {

    Response response =
        await RequestService.SearchShoppingCart();

    if (response.statusCode == 200) {
      ShoppingData shoppingdata =
          ShoppingData.fromJson(json.decode(response.toString()));

      setState(() {
        data = shoppingdata;
        storelength = shoppingdata.searchShoppings.length;
      });
    }
  }

  void delete_shoppingorder(storeindex,productindex) async {
    var productid = data.searchShoppings[storeindex].productList[productindex].iD;
    var productinfo = data.searchShoppings[storeindex].productList[productindex];

    Response response = await RequestService.DeleteShoppingCartOrder(productid);
    if (response.statusCode == 200) {
      ReturnCode returnCode =
      ReturnCode.fromJson(json.decode(response.toString()));
      setState(() {
        data.searchShoppings[storeindex].productList.removeAt(productindex);
        // reload_shopping();
        if(productinfo.selected == 'true') {
          totalmoney -= productinfo.price * productinfo.number;
          totalnumber --;
        }
      });
      Navigator.of(context).pop();
    }
  }

  void update_shoppingnumber(
      productid, productnumber, storeindex, int productindex, status) async {

    var datas = data.searchShoppings[storeindex].productList[productindex];

    if (status == 'add') {
      productnumber ++;
    } else if (status == 'del') {
      productnumber--;
    } else {
      productnumber;
    }
    Response response = await RequestService.UpdateShoppingCartNumber(productnumber,productid);
    ReturnCode returnCode =
        ReturnCode.fromJson(json.decode(response.toString()));
    if (returnCode.code == 1) {
      setState(() {
        if (status == 'add') {
          datas.number++;
          if (datas.selected == 'true') {
            totalmoney += datas.price;
          }
        } else if (status == 'del') {
          datas.number--;
          if (datas.selected == 'true') {
            totalmoney -= datas.price;
          }
        } else {
          if (datas.selected == 'true') {
            if (productnumber > datas.number) {
              totalmoney += datas.price * (productnumber - datas.number);
            } else if (productnumber < datas.number) {
              totalmoney -= datas.price * (datas.number - productnumber);
            } else {
              print(productnumber);
            }
          }
          datas.number = productnumber;
        }
      });
    } else {
      print(returnCode.code);
    }
  }

  void _getInputText(text) {
    input_text = text;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text('购物车'),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
                child: ListView.builder(
                    itemCount: storelength,
                    itemBuilder: (context, storeindex) {
                      return Column(
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          //店铺名称
                          Container(
                              color: Colors.white,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: 20, right: 20, top: 10, bottom: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.home_filled,
                                          color: Color(0xFFBDBDBD),
                                          size: 17,
                                        ),
                                        Text(
                                          data.searchShoppings[storeindex].storeName,
                                          style: TextStyle(
                                            color: Colors.black38,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      data.searchShoppings[storeindex].baoYou,
                                      style: TextStyle(
                                        color: Colors.black38,
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                          Container(
                            color: Colors.white,
                            height: 10,
                          ),
                          Container(
                            height: 130 *
                                (data.searchShoppings[storeindex].productList.length
                                    .toDouble()),
                            color: Colors.white,
                            child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemCount:
                                  data.searchShoppings[storeindex].productList.length,
                              itemExtent: 130,
                              itemBuilder: (context, productindex) {
                                var productinfo = data.searchShoppings[storeindex]
                                    .productList[productindex];
                                return Slidable(
                                  child: Column(children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.only(
                                        left: 20,
                                        right: 20,
                                      ), //设置item的边距
                                      child: Row(
                                        children: <Widget>[
                                          //复选框
                                          GestureDetector(
                                            child: Container(
                                              width: 20,
                                              height: 20,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: productinfo.selected ==
                                                          'true'
                                                      ? Colors.yellow
                                                      : Colors.white,
                                                  border: Border.all(
                                                      color: productinfo
                                                                  .selected ==
                                                              'true'
                                                          ? Colors.yellow
                                                          : Colors.black12,
                                                      width: 1)),
                                              child: Center(
                                                child: Icon(
                                                  Icons.check,
                                                  size: 20,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            onTap: () {
                                              if (productinfo.selected ==
                                                  'false') {
                                                setState(() {
                                                  productinfo.selected = 'true';
                                                  totalmoney +=
                                                      productinfo.price *
                                                          productinfo.number;
                                                  totalnumber++;
                                                });
                                              } else {
                                                setState(() {
                                                  productinfo.selected =
                                                      'false';
                                                  totalmoney -=
                                                      productinfo.price *
                                                          productinfo.number;
                                                  totalnumber--;
                                                });
                                              }
                                              var num = 0;
                                              var Listlength;
                                              for (var i = 0;
                                                  i < data.searchShoppings.length;
                                                  i++) {
                                                Listlength =
                                                    data.searchShoppings.length *
                                                        data.searchShoppings[i]
                                                            .productList.length;
                                                for (var j = 0;
                                                    j <
                                                        data.searchShoppings[i]
                                                            .productList.length;
                                                    j++) {
                                                  if (data
                                                          .searchShoppings[i]
                                                          .productList[j]
                                                          .selected ==
                                                      'true') {
                                                    num++;
                                                  } else {
                                                    num--;
                                                  }
                                                }
                                              }
                                              if (num < Listlength) {
                                                setState(() {
                                                  _value = false;
                                                });
                                              } else {
                                                setState(() {
                                                  _value = true;
                                                });
                                              }
                                            },
                                          ),
                                          //商品图片
                                          Container(
                                            height: 80,
                                            width: 80,
                                            margin: EdgeInsets.only(
                                                left: 20, right: 20), //设置图片的边距
                                            child: Container(
                                              color: Color(0xFFF48FB1),
                                            )
                                          ), //涉及到widget的大小或者边框的时候，使用container包裹
                                          //商品名称 商品金额 商品口味
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Expanded(
                                                      child: Text(
                                                        productinfo.productName,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    Chip(
                                                      label: Text(
                                                        productinfo.color,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black45),
                                                      ),
                                                      backgroundColor:
                                                          Color(0xFFFAFAFA),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    //价钱
                                                    Expanded(
                                                      child: Text(
                                                        '￥' +
                                                            productinfo.price
                                                                .toString(),
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 15),
                                                      ),
                                                    ),
                                                    //加减按钮
                                                    Expanded(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: <Widget>[
                                                          GestureDetector(
                                                            child: Container(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child:
                                                                  CircleAvatar(
                                                                radius: 15.0,
                                                                backgroundColor:
                                                                    Color(
                                                                        0xFFF5F5F5),
                                                                child: Text(
                                                                  '—',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          20),
                                                                ),
                                                              ),
                                                            ),
                                                            onTap: () {
                                                              if (productinfo
                                                                      .number ==
                                                                  1) {
                                                                print(productinfo
                                                                    .number);
                                                              } else {
                                                                var status =
                                                                    'del';
                                                                update_shoppingnumber(
                                                                    productinfo
                                                                        .iD,
                                                                    productinfo
                                                                        .number,
                                                                    storeindex,
                                                                    productindex,
                                                                    status);
                                                              }
                                                            },
                                                          ),
                                                          // SizedBox(
                                                          //   width: 15,
                                                          // ),
                                                          GestureDetector(
                                                            child: Text(
                                                                productinfo
                                                                    .number
                                                                    .toString()),
                                                            onTap: () {
                                                              showDialog(
                                                                context:
                                                                    context,
                                                                barrierDismissible:
                                                                    false,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  return new AlertDialog(
                                                                    title: new Text(
                                                                        '请输入商品数量'),
                                                                    content:
                                                                        new SingleChildScrollView(
                                                                      child:
                                                                          new ListBody(
                                                                        children: <
                                                                            Widget>[
                                                                          new TextField(
                                                                            keyboardType:
                                                                                TextInputType.number,
                                                                            onChanged:
                                                                                _getInputText,
                                                                            controller:
                                                                                TextEditingController(text: productinfo.number.toString()),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    actions: <
                                                                        Widget>[
                                                                      FlatButton(
                                                                        child: new Text(
                                                                            '取消'),
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                        },
                                                                      ),
                                                                      FlatButton(
                                                                        child: new Text(
                                                                            '确定'),
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                          setState(
                                                                              () {
                                                                            var status =
                                                                                'update';
                                                                            update_shoppingnumber(
                                                                                productinfo.iD,
                                                                                int.parse(input_text),
                                                                                storeindex,
                                                                                productindex,
                                                                                status);
                                                                          });
                                                                        },
                                                                      ),
                                                                    ],
                                                                  );
                                                                },
                                                              ).then((val) {
                                                                // print(val);
                                                              });
                                                            },
                                                          ),
                                                          // SizedBox(
                                                          //   width: 15,
                                                          // ),
                                                          GestureDetector(
                                                            child: Container(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child:
                                                                  CircleAvatar(
                                                                radius: 15.0,
                                                                backgroundColor:
                                                                    Colors
                                                                        .yellow,
                                                                child: Text(
                                                                  '+',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          20),
                                                                ),
                                                              ),
                                                            ),
                                                            onTap: () {
                                                              var status =
                                                                  'add';
                                                              update_shoppingnumber(
                                                                  productinfo
                                                                      .iD,
                                                                  productinfo
                                                                      .number,
                                                                  storeindex,
                                                                  productindex,
                                                                  status);
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]),
                                  key: ValueKey("$storeindex"),
                                  direction: Axis.horizontal,
                                  actions: [],
                                  secondaryActions: secondaryActionsArray(storeindex,productindex),
                                  actionPane: SlidableDrawerActionPane(),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    })),
            Container(
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 20,
                  ),
                  //复选框
                  GestureDetector(
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _value ? Colors.yellow : Colors.white,
                          border: Border.all(
                              color: _value ? Colors.yellow : Colors.black12,
                              width: 1)),
                      child: Center(
                        child: Icon(
                          Icons.check,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    onTap: () {
                      _value = !_value;
                      setState(() {
                        totalmoney = 0;
                      });
                      for (var i = 0; i < data.searchShoppings.length; i++) {
                        for (var j = 0;
                            j < data.searchShoppings[i].productList.length;
                            j++) {
                          setState(() {
                            data.searchShoppings[i].productList[j].selected =
                                _value.toString();
                            if (_value) {
                              totalnumber = data.searchShoppings.length *
                                  data.searchShoppings[i].productList.length;
                              totalmoney +=
                                  data.searchShoppings[i].productList[j].price;
                            } else {
                              totalnumber = 0;
                              totalmoney = 0;
                            }
                          });
                        }
                      }
                    },
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text("全选"),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          "￥$totalmoney",
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: new Text(
                            "去结算($totalnumber)",
                            style: TextStyle(color: Colors.black),
                          ),
                          width: 130,
                          height: 50,
                          color: Color(0xFFFFE57F),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> secondaryActionsArray(storeindex,productindex) {
    return [
      IconSlideAction(
        icon: Icons.delete,
        color: Colors.red,
        onTap: () {
          //主动关闭
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(
                  '请确定是否删除?',
                  textAlign: TextAlign.center,
                ),
                actions: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      FlatButton(
                        child: Text(
                          '取消',
                          style: TextStyle(color: Colors.grey),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      FlatButton(
                        child: Text(
                          '删除',
                          style: TextStyle(color: Colors.red),
                        ),
                        onPressed: () {
                          delete_shoppingorder(
                            storeindex,productindex
                          );
                        },
                      ),
                    ],
                  )
                ],
                // buttonPadding:EdgeInsets.only(right: 50),
                backgroundColor: Colors.white,
                elevation: 10,
                // 设置成 圆角
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              );
            },
          ).then((val) {
            // print(val);
          });
        },
        closeOnTap: true,
      ),
    ];
  }
}
