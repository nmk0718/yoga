import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yoga/config/app_colors.dart';

class TextIcons extends StatelessWidget {
  String svgurl;
  String clickcount;
  Color color;
  Function ontap;
  double size;
  TextIcons({this.clickcount,this.svgurl,this.color,this.ontap,this.size});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Row(
        children: [
          SizedBox(
            width: size,
            height: size,
            child: SvgPicture.asset(svgurl,color:color, ),
          ),
          SizedBox(width: 10,),
          Container(
            child: Text(clickcount,style: TextStyle(color: color),),
          ),
        ],
      ),
      onTap: ontap,
    );
  }
}
