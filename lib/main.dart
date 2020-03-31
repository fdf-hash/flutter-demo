import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; //  屏幕适配
import 'page/home_page.dart';
// import 'page/classification_page.dart';//兄弟传值
import 'page/class_page.dart'; //provider
import 'page/cart_page.dart';
import 'page/my_page.dart';
import 'package:provide/provide.dart';//provide
import './provide/state.dart';
import 'package:fluro/fluro.dart';//路由
import './router/routermain.dart';
import './router/routerapply.dart';
void main() {
  var counter = Couter();
  var providers = Providers();
  providers..provide(Provider<Couter>.value(counter));
  runApp(ProviderNode(
    child: MyApp(),
    providers: providers,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

  final router = Router();//初始化路由
  Routes.configRoutes(router);//注入路由
  Routerapply.router = router;//静态化
  
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Routerapply.router.generator,//静态化 直接使用  只用引入Routerapply
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
    HomePageWidget(),
    ClassPageWidget(),
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
