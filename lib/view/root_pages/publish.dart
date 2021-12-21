import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yoga/api/api.dart';
import 'package:yoga/api/request.dart';
import 'package:yoga/components/ImageViewLocal.dart';
import 'package:yoga/config/app_colors.dart';
import 'package:yoga/oss/OssUtil.dart';

import '../../components/FadeRoute.dart';

class PublishPage extends StatefulWidget {
  PublishPageState createState() => PublishPageState();
}

class PublishPageState extends State<PublishPage> {
  final ImagePicker picker = new ImagePicker();

  List LocalImagefiles = [];

  DateTime _time = new DateTime.now();

  String _fillText;

  String uploadimageurl;

  List UploadImageUrls = [];

  bool needdelete = false;

  String _movingValue; // 记录正在移动的数据

  String deleteText = '拖动到此处删除';
  Widget deleteIcon = Icon(
    Icons.delete,
    color: Colors.white,
    size: 20,
  );

  //打开相机拍照
  // Future _getCameraImage() async {
  //   var cameraImages = await picker.getImage(source: ImageSource.camera);
  //   File file = File(cameraImages.path);
  //   if (mounted) {
  //     if (cameraImages != null) {
  //       var uploadname =
  //           OssUtil.instance.getImageUploadName('test', cameraImages.path);
  //       var result = await OssUtil.instance.uploadImgFunc(file, uploadname);
  //       if (result.statusCode == 200) {
  //         setState(() {
  //           uploadimagename = uploadname;
  //           imagefiles.add(uploadimagename);
  //           print('上传成功' +
  //               '地址为:https://hyy2018.oss-cn-beijing.aliyuncs.com/${uploadimagename}');
  //         });
  //       } else {
  //         print('后端请求出错');
  //       }
  //     } else {
  //       print('没有照片可以选择');
  //     }
  //   }
  // }

  //打开相册选择1张照片
  // Future openGallery() async {
  //   var image = await picker.pickImage(source: ImageSource.gallery);
  //   File file = File(image.path);
  //   if (mounted) {
  //     if (image != null) {
  //       var uploadname =
  //           OssUtil.instance.getImageUploadName('test', image.path);
  //       var result = await OssUtil.instance.uploadImgFunc(file, uploadname);
  //       if (result.statusCode == 200) {
  //         setState(() {
  //           uploadimagename = uploadname;
  //           imagefiles.add(uploadimagename);
  //           print('上传成功' +
  //               '地址为:https://hyy2018.oss-cn-beijing.aliyuncs.com/${uploadimagename}');
  //         });
  //       } else {
  //         print('后端请求出错');
  //       }
  //     } else {
  //       print('没有照片可以选择');
  //     }
  //   }
  // }
  //直接上传OSS
  // Future<void> pickMultiImageOSS() async {
  //   var imagepath;
  //   final pickedFileList = await picker.pickMultiImage();
  //   for (int i = 0; i < pickedFileList.length; i++) {
  //     imagepath = pickedFileList[i].path;
  //     File file = File(imagepath);
  //     if (mounted) {
  //       if (pickedFileList != null) {
  //         var uploadname =
  //         OssUtil.instance.getImageUploadName('test', imagepath);
  //         var result = await OssUtil.instance.uploadImgFunc(file, uploadname);
  //         if (result.statusCode == 200) {
  //           setState(() {
  //             uploadimagename = Api.OSS_URL + uploadname;
  //             imagefiles.add(uploadimagename);
  //             print('上传成功' + '地址为:${uploadimagename}');
  //           });
  //         } else {
  //           print('后端请求出错');
  //         }
  //       } else {
  //         print('没有照片可以选择');
  //       }
  //     }
  //   }
  // }
  //发送推文
  // Future<void> PublishTweet() async {
  //   if (_fillText != null) {
  //     String time = _time.toString().substring(0, 19);
  //     final SearchTweet = await RequestService.AddTweet(
  //         Memo: _fillText, Image_url: uploadimagename, Time: time);
  //     Navigator.pop(context, _fillText);
  //   } else {
  //     print("输入为空");
  //   }
  // }
  //循环渲染选择的图片
  // Widget buildGrid() {
  //   List<Widget> images = []; //先建一个数组用于存放循环生成的widget
  //   Widget content; //单独一个widget组件，用于返回需要生成的内容widget
  //   for (var item in imagefiles) {
  //     images.add(
  //       Image.network(
  //         item,
  //         width: (MediaQuery.of(context).size.width - 50) / 3,
  //         height: (MediaQuery.of(context).size.width - 50) / 3,
  //         fit: BoxFit.cover,
  //       ),
  //     );
  //   }
  //   imagefiles.length != 9 ?images.add(
  //     AddImageIcon(),
  //   ) : Container();
  //   content = imagefiles.length !=0 ?Wrap(
  //       spacing: 5,
  //       runSpacing: 5,
  //       alignment: WrapAlignment.start,
  //       children:images
  //   ):Row(
  //     children: [
  //       AddImageIcon()
  //     ],
  //   );
  //   return content;
  // }

  //上传图片按钮

  //选择本地图片显示的同时,异步上传到阿里云oss,
  Future<void> pickMultiImage() async {
    var imagepath;
    final pickedFileList = await picker.pickMultiImage();
    if (mounted) {
      if (pickedFileList != null) {
        for (int i = 0; i < pickedFileList.length; i++) {
          imagepath = pickedFileList[i].path;
          File file = File(imagepath);
          var uploadname =
              OssUtil.instance.getImageUploadName('test', imagepath);
          var result = await OssUtil.instance.uploadImgFunc(file, uploadname);
          if (result.statusCode == 200) {
            uploadimageurl = Api.OSS_URL + uploadname;
            UploadImageUrls.add(uploadimageurl);
          } else {
            print('上传阿里云oss失败');
          }
          setState(() {
            LocalImagefiles.add(file.path);
          });
        }
      } else {
        print('没有照片可以选择');
      }
    }
  }

