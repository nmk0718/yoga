class ShoppingData {
  List<SearchShoppings> searchShoppings;

  ShoppingData({this.searchShoppings});

  ShoppingData.fromJson(Map<String, dynamic> json) {
    if (json['SearchShoppings'] != null) {
      searchShoppings = new List<SearchShoppings>();
      json['SearchShoppings'].forEach((v) {
        searchShoppings.add(new SearchShoppings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.searchShoppings != null) {
      data['SearchShoppings'] =
          this.searchShoppings.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SearchShoppings {
  int storeID;
  String storeName;
  String baoYou;
  List<ProductList> productList;

  SearchShoppings(
      {this.storeID, this.storeName, this.baoYou, this.productList});

  SearchShoppings.fromJson(Map<String, dynamic> json) {
    storeID = json['Store_ID'];
    storeName = json['Store_Name'];
    baoYou = json['BaoYou'];
    if (json['ProductList'] != null) {
      productList = new List<ProductList>();
      json['ProductList'].forEach((v) {
        productList.add(new ProductList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Store_ID'] = this.storeID;
    data['Store_Name'] = this.storeName;
    data['BaoYou'] = this.baoYou;
    if (this.productList != null) {
      data['ProductList'] = this.productList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductList {
  int iD;
  String productName;
  String color;
  int number;
  int price;
  String selected;

  ProductList(
      {this.iD,
        this.productName,
        this.color,
        this.number,
        this.price,
        this.selected});

  ProductList.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    productName = json['Product_Name'];
    color = json['Color'];
    number = json['Number'];
    price = json['Price'];
    selected = json['Selected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['Product_Name'] = this.productName;
    data['Color'] = this.color;
    data['Number'] = this.number;
    data['Price'] = this.price;
    data['Selected'] = this.selected;
    return data;
  }
}