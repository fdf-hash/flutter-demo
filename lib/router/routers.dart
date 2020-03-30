import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import '../page/details_page.dart';//详情页

Handler detailsPage = Handler(//控制器
// 单个路由
  handlerFunc: (BuildContext context, Map<String,List<String>> params){
    String goodId = params['id'].first;
    return Details(goodId);
  }
);