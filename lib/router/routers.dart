import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import '../page/details_page.dart';//详情页
import '../page/cart_page.dart';// 购物车页面
Handler detailsPage = Handler(//控制器
// 单个路由  详情页
  handlerFunc: (BuildContext context, Map<String,List<String>> params){
    String goodId = params['id'].first;
    return Details(goodId);
  }
);
Handler cartPageWidget = Handler(//控制器
// 单个路由 购物车
  handlerFunc: (BuildContext context, Map<String,List<String>> params){
    // String goodId = params['id'].first;
    return CartPageWidget();
  }
);