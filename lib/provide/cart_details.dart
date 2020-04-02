import 'package:flutter/material.dart';

class Cartadd with ChangeNotifier {
  var list = [];
  add(val) {
    list.add(val);
    list.forEach((item) {
      item['flage'] = false;
      item['num'] = 1;
    });
    notifyListeners();
  }

  // 单选
  dynamic arr = 0;
  cartFlage(i) {
    if (list[i]['flage'] == false) {
      list[i]['flage'] = true;
      price();
    } else {
      list[i]['flage'] = false;
      price();
    }
    arr = list.every((item) {
      return item['flage'] == true;
    }) as dynamic;
    if (arr == true) {
      isquan = true;
      price();
    } else {
      isquan = false;
      price();
    }
    notifyListeners();
  }

  // 全选
  bool isquan = false;
  quan() {
    // 全选本身
    if (isquan == false) {
      isquan = true;
      list.forEach((item) {
        item['flage'] = isquan;
      });
      price();
    } else {
      isquan = false;
      list.forEach((item) {
        item['flage'] = isquan;
      });
      jiage = 0;
      num = 0;
    }
    notifyListeners();
  }

  // 减减
  jian(val) {
    print(val);
    if (list[val]['num'] == 1) {
      list[val]['num'] = 1;
    } else {
      list[val]['num']--;
      price();
    }
    notifyListeners();
  }

  // 加价
  jia(val) {
    print(val);
    list[val]['num']++;
    price();
    notifyListeners();
  }

  // 删除
  del(val) {
    list.remove(list[val]);
    if (list == []) {
      jiage = 0;
    } else {
      price();
    }

    notifyListeners();
  }

  // List app =[];
  // 计算价格
  var jiage = 0;
  price() {
    jiage = 0;
    list.forEach((item) {
      if (item['flage'] == true) {
        jiage += item['price'] * item['num'];
      }
    });
    heji();
    notifyListeners();
  }

  var num = 0;
  // 合计数量
  heji() {
    num = 0;
    list.forEach((item) {
      if (item['flage'] == true) {
        num += item['num'];
      }
    });
    notifyListeners();
  }
}
