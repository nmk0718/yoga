import 'dart:async';
import 'package:flutter/material.dart';
import 'package:yoga/root_page.dart';

class TransitPage extends StatefulWidget {
  TransitPageState createState() => TransitPageState();
}

class TransitPageState extends State<TransitPage> {
  Timer _timer;
  int _currentTime = 3;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      setState(() {
        _currentTime--;
      });
      if (_currentTime <= 0) {
        jumpRootPage();
      }
    });
  }

  void jumpRootPage() {
    _timer.cancel();
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return RootPage();
    }), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/page.jpg',
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          Positioned(
              top: MediaQuery.of(context).padding.top + 10,
              right: 10,
              child: InkWell(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Container(
                    width: 50,
                    height: 40,
                    color: Colors.black.withOpacity(0.3),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '跳过',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                        Text(
                          '${_currentTime}s',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
                onTap: () {
                  jumpRootPage();
                },
              )),
        ],
      ),
    );
  }
}
