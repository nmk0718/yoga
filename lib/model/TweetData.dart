class TweetData {
  List<Searchs> searchs;

  TweetData({this.searchs});

  TweetData.fromJson(Map<String, dynamic> json) {
    if (json['Searchs'] != null) {
      searchs = new List<Searchs>();
      json['Searchs'].forEach((v) {
        searchs.add(new Searchs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.searchs != null) {
      data['Searchs'] = this.searchs.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Searchs {
  int iD;
  String tweetinfo;
  String userName;
  String headimage;
  String userCode;
  int retweets;
  int likes;
  int retweetStatus;
  int likeStatus;
  List<String> comments;
  String time;
  List<String> imagelist;

  Searchs(
      {this.iD,
        this.tweetinfo,
        this.userName,
        this.headimage,
        this.userCode,
        this.retweets,
        this.likes,
        this.retweetStatus,
        this.likeStatus,
        this.comments,
        this.time,
        this.imagelist});

  Searchs.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    tweetinfo = json['Tweetinfo'];
    userName = json['User_name'];
    headimage = json['Headimage'];
    userCode = json['User_code'];
    retweets = json['Retweets'];
    likes = json['Likes'];
    retweetStatus = json['Retweet_status'];
    likeStatus = json['Like_status'];
    if(json['Comments'] != null){
      comments = json['Comments'].cast<String>();
    }
    time = json['Time'];
    if(json['Imagelist'] != null){
      imagelist = json['Imagelist'].cast<String>();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['Tweetinfo'] = this.tweetinfo;
    data['User_name'] = this.userName;
    data['Headimage'] = this.headimage;
    data['User_code'] = this.userCode;
    data['Retweets'] = this.retweets;
    data['Likes'] = this.likes;
    data['Retweet_status'] = this.retweetStatus;
    data['Like_status'] = this.likeStatus;
    data['Comments'] = this.comments;
    data['Time'] = this.time;
    data['Imagelist'] = this.imagelist;
    return data;
  }
}