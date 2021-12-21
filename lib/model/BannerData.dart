class BannerData {
  List<Banners> banners;

  BannerData({this.banners});

  BannerData.fromJson(Map<String, dynamic> json) {
    if (json['Banners'] != null) {
      banners = new List<Banners>();
      json['Banners'].forEach((v) {
        banners.add(new Banners.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.banners != null) {
      data['Banners'] = this.banners.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Banners {
  int iD;
  String bannerUrl;

  Banners({this.iD, this.bannerUrl});

  Banners.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    bannerUrl = json['Banner_Url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['Banner_Url'] = this.bannerUrl;
    return data;
  }
}