  //发送推文
  Future<void> PublishTweet() async {
    if (_fillText != null || LocalImagefiles.length != 0) {
      String time = _time.toString().substring(0, 19);
      Response SearchTweet = await RequestService.AddTweet(
          Tweet: _fillText, Image_url: UploadImageUrls, Time: time);
      if (SearchTweet.statusCode == 200) {
        print('发送成功');
        Navigator.pop(context, _fillText);
      } else {
        print('发送失败');
      }
    } else {
      print("输入为空");
    }
  }

  Widget AddImageIcon() {
    return GestureDetector(
      //如果上传的图片为最大数(9)时 取消上传按钮
      child: Container(
          height: (MediaQuery.of(context).size.width - 50) / 3,
          width: (MediaQuery.of(context).size.width - 50) / 3,
          decoration: new BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
          child: Icon(
            Icons.add,
            size: 40,
            color: Colors.black26,
          )),
      onTap: () {
        pickMultiImage();
      },
    );
  }

  //循环渲染选择的图片
  List<Widget> buildGrid() {
    List<Widget> images = []; //先建一个数组用于存放循环生成的widget
    Widget content; //单独一个widget组件，用于返回需要生成的内容widget
    for (int i = 0; i < LocalImagefiles.length; i++) {
      var item = LocalImagefiles[i];
      images.add(
        LongPressDraggable(
          data: LocalImagefiles[i],
          child: DragTarget(
            builder: (context, candidateData, rejectedData) {
              return imageevent(item, i);
            },
            onWillAccept: (moveData) {
              var accept = moveData != null;
              if (accept) {
                exchangeItem(moveData, item, false);
              }
              return accept;
            },
            onAccept: (moveData) {
              exchangeItem(moveData, item, true);
            },
            onLeave: (moveData) {
              print('=== onLeave: $moveData ==> $item');
            },
          ),
          childWhenDragging: null,
          feedback: imageevent(item, i),
          onDragStarted: () {
            FocusScope.of(context).requestFocus(FocusNode());
            setState(() {
              needdelete = true;
              _movingValue = item;
            });
          },
          onDraggableCanceled: (Velocity velocity, Offset offset) {
            setState(() {
              _movingValue = null; //清空标记进行重绘
              needdelete = false;
            });
          },
          onDragCompleted: () {
            print('=== onDragCompleted');
            setState(() {
              needdelete = false;
            });
          },
        ),
      );
    }
    LocalImagefiles.length !=9 ? images.add(AddImageIcon()):Container();
    return images;
  }

  Widget imageevent(value, i) {
    if (value == _movingValue) {
      return Container();
    }
    return GestureDetector(
      child: Image.file(
          File(value),
          width: (MediaQuery.of(context).size.width - 50) / 3,
          height: (MediaQuery.of(context).size.width - 50) / 3,
          fit: BoxFit.cover,
        ),
      onTap: () {
        Navigator.of(context).push(new FadeRoute(
            builder: (context) => ImageViewLocal(
                  images: LocalImagefiles,
                  index: i,
                )));
      },
    );
  }

  // 重新排序
  void exchangeItem(moveData, toData, onAccept) {
    setState(() {
      var toIndex = LocalImagefiles.indexOf(toData);

      LocalImagefiles.remove(moveData);
      LocalImagefiles.insert(toIndex, moveData);

      if (onAccept) {
        _movingValue = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF5F5F5),
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 1,
            leading: IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Container(
                      height: 30,
                      width: 70,
                      child: FlatButton(
                          child: Text('发送'),
                          color: AppColors.info,
                          textColor: Colors.white,
                          onPressed: () {
                            PublishTweet();
                          }),
                    )),
              ],
            )),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 100,
                    child: TextField(
                        cursorWidth: 2.5,
                        style: TextStyle(fontSize: 18),
                        autofocus: true,
                        maxLines: 50,
                        decoration: null,
                        onChanged: (text){
                          _fillText = text;
                        }
                        ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GridView(
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 5.0,
                        crossAxisSpacing: 5.0,
                        childAspectRatio: 1),
                    children: buildGrid(),
                    physics: NeverScrollableScrollPhysics(), //禁止滚动
                  ),
                ],
              ),
            ),
            Expanded(child: Container()),
            DragTarget<String>(
              builder: (BuildContext context, List<String> candidateData,
                  List<dynamic> rejectedData) {
                print(
                    'candidateData:$candidateData,rejectedData:$rejectedData');
                return needdelete == false
                    ? Container(
                        height: 50,
                        width: double.infinity,
                      )
                    : Container(
                        height: 50,
                        width: double.infinity,
                        color: Colors.red,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            deleteIcon,
                            Text(
                              deleteText,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 13),
                            ),
                          ],
                        ));
              },
              onWillAccept: (String data) {
                print('onWillAccept:$data');
                setState(() {
                  deleteIcon = Icon(
                    Icons.delete_forever,
                    color: Colors.white,
                    size: 20,
                  );
                  deleteText = '松手即可删除';
                });
                return true;
              },
              onAccept: (String data) {
                print('拖拽后放下:$data');
                setState(() {
                  LocalImagefiles.remove(data);
                  needdelete = false;
                });
              },
              onLeave: (String data) {
                setState(() {
                  deleteText = '拖动到此处删除';
                  deleteIcon = Icon(
                    Icons.delete,
                    color: Colors.white,
                    size: 20,
                  );
                });
                print('拖拽后移开:$data');
              },
            ),
          ],
        ));
  }
}
