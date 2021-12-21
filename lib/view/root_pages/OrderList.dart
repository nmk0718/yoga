import 'package:flutter/material.dart';
import 'package:yoga/view/root_pages/AllOrder.dart';

class OrderList extends StatefulWidget {
  OrderListState createState() => OrderListState();
}

class OrderListState extends State<OrderList> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 5,
        child: SafeArea(
          child: Scaffold(
            body: Column(
              children: <Widget>[
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
                    '    订单列表',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                  ),
                ),
                Material(
                  color: Colors.white,
                  child: TabBar(
                      unselectedLabelColor: Colors.black38,
                      indicatorColor: Colors.black,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorWeight: 1.0,
                      tabs: <Widget>[
                        Tab(
                          text: '全部',
                        ),
                        Tab(
                          text: '待付款',
                        ),
                        Tab(
                          text: '待发货',
                        ),
                        Tab(
                          text: '待收货',
                        ),
                        Tab(
                          text: '待评价',
                        ),
                      ]),
                ),
                Expanded(
                  child: TabBarView(children: <Widget>[
                    AllOrder(),
                    Text('b'),
                    Text('c'),
                    Text('d'),
                    Text('e'),
                  ]),
                ),
              ],
            ),
          ),
        ));
  }
}
