import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yoga/components/PictureLayout.dart';
import 'package:yoga/components/TextIcons.dart';
import 'package:yoga/components/handleData.dart';
import 'package:yoga/config/app_colors.dart';
import 'package:yoga/view/root_pages/TweetDetails.dart';
import 'package:yoga/view/root_pages/publish.dart';
import '../../model/TweetData.dart';
import '../../api/request.dart';

class TweetPage extends StatefulWidget {
  TweetPageState createState() => TweetPageState();
}

class TweetPageState extends State<TweetPage> with AutomaticKeepAliveClientMixin {
  int tweetlength = 0;
  int PageNo = 1;
  List datas = [];

  Future<void> SearchTweet(firstsearch) async {
    if (firstsearch == true) {
      PageNo = 1;
    } else if (firstsearch == false) {
      PageNo++;
    }
    Response SearchTweet = await RequestService.SearchTweet(PageNo);

    if (SearchTweet.data[0] != null || PageNo < 3) {
      TweetData Tweetdatas =
          TweetData.fromJson(json.decode(SearchTweet.toString()));
      if (firstsearch == true) {
        setState(() {
          datas.clear();
          datas.addAll(Tweetdatas.searchs);
          tweetlength = datas.length;
        });
      } else {
        setState(() {
          datas..addAll(Tweetdatas.searchs);
          tweetlength = datas.length;
        });
      }
    } else {
      print('没有新数据');
    }
  }

  quantity(int index) {
    int commentslength =
    datas[index].comments == null ? 0 : datas[index].comments.length;

    if (datas[index].comments == null) {
      return "";
    } else {
      return "${commentslength}";
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('推文页面');
    SearchTweet(true);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('推文'),
      ),
        floatingActionButton: FloatingActionButton(
          child: IconButton(
            color: AppColors.info,
              icon: Icon(Icons.add,color: Colors.white,),
              ),
            onPressed: () async {
              var tweetdatas = await Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PublishPage()));
              if (tweetdatas != null) {
                SearchTweet(true);
              } else {
                print(tweetdatas);
              }
            }
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: EasyRefresh(
      header: ClassicalHeader(
        infoText: '更新时间 %T',
        refreshedText: '刷新完成',
        refreshFailedText: '刷新失败',
        refreshText: '下拉刷新',
        refreshReadyText: '释放刷新',
        refreshingText: '刷新中',
        noMoreText: '没有更多',
        textColor: Colors.lightBlueAccent,
        bgColor: Colors.white,
      ),
      footer: ClassicalFooter(
        infoText: '更新时间 %T',
        loadedText: '刷新完成',
        loadFailedText: '刷新失败',
        loadText: '上拉刷新',
        loadReadyText: '释放刷新',
        loadingText: '加载中....',
        noMoreText: '没有更多',
        textColor: Colors.lightBlueAccent,
        bgColor: Colors.white,
      ),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: tweetlength,
        itemBuilder: _ListItemBuilder,
        cacheExtent: 10,
      ),
      onRefresh: () async {
        await new Future.delayed(const Duration(seconds: 1), () {
          setState(() {
            SearchTweet(true);
          });
        });
      },
      onLoad: () async {
        await new Future.delayed(const Duration(seconds: 1), () {
          setState(() {
            SearchTweet(false);
          });
        });
      },
    ));
  }

  Widget _ListItemBuilder(BuildContext context, int index) {
    return GestureDetector(
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
          child: Column(
            children: [
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                CircleAvatar(
                  //头像半径
                  radius: 25,
                  //头像图片
                  backgroundImage: NetworkImage(datas[index].headimage),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            datas[index].userName,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w400),
                          ),
                          Text(
                            ' @${datas[index].userCode}·'+handleDate(datas[index].time).toString(),
                            style: TextStyle(fontSize: 14, color: Colors.black45),
                          ),
                        ],
                      ),
                      Text(
                        datas[index].tweetinfo,
                        maxLines: 50,
                      ),
                      SizedBox(height: 5),
                      PictureLayout(datas:datas,index: index,context:context),
                      SizedBox(height: 10),
                      Container(
                        width: 260,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextIcons(
                                svgurl: "assets/images/reply.svg",
                                clickcount: quantity(index),
                                color: AppColors.defaulticoncolor,
                            size: 18.0,),
                            datas[index].retweetStatus == 0
                                ? TextIcons(
                              svgurl: "assets/images/retweet.svg",
                              clickcount: datas[index].retweets >0 ?"${datas[index].retweets}":" ",
                              color: AppColors.defaulticoncolor,
                              size: 18.0,
                              ontap: () async {
                                Response TweetStatus = await RequestService.UpdateTweetStatus(Memo_id:datas[index].iD,Clicktype:0,Click:1);
                                if(TweetStatus.statusCode ==200){
                                  setState(() {
                                    datas[index].retweets++;
                                    datas[index].retweetStatus =1;
                                  });
                                }
                              },
                            )
                                : TextIcons(
                              svgurl: "assets/images/retweetd.svg",
                              clickcount: "${datas[index].retweets}",
                              color: AppColors.retweetcolor,
                              size: 18.0,
                              ontap: () async {
                                Response TweetStatus = await RequestService.UpdateTweetStatus(Memo_id:datas[index].iD,Clicktype:0,Click:0);
                                if(TweetStatus.statusCode ==200){
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
                              clickcount: datas[index].likes >0 ?"${datas[index].likes}":" ",
                              color: AppColors.defaulticoncolor,
                              size: 18.0,
                              ontap: () async {
                                Response TweetStatus = await RequestService.UpdateTweetStatus(Memo_id:datas[index].iD,Clicktype:1,Click:1);
                                if(TweetStatus.statusCode==200){
                                  setState(() {
                                    datas[index].likes++;
                                    datas[index].likeStatus =1;
                                  });
                                }
                              },
                            )
                                : TextIcons(
                              svgurl: "assets/images/liked.svg",
                              clickcount: "${datas[index].likes}",
                              color: AppColors.likedcolor,
                              size: 18.0,
                              ontap: () async {
                                Response TweetStatus = await RequestService.UpdateTweetStatus(Memo_id:datas[index].iD,Clicktype:1,Click:0);
                                if(TweetStatus.statusCode==200){
                                  setState(() {
                                    datas[index].likes--;
                                    datas[index].likeStatus =0;
                                  });
                                }
                              },
                            ),
                            SizedBox(
                              width: 18.0,
                              height: 18.0,
                              child: SvgPicture.asset(
                                "assets/images/share.svg",
                                color: AppColors.defaulticoncolor,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ]),
              SizedBox(
                height: 10,
              ),
              Divider(
                height: 0,
                // Divider 组件高度
                thickness: 0.5,
                // 分割线线宽，分割线居于 Divider 中心
                indent: 0,
                // 分割线左侧间距
                endIndent: 0,
                // 分割线右侧间距
                color: Colors.black12, // 分割线颜色
              ),
            ],
          ),
        ),
      ),
      onTap: (){
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => TweetDetails(datas:datas,index: index,context:context)));
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
