import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yoga/view/root_pages/Me.dart';
import 'package:yoga/view/root_pages/ShoppingCart.dart';
import 'package:yoga/view/root_pages/home.dart';
import 'package:yoga/view/root_pages/Tweet.dart';

class RootPage extends StatefulWidget {
  RootPageState createState() => RootPageState();
}

class RootPageState extends State<RootPage> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    HomePage(),
    TweetPage(),
    ShoppingCartPage(),
    MePage(),
  ];

  void onTabClick(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "首页"),
          BottomNavigationBarItem(icon: Icon(Icons.camera), label: "动态"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: "购物车"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "我的"),
        ],
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.lightBlueAccent,
        unselectedItemColor: Colors.black26,
        currentIndex: _currentIndex,
        onTap: onTabClick,
      ),
    );
  }
}
