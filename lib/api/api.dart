class Api {
  // false表示生产环境,true表示测试环境
  static const bool isTest = true;
  // 后端地址前缀
  static const String BASE_URL = isTest == true ? 'http://121.4.147.189:9090' : 'http://121.4.147.189:9090' ;
  // OSS地址前缀
  static const String OSS_URL = 'https://hyy2018.oss-cn-beijing.aliyuncs.com/' ;
  // 查询Banner
  static const String SearchBanner = BASE_URL + '/SearchBanner' ;
  // 查询金刚区
  static const String SearchIcons = BASE_URL + '/SearchIcons' ;
  // 查询购物车
  static const String SearchShoppingCart = BASE_URL + '/SearchShoppingCart' ;
  // 商品列表
  static const String ProductDetails = BASE_URL + '/ProductDetails';
  // 查询商品
  static const String PagedQueryShopping = BASE_URL + '/PagedQueryShopping';
  // 删除购物车商品
  static const String DeleteShoppingCartOrder = BASE_URL + '/DeleteShoppingCartOrder?shoppingid=';
  // 更新购物车商品数量
  static const String UpdateShoppingCartNumber = BASE_URL + '/UpdateShoppingCartNumber';
  // 查询推文
  static const String SearchTweet = BASE_URL + '/SearchTweet';
  // 发布推文
  static const String AddTweet = BASE_URL + '/AddTweet';
  // 点赞转发推文
  static const String UpdateTweetStatus = BASE_URL + '/UpdateTweetStatus';
}