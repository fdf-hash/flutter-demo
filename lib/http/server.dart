import 'package:dio/dio.dart';
import 'dart:io';
// import './path.dart';
const server = 'http://jd.itying.com';
const serverPath={
  // 轮播
  'homeBanner':server+'/api/focus',
  // 首页商品列表
  'homeHotList':server+'/api/plist',
  // 分类商品列表
  'classList':server+'/api/pcate',
  //商品详情页
  'detailsList':server+'/api/pcontent',
};
Future request(url, method, data) async {
  try {
    Response res;
    Dio dio = new Dio();
    // dio.options.contentType =ContentType.parse("application/x-www-form-urlencoded");
    if (method == 'get') {
     if (data == null) {
        res = await dio.get(serverPath[url]);
        return res.data;
      } else {
        res = await dio.get(serverPath[url],queryParameters: data);
        return res.data;
      }
    } else {
      if (data == null) {
        res = await dio.post(serverPath[url]);
        return res.data;
      } else {
        res = await dio.post(serverPath[url], data: data);
        return res.data;
      }
    }
  } catch (e) {
    print(e);
  }
}
