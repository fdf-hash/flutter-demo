
import 'package:flutter/material.dart';

class Couter with ChangeNotifier{
  int value = 0;

  add(){
    value++;
    //调用notifyListeners()方法通知听众,vlaue值发生了改变，局部刷新我们的widget
    notifyListeners();
  }
}