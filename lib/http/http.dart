import 'package:dio/dio.dart';

import 'http_request.dart';

// http请求静态类
class Http {

  static const int CONNECT_TIMEOUT = 30000;
  static const int RECEIVE_TIMEOUT = 30000;

  static void init({
    /// 地址前缀
    String baseUrl,
    /// 连接超时时间,单位是毫秒
    int connectTimeout,
    /// 接收超时时间,单位是毫秒
    int receiveTimeout,
    /// 请求头
    Map<String, dynamic> headers,
    /// 基础拦截器
    List<Interceptor> interceptors,
  }) {
    HttpRequest().init(
      baseUrl: baseUrl,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      headers: headers,
      interceptors: interceptors,
    );
  }

  /// 设置请求头
  static void setHeaders(Map<String, dynamic> headers) {
    HttpRequest().setHeaders(headers);
  }

  /// 取消请求
  static void cancelRequests({CancelToken token}) {
    HttpRequest().cancelRequests(token: token);
  }

  /// restful get 操作
  static Future get(
      String path, {
        Map<String, dynamic> params,
        Options options,
        CancelToken cancelToken,
      }) async {
    return await HttpRequest().get(
      path,
      params: params,
      options: options,
      cancelToken: cancelToken,
    );
  }

  /// restful post 操作
  static Future post(
      String path, {
        Map<String, dynamic> params,
        dynamic data,
        Options options,
        CancelToken cancelToken,
      }) async {
    return await HttpRequest().post(
      path,
      params: params,
      data: data,
      options: options,
      cancelToken: cancelToken,
    );
  }

  /// restful post form 表单提交操作
  static Future postForm(
      String path, {
        Map<String, dynamic> params,
        Options options,
        CancelToken cancelToken,
      }) async {
    return await HttpRequest().postForm(
      path,
      params: params,
      options: options,
      cancelToken: cancelToken,
    );
  }
}