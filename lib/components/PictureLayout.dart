import 'package:flutter/material.dart';
import 'package:yoga/components/ImageView.dart';
import 'FadeRoute.dart';
import 'ImageViewGallery.dart';


class PictureLayout extends StatelessWidget {
  int index;
  List datas;
  dynamic context;
  PictureLayout({this.datas,this.index,this.context});

  yuanjiao(int imageslength, int imageindex) {
    if (imageslength == 2) {
      if (imageindex == 0) {
        return BorderRadius.only(
            topLeft: Radius.circular(8), bottomLeft: Radius.circular(8));
      } else {
        return BorderRadius.only(
            topRight: Radius.circular(8), bottomRight: Radius.circular(8));
      }
    } else if (imageslength == 4) {
      if (imageindex == 0) {
        return BorderRadius.only(topLeft: Radius.circular(8));
      } else if (imageindex == 1) {
        return BorderRadius.only(topRight: Radius.circular(8));
      } else if (imageindex == 2) {
        return BorderRadius.only(bottomLeft: Radius.circular(8));
      } else if (imageindex == 3) {
        return BorderRadius.only(bottomRight: Radius.circular(8));
      }
    }
  }

  Picturelayout(int index) {
    int imageslength =
    datas[index].imagelist == null ? 0 : datas[index].imagelist.length;

    if (imageslength == 1) {
      return GestureDetector(
        onTap: () {
          Navigator.of(context).push(new FadeRoute(
              builder: (context) => imageview(datas[index].imagelist[0])));
        },
        child: Container(
          width: 412,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              datas[index].imagelist[0],
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    } else if (imageslength == 2) {
      List<Widget> imagea = [];
      Widget content;
      for (int i = 0; i < imageslength; i++) {
        imagea.add(
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(new FadeRoute(
                  builder: (context) => ImageViewGallery(
                    images: datas[index].imagelist,
                    index: i,
                  )));
            },
            child: Container(
              width: (MediaQuery.of(context).size.width - 164) / 1.5,
              height: (MediaQuery.of(context).size.width - 164) / 1.3,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(datas[index].imagelist[i]),
                  fit: BoxFit.cover,
                ),
                borderRadius: yuanjiao(imageslength, i),
              ),
            ),
          ),
        );
      }
      content = Wrap(
        spacing: 5,
        runSpacing: 5,
        alignment: WrapAlignment.start,
        children: imagea,
      );
      return content;
    } else if (imageslength == 4) {
      List<Widget> imagea = [];
      Widget content;
      for (int i = 0; i < imageslength; i++) {
        imagea.add(
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(new FadeRoute(
                  builder: (context) => ImageViewGallery(
                    images: datas[index].imagelist,
                    index: i,
                  )));
            },
            child: Container(
              width: (MediaQuery.of(context).size.width - 164) / 1.5,
              height: (MediaQuery.of(context).size.width - 164) / 2.3,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(datas[index].imagelist[i]),
                  fit: BoxFit.cover,
                ),
                borderRadius: yuanjiao(imageslength, i),
              ),
            ),
          ),
        );
      }
      content = Wrap(
        spacing: 5,
        runSpacing: 5,
        alignment: WrapAlignment.start,
        children: imagea,
      );
      return content;
    } else if (imageslength == 3 || imageslength > 4) {
      List<Widget> imagea = [];
      Widget content;
      for (int i = 0; i < imageslength; i++) {
        imagea.add(
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(new FadeRoute(
                  builder: (context) => ImageViewGallery(
                    images: datas[index].imagelist,
                    index: i,
                  )));
            },
            child: Container(
              width: (MediaQuery.of(context).size.width - 164) / 2.3,
              height: (MediaQuery.of(context).size.width - 164) / 2.3,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(datas[index].imagelist[i]),
                  fit: BoxFit.cover,
                ),
                borderRadius: yuanjiao(imageslength, i),
              ),
            ),
          ),
        );
      }
      content = Wrap(
        spacing: 5,
        runSpacing: 5,
        alignment: WrapAlignment.start,
        children: imagea,
      );
      return content;
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Picturelayout(index);
  }
}

