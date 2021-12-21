class ShoppingInfo {
  List<Shoppinginfos> shoppinginfos;

  ShoppingInfo({this.shoppinginfos});

  ShoppingInfo.fromJson(Map<String, dynamic> json) {
    if (json['Shoppinginfos'] != null) {
      shoppinginfos = new List<Shoppinginfos>();
      json['Shoppinginfos'].forEach((v) {
        shoppinginfos.add(new Shoppinginfos.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.shoppinginfos != null) {
      data['Shoppinginfos'] =
          this.shoppinginfos.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Shoppinginfos {
  int totalPageNum;
  List<ProductinfoList> productinfoList;

  Shoppinginfos({this.totalPageNum, this.productinfoList});

  Shoppinginfos.fromJson(Map<String, dynamic> json) {
    totalPageNum = json['TotalPageNum'];
    if (json['ProductinfoList'] != null) {
      productinfoList = new List<ProductinfoList>();
      json['ProductinfoList'].forEach((v) {
        productinfoList.add(new ProductinfoList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['TotalPageNum'] = this.totalPageNum;
    if (this.productinfoList != null) {
      data['ProductinfoList'] =
          this.productinfoList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductinfoList {
  int iD;
  String storeName;
  String storeIcon;
  String productName;
  String imageUrl;
  String color;
  int price;
  int salesVolume;

  ProductinfoList(
      {this.iD,
        this.storeName,
        this.storeIcon,
        this.productName,
        this.imageUrl,
        this.color,
        this.price,
        this.salesVolume});

  ProductinfoList.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    storeName = json['Store_Name'];
    storeIcon = json['Store_Icon'];
    productName = json['Product_Name'];
    imageUrl = json['ImageUrl'];
    color = json['Color'];
    price = json['Price'];
    salesVolume = json['Sales_Volume'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['Store_Name'] = this.storeName;
    data['Store_Icon'] = this.storeIcon;
    data['Product_Name'] = this.productName;
    data['ImageUrl'] = this.imageUrl;
    data['Color'] = this.color;
    data['Price'] = this.price;
    data['Sales_Volume'] = this.salesVolume;
    return data;
  }
}