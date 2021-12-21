import 'package:flutter/material.dart';
import 'package:yoga/config/app_colors.dart';

class RootPageHead extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Image.network('https://jenkins.360ljk.com/static/7f8e2c3e/images/jenkins-header-logo-v2.svg',fit: BoxFit.cover,height: 40,width: 40,),
        Expanded(child: Container(
          height: 30,
          margin: EdgeInsets.symmetric(horizontal: 13),
          decoration: BoxDecoration(
            color: AppColors.active,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            children: [
              Padding(padding: EdgeInsets.only(left: 6,right: 2),child: Icon(Icons.search,size: 16,color: AppColors.un3active),),
              Text('搜索关键字',style: TextStyle(fontSize: 12,color: AppColors.un3active),),
            ],
          ),
        ),
        ),
        Icon(Icons.email),
      ],
    );
  }
}
