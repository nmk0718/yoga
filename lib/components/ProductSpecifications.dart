import 'package:flutter/material.dart';

class ProductSpecifications extends StatelessWidget {

  String titletext;
  String text;
  Function onPress;
  ProductSpecifications({this.text,this.titletext,this.onPress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Text('$titletext',style: TextStyle(color: Colors.grey),),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  Text('$text'),
                  Icon(Icons.keyboard_arrow_right,color: Colors.grey,),
                ],
              ),),
          ],
        ),
      ),
    );
  }
}
