import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import './routers.dart';
// 类似vue的routre index.js路由文件
class Routes{
  static String root = '/';//类似根目录
  static String detailspage = '/details';
  static String cartPagepage = 'cart';
  static void configRoutes(Router router){
    // 路由路径不存在notFoundHandler()  跳转或提示页面
    router.notFoundHandler = new Handler(
      handlerFunc:(BuildContext context,Map<String,List<String>> params){
        print('ERROR======NO FIND! 404');
      }
    );
    //单个路由配置
    router.define(detailspage, handler: detailsPage);  // 前面参数代表7行的路由名称   第二个参数代表单个路由配置文件 3行   多个一只重复即可
    router.define(cartPagepage, handler: cartPageWidget); 
  
  }
}
