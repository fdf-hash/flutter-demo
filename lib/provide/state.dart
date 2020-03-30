import 'package:flutter/material.dart';
import '../http/server.dart';

class Couter with ChangeNotifier {
  int value = 0;
  add() {
    // value++;
    RightTophttp();
    RightDetails();
    //调用notifyListeners()方法通知听众,vlaue值发生了改变，局部刷新我们的widget
    notifyListeners();
  }

  // 分类页面请求数据接口
  var url = '59f1e1ada1da8b15d42234e9';
  classLeft(val) {
    url = val;
    print(url);
    RightDetails();
    RightTophttp();
    notifyListeners();
  }

  var list = []; //详情
  RightDetails() async {
    var da = {'pid': '$url'};
    await request('classList', 'get', da).then((val) {
      print('二级分');
      list = val['result'];
      print(list);
      list.forEach((item) =>
          {item['pic'] = item['pic'].replaceAll(new RegExp(r'\\'), '/')});
    });
    notifyListeners();
  }

  var arr = []; //头部导航
  // 二级分类请求
  RightTophttp() async {
    var da = {'pid': '$url'};
    await request('classList', 'get', da).then((val) {
      // print('二级分');
      // print(val['result']);
      arr = val['result'];
    });
    notifyListeners();
  }
}
