import 'package:flutter/material.dart';

class Cartadd with ChangeNotifier {
  var list ;
  add(val){
    list=val;
    print(list);
    print('11111111112222222222222222222222222222222222');
    notifyListeners();
  }
  bool flage = false;
  cartFlage(){
    flage = true;
    notifyListeners();
  }
}