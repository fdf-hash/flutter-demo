import 'package:flutter/material.dart';
// import '../page/classification_page.dart';

class ClassPage with ChangeNotifier {
  List ClassPageList=[];
  // var http = '59f1e1ada1da8b15d42234e9';
  getClassifiaction(List list){
    ClassPageList=list;
    notifyListeners();//监听
  }
}
