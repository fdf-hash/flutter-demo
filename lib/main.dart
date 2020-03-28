import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; //  屏幕适配
import 'page/home_page.dart';
import 'page/classification_page.dart';
import 'page/cart_page.dart';
import 'page/my_page.dart';


void main()=>runApp(MyApp());


class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyIndex(),
      
    );
  }
}

// 创建有状态组件
class MyIndex extends StatefulWidget {
  @override
  MyNav createState() => new MyNav();
}

class MyNav extends State<MyIndex> {
  var index = 0;
  List<StatefulWidget> list = [
    ClassPageWidget(),
    HomePageWidget(),
    CartPageWidget(),
    MyPageWidget(),
  ];
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1521)
      ..init(context); //设置页面的宽高  尺寸  屏幕适配
    return Scaffold(
      body: list[this.index],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('首页'),
              activeIcon: Icon(
                Icons.home,
                color: Colors.red,
              )),
          BottomNavigationBarItem(
              icon: Icon(Icons.search),
              title: Text('分类'),
              activeIcon: Icon(
                Icons.search,
                color: Colors.red,
              )),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              title: Text('购物车'),
              activeIcon: Icon(
                Icons.shopping_cart,
                color: Colors.red,
              )),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_pin),
              title: Text('我的'),
              activeIcon: Icon(
                Icons.person_pin,
                color: Colors.red,
              ))
        ],
        onTap: (ind) {
          setState(() {
            this.index = ind;
          });
        },
        currentIndex: index,
        fixedColor: Color(0xffe22830),
        type: BottomNavigationBarType.fixed, //超过两个items字体显示
      ),
    );
  }
}
