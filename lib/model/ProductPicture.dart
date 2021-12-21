class ProductPicture {
  List<ProductDetails> productDetails;

  ProductPicture({this.productDetails});

  ProductPicture.fromJson(Map<String, dynamic> json) {
    if (json['ProductDetails'] != null) {
      productDetails = new List<ProductDetails>();
      json['ProductDetails'].forEach((v) {
        productDetails.add(new ProductDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.productDetails != null) {
      data['ProductDetails'] =
          this.productDetails.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductDetails {
  String picture;
  String category;

  ProductDetails({this.picture, this.category});

  ProductDetails.fromJson(Map<String, dynamic> json) {
    picture = json['Picture'];
    category = json['Category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Picture'] = this.picture;
    data['Category'] = this.category;
    return data;
  }
}