import 'api.dart';
import '../http/http.dart';

class RequestService {
  /// 查询Banner
  static Future SearchBanner() {
    return Http.post(
      Api.SearchBanner,
    );
  }
  /// 查询金刚区
  static Future SearchIcons() {
    return Http.post(
      Api.SearchIcons,
    );
  }
  /// 查询购物车
  static Future SearchShoppingCart() {
    return Http.post(
      Api.SearchShoppingCart,
      data: {"User_id": 1},
    );
  }
  /// 商品列表
  static Future ProductDetails() {
    return Http.post(
      Api.ProductDetails,
      data: {"shopping_id":1},
    );
  }
  /// 分页查询商品
  static Future PagedQueryShopping({int PageNo,String input_text,int status}) {
    return Http.post(
      Api.PagedQueryShopping,
      data: {"User_id":1,"PageNo":PageNo,"PageSize":6,"Input_text":input_text,"status":status},
    );
  }
  /// 删除购物车商品
  static Future DeleteShoppingCartOrder(int productid) {
    return Http.post(
      Api.DeleteShoppingCartOrder+'$productid',
    );
  }
  /// 更新购物车商品数量
  static Future UpdateShoppingCartNumber(int productnumber,int productid) {
    return Http.post(
      Api.UpdateShoppingCartNumber,
      data: {"User_id":1,"Shopping_number":productnumber,"Shopping_id":productid,},
    );
  }
  /// 查询推文
  static Future SearchTweet(int pageno) {
    return Http.post(
      Api.SearchTweet,
      data: {"User_id":1,"PageNo":pageno,"PageSize":6},
    );
  }
  /// 发布推文
  static Future AddTweet({String Tweet,List Image_url,String Time}) {
    return Http.post(
      Api.AddTweet,
      data: {"User_id":1,"Tweet":Tweet,"Image_url":Image_url,"Time":Time},
    );
  }

  /// 点赞转发推文
  static Future UpdateTweetStatus({int Memo_id,int Clicktype,int Click}) {
    return Http.post(
      Api.UpdateTweetStatus,
      data: {"User_id":1,"Memo_id":Memo_id,"Clicktype":Clicktype,"Click":Click},
    );
  }
}
