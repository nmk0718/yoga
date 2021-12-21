import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'dart:io';



//使用通过test生产上传的目录+名称的name
// 请求工具类的方法上传
// 判断上传的状态码是否为200,
// 拼接出上传后的完整路径
// 把路径加入数组后续用来渲染
//
//   var uploadname =
//   OssUtil.instance.getImageUploadName('test', imagepath);
//   var result = await OssUtil.instance.uploadImgFunc(file, uploadname);
//   if (result.statusCode == 200) {
//     setState(() {
//       uploadimagename = Api.OSS_URL + uploadname;
//       imagefiles.add(uploadimagename);
//       print('上传成功' + '地址为:${uploadimagename}');
//     });
// }else {
//     print('后端请求出错');
//   }
class OssUtil {
  //验证文本域
  static String _policyText =
      '{"expiration": "2069-05-22T03:15:00.000Z","conditions": [["content-length-range", 0, 1048576000]]}'; //UTC时间+8=北京时间

  //进行utf8编码
  // ignore: non_constant_identifier_names
  static List<int> _policyText_utf8 = utf8.encode(_policyText);

  //进行base64编码
  static String policy = base64.encode(_policyText_utf8);

  //再次进行utf8编码
  // ignore: non_constant_identifier_names
  static List<int> _policy_utf8 = utf8.encode(policy);

  // 工厂模式
  factory OssUtil() => _getInstance();

  static OssUtil get instance => _getInstance();
  static OssUtil _instance;

  OssUtil._internal();

  static OssUtil _getInstance() {
    if (_instance == null) {
      _instance = new OssUtil._internal();
    }
    return _instance;
  }

  /*
  *获取signature签名参数
  */
  String getSignature(String _accessKeySecret) {
    //进行utf8 编码
    // ignore: non_constant_identifier_names
    List<int> AccessKeySecretUtf8 = utf8.encode(_accessKeySecret);
    //通过hmac,使用sha1进行加密
    List<int> signaturePre = new Hmac(sha1, AccessKeySecretUtf8)
        .convert(_policy_utf8)
        .bytes;
    //最后一步，将上述所得进行base64 编码
    String signature = base64.encode(signaturePre);
    return signature;
  }

  /*
  *获取图片名
  */
  String getImagename(String imagepath) {
    return imagepath.substring(imagepath.lastIndexOf("/") + 1, imagepath.length);
  }

  /*
  *获取图片后缀
  */
  String getImagesuffix(String imagename) {
    return imagename.substring(imagename.lastIndexOf(".") + 1, imagename.length);
  }

  /**
   * 生成上传上传图片的名称 ,获得的格式:test/20171027175940_oCiobK
   * 可以定义上传的路径uploadPath(Oss中保存文件夹的名称)
   * @param uploadPath OSS上传的路径 如：/test
   * @return photo/20171027175940_oCiobK
   */
  String getImageUploadName(String uploadPath,String filePath) {
    String imageMame = "";
    var timestamp = new DateTime.now().millisecondsSinceEpoch;
    imageMame =timestamp.toString()+"_"+getRandom(6);
    if(uploadPath!=null&&uploadPath.isNotEmpty){
      imageMame=uploadPath+"/"+imageMame;
    }
    String imageType=filePath?.substring(filePath?.lastIndexOf("."),filePath?.length);
    return imageMame+imageType;
  }

  String getImageName(String filePath) {
    String imageMame = "";
    var timestamp = new DateTime.now().millisecondsSinceEpoch;
    imageMame =timestamp.toString()+"_"+getRandom(6);
    String imageType=filePath?.substring(filePath?.lastIndexOf("."),filePath?.length);
    return imageMame+imageType;
  }

  /*
  * 生成固定长度的随机字符串
  * */
  String getRandom(int num) {
    String alphabet = 'qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM';
    String left = '';
    for (var i = 0; i < num; i++) {
//    right = right + (min + (Random().nextInt(max - min))).toString();
      left = left + alphabet[Random().nextInt(alphabet.length)];
    }
    return left;
  }

  /*
  *oss上传图片
  */
   uploadImgFunc(File image,String uploadname) async {
    FormData data = new FormData.fromMap({
      'key': uploadname, //上传的目录+图片名称
      'success_action_status': '200', //让服务端返回200，不然，默认会返回204
      'policy': policy,
      'OSSAccessKeyId': 'LTAI4G5zZ4wVWNVKvMcpL6cT',
      'signature': getSignature('7VZIabfX0MQZQOafAUct7vEdI2umPA'),
      'Content-Type': 'image/jpeg',
      'file': await MultipartFile.fromFile(image.path, filename: uploadname),
    });
    Dio dio = new Dio();
    Options options = Options(
        responseType: ResponseType.plain, contentType: "multipart/form-data");
    var result = await dio.post<String>(
      "https://hyy2018.oss-cn-beijing.aliyuncs.com/", //OSS地址
      data: data,
    );
    return result;
  }
}
