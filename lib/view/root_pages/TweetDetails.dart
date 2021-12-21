import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yoga/api/request.dart';
import 'package:yoga/components/PictureLayout.dart';
import 'package:yoga/components/TextIcons.dart';
import 'package:yoga/components/handleData.dart';
import 'package:yoga/config/app_colors.dart';
import '../../components/Comments.dart';

class TweetDetails extends StatefulWidget {
  int index;
  List datas;
  dynamic context;

  TweetDetails({this.datas, this.index, this.context});

  TweetDetailsState createState() => TweetDetailsState(
      datas: this.datas, index: this.index, context: this.context);
}

class TweetDetailsState extends State<TweetDetails> {
  int index;
  List datas;
  var context;

  TweetDetailsState({this.datas, this.index, this.context});

  quantity() {
    int commentslength =
        datas[index].comments == null ? 0 : datas[index].comments.length;

    if (datas[index].comments == null) {
      return "";
    } else {
      return "${commentslength}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 1,
        title: Text('推文'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
                child: Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 10,bottom: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        //头像半径
                        radius: 25,
                        //头像图片
                        backgroundImage: NetworkImage(datas[index].headimage),
                      ),
                      SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            datas[index].userName,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                          Text(
                            '@${datas[index].userCode}',
                            style:
                                TextStyle(fontSize: 14, color: Colors.black45),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    datas[index].tweetinfo,
                    maxLines: 50,
                    style: TextStyle(fontSize: 19),
                  ),
                  SizedBox(height: 10),
                  PictureLayout(datas: datas, index: index, context: context),
                  SizedBox(height: 10),
                  Text(
                    datas[index].time.toString(),
                    style: TextStyle(fontSize: 14, color: Colors.black45),
                  ),
                  SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextIcons(
                        svgurl: "assets/images/reply.svg",
                        clickcount: quantity(),
                        color: AppColors.defaulticoncolor,
                        size: 20.0,
                        ontap: () {},
                      ),
                      datas[index].retweetStatus == 0
                          ? TextIcons(
                              svgurl: "assets/images/retweet.svg",
                              clickcount: datas[index].retweets > 0
                                  ? "${datas[index].retweets}"
                                  : " ",
                              color: AppColors.defaulticoncolor,
                              size: 20.0,
                              ontap: () async {
                                Response TweetStatus =
                                    await RequestService.UpdateTweetStatus(
                                        Memo_id: datas[index].iD,
                                        Clicktype: 0,
                                        Click: 1);
                                if (TweetStatus.statusCode == 200) {
                                  setState(() {
                                    datas[index].retweets++;
                                    datas[index].retweetStatus = 1;
                                  });
                                }
                              },
                            )
                          : TextIcons(
                              svgurl: "assets/images/retweetd.svg",
                              clickcount: "${datas[index].retweets}",
                              color: AppColors.retweetcolor,
                              size: 20.0,
                              ontap: () async {
                                Response TweetStatus =
                                    await RequestService.UpdateTweetStatus(
                                        Memo_id: datas[index].iD,
                                        Clicktype: 0,
                                        Click: 0);
                                if (TweetStatus.statusCode == 200) {
                                  setState(() {
                                    datas[index].retweets--;
                                    datas[index].retweetStatus = 0;
                                  });
                                }
                              },
                            ),
                      datas[index].likeStatus == 0
                          ? TextIcons(
                              svgurl: "assets/images/like.svg",
                              clickcount: datas[index].likes > 0
                                  ? "${datas[index].likes}"
                                  : " ",
                              color: AppColors.defaulticoncolor,
                              size: 20.0,
                              ontap: () async {
                                Response TweetStatus =
                                    await RequestService.UpdateTweetStatus(
                                        Memo_id: datas[index].iD,
                                        Clicktype: 1,
                                        Click: 1);
                                if (TweetStatus.statusCode == 200) {
                                  setState(() {
                                    datas[index].likes++;
                                    datas[index].likeStatus = 1;
                                  });
                                }
                              },
                            )
                          : TextIcons(
                              svgurl: "assets/images/liked.svg",
                              clickcount: "${datas[index].likes}",
                              color: AppColors.likedcolor,
                              size: 20.0,
                              ontap: () async {
                                Response TweetStatus =
                                    await RequestService.UpdateTweetStatus(
                                        Memo_id: datas[index].iD,
                                        Clicktype: 1,
                                        Click: 0);
                                if (TweetStatus.statusCode == 200) {
                                  setState(() {
                                    datas[index].likes--;
                                    datas[index].likeStatus = 0;
                                  });
                                }
                              },
                            ),
                      SizedBox(
                        width: 20.0,
                        height: 20.0,
                        child: SvgPicture.asset(
                          "assets/images/share.svg",
                          color: AppColors.defaulticoncolor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Divider(
                    height: 0,
                    // Divider 组件高度
                    thickness: 0.5,
                    // 分割线线宽，分割线居于 Divider 中心
                    indent: 0,
                    // 分割线左侧间距
                    endIndent: 0,
                    // 分割线右侧间距
                    color: Colors.black12,
                    // 分割线颜色
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(datas[index].headimage),
                    ),
                    title: Row(
                      children: [
                        Text(datas[index].userName),
                        Text(
                          ' @${datas[index].userCode} · ',
                          style: TextStyle(color: Colors.black45, fontSize: 13),
                        ),
                      ],
                    ),
                    subtitle: Text(datas[index].comments.toString(),
                        style: TextStyle(color: Colors.black)),
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(datas[index].headimage),
                    ),
                    title: Row(
                      children: [
                        Text(datas[index].userName),
                        Text(
                          ' @${datas[index].userCode} · ',
                          style: TextStyle(color: Colors.black45, fontSize: 13),
                        ),
                      ],
                    ),
                    subtitle: Text(datas[index].comments.toString(),
                        style: TextStyle(color: Colors.black)),
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(datas[index].headimage),
                    ),
                    title: Row(
                      children: [
                        Text(datas[index].userName),
                        Text(
                          ' @${datas[index].userCode} · ',
                          style: TextStyle(color: Colors.black45, fontSize: 13),
                        ),
                      ],
                    ),
                    subtitle: Text(datas[index].comments.toString(),
                        style: TextStyle(color: Colors.black)),
                  ),
                ],
              ),
            )),
          ),
          // ListView.builder(
          //   shrinkWrap: true,
          //   itemCount: 2,
          //   itemBuilder: _ListTileBuilder,
          // ),
          Comments(),
        ],
      ),
    );
  }

  Widget _ListTileBuilder(BuildContext context, int index) {
    return Column(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(datas[index].headimage),
        ),
      ],
    );
  }
}
