class IconsDatas {
  List<Jingang> jingang;

  IconsDatas({this.jingang});

  IconsDatas.fromJson(Map<String, dynamic> json) {
    if (json['Jingang'] != null) {
      jingang = new List<Jingang>();
      json['Jingang'].forEach((v) {
        jingang.add(new Jingang.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.jingang != null) {
      data['Jingang'] = this.jingang.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Jingang {
  int iD;
  String iconText;
  String iconUrl;

  Jingang({this.iD, this.iconText, this.iconUrl});

  Jingang.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    iconText = json['Icon_Text'];
    iconUrl = json['Icon_Url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['Icon_Text'] = this.iconText;
    data['Icon_Url'] = this.iconUrl;
    return data;
  }
}