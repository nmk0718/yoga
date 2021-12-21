import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ImageViewGallery extends StatefulWidget {
  List images=[];
  int index=0;
  PageController controller;

  ImageViewGallery({Key key,@required this.images,this.index,this.controller}) : super(key: key){
    controller=PageController(initialPage: index);
  }

  @override
  _ImageViewGalleryState createState() => _ImageViewGalleryState();
}

class _ImageViewGalleryState extends State<ImageViewGallery> {
  int currentIndex=0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentIndex=widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            bottom: 0,
            right: 0,
            child: Container(
                child: PhotoViewGallery.builder(
                  scrollPhysics: const BouncingScrollPhysics(),
                  builder: (BuildContext context, int index) {
                    return PhotoViewGalleryPageOptions(
                      //网络图片预览
                      imageProvider: NetworkImage(widget.images[index]),
                    );
                  },
                  itemCount: widget.images.length,
                  pageController: widget.controller,
                  enableRotation: true,
                  onPageChanged: (index){
                    setState(() {
                      currentIndex=index;
                    });
                  },
                )
            ),
          ),
          Positioned(//图片index显示
            top: MediaQuery.of(context).padding.top+15,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Text("${currentIndex+1}/${widget.images.length}",style: TextStyle(color: Colors.white,fontSize: 16)),
            ),
          ),
          Positioned(//右上角关闭按钮
            right: 10,
            top: MediaQuery.of(context).padding.top,
            child: IconButton(
              icon: Icon(Icons.close,size: 30,color: Colors.white,),
              onPressed: (){
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}
