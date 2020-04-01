import 'package:flutter/material.dart';
import '../http/server.dart';

class DetailsProvide with ChangeNotifier {
  var url;
  detailsId(val) {
    url = val;
    print(url);
    DetailsHttp();
    notifyListeners();
  }
  List arr = [];
  DetailsHttp() async {
    var da = {'id': '$url'};
    await request('detailsList', 'get', da).then((val) {
      print(da);
      arr.add(val['result']);
      arr = arr;
      print(arr);
      arr.forEach((item) =>
          item['pic'] = item['pic'].replaceAll(new RegExp(r'\\'), '/'));
    });
  }
  notifyListeners();
}
