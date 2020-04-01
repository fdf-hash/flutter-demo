import 'package:flutter/material.dart';
import '../http/server.dart';// 封装接口文件
import 'package:flutter_screenutil/flutter_screenutil.dart'; //  屏幕适配
import 'package:provide/provide.dart';
import '../provide/state.dart';
import '../router/routerapply.dart';

class ClassPageWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new ClassPageWidgetState();
  }
}

class ClassPageWidgetState extends State<ClassPageWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.search),
        centerTitle: true,
        title: Text('商品分类'),
        backgroundColor: Color(0xffe62565),
      ),
      body: Container(child: Provide<Couter>(builder: (context, child, couter) {
        return Row(
          children: <Widget>[LeftCategoryNav(), RightCategoryNav()],
        );
      })),
    );
  }
}

//左侧大类导航
class LeftCategoryNav extends StatefulWidget {
  @override
  _LeftCategoryNavState createState() => _LeftCategoryNavState();
}

class _LeftCategoryNavState extends State<LeftCategoryNav> {
  List list = [];
  int isRight = 0;
  @override
  void initState() {
    super.initState();
    _getCategory(); //请求接口的数据
  }

  @override
  //左侧大类导航
  Widget build(BuildContext context) {
    return Provide<Couter>(builder: (context, child, couter) {
      return Container(
        width: ScreenUtil().setWidth(180),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              right: BorderSide(width: 1.0, color: Colors.black12), //有边框
            )),
        child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (contex, index) {
            return _leftInkWell(index);
          },
        ),
      );
    });
  }

  Widget _leftInkWell(int index) {
    bool isRighrBool = false;
    isRighrBool = (index == isRight) ? true : false;
    return InkWell(
      onTap: () {
        // print(list[index]['_id']);
        Provide.value<Couter>(context).classLeft(list[index]['_id']); //点击获取id传值
        setState(() {
          isRight = index;
        });
      },
      child: Container(
        alignment: Alignment(0, 0),
        height: ScreenUtil().setHeight(100),
        padding: EdgeInsets.only(left: 10.0, top: 10.0),
        decoration: BoxDecoration(
            color: isRighrBool ? Colors.black26 : Colors.white,
            border:
                Border(bottom: BorderSide(width: 1.0, color: Colors.black12))),
        child: Text(
          list[index]['title'],
          style: TextStyle(
              fontSize: ScreenUtil().setSp(28),
              color: isRighrBool
                  ? Colors.white
                  : Colors.black), //设置字体大小，为了兼容使用setSp
        ),
      ),
    );
  }

  //一级分类请求接口
  void _getCategory() async {
    await request('classList', 'get', null).then((val) {
      print(val['result']);
      setState(() {
        list = val['result'];
      });
    });
  }
}

// 右侧分类导航
class RightCategoryNav extends StatefulWidget {
  @override
  _RightCategoryNav createState() => _RightCategoryNav();
}

class _RightCategoryNav extends State<RightCategoryNav> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      width: ScreenUtil().setWidth(570),
      child: Column(
        // width: ScreenUtil().setWidth(570),
        children: <Widget>[RightTopNav(), RightDetails()],
      ),
    );
  }
}

// 右侧导航的顶部导航
class RightTopNav extends StatefulWidget {
  @override
  _RightTopNav createState() => _RightTopNav();
}

// 右侧导航的顶部导航
class _RightTopNav extends State<RightTopNav> {
  int num = 0;
  var url = '59f1e1ada1da8b15d42234e9';
  List arr = [];
  void initState() {
    super.initState();
    RightTophttp();
  }

  RightTophttp() async {
    var da = {'pid': '$url'};
    await request('classList', 'get', da).then((val) {
      setState(() {
        arr = val['result'];
      });
      // print(list);
      arr.forEach((item) =>
          {item['pic'] = item['pic'].replaceAll(new RegExp(r'\\'), '/')});
      // 这里表示页面初始化刷新获取到的数据数据
      Provide.value<Couter>(context).arr = arr;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Provide<Couter>(builder: (context, child, couter) {
      return new Container(
        // child: Text('${couter.arr}')
        width: ScreenUtil().setWidth(570),
        height: ScreenUtil().setHeight(88),
        decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border(bottom: BorderSide(width: 1.0, color: Colors.black12))),
        child: ListView.builder(
          // width: ScreenUtil().setWidth(570),
          scrollDirection: Axis.horizontal,
          itemCount: couter.arr.length,
          itemBuilder: (context, index) {
            return _RightInkll(couter.arr[index]['title'], index);
          },
        ),
      );
    });
    //二级分类请求接口
  }

  Widget _RightInkll(String item, index) {
    // 判断添加字体颜色
    bool erji = false;
    erji = (num == index) ? false : true;
    return InkWell(
      onTap: () {
        // print(item[index]['_id']);
        setState(() {
          num = index;
        });
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
        child: Text(
          item,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(28),
            color: erji ? Colors.black : Colors.red,
          ),
        ),
      ),
    );
  }
}

// 右侧的具体分类内容
class RightDetails extends StatefulWidget {
  @override
  _RightDetailsState createState() => _RightDetailsState();
}

class _RightDetailsState extends State<RightDetails> {
  var url = '59f1e1ada1da8b15d42234e9';
  List list = [];
  // 监听url地址变化

  @override
  void initState() {
    super.initState();
    _RightTophttp();
  }

  void _RightTophttp() async {
    var da = {'pid': '$url'};
    await request('classList', 'get', da).then((val) {
      // print('二级分');
      setState(() {
        list = val['result'];
      });
      // print(list);
      list.forEach((item) =>
          {item['pic'] = item['pic'].replaceAll(new RegExp(r'\\'), '/')});
      Provide.value<Couter>(context).list = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    // provider传输数据
    return Provide<Couter>(builder: (context, child, couter) {
      return Container(
        color: Colors.white,
        width: ScreenUtil().setWidth(570),
        height: ScreenUtil().setHeight(1100),
        child: ListView.builder(
          itemCount: couter.list.length,
          itemBuilder: (context, index) {
            return _RightDetails(couter.list[index], index);
          },
        ),
      );
    });
  }

  Widget _RightDetails(item, index) {
    return new Container(
      margin: EdgeInsets.only(
          left: ScreenUtil().setWidth(2),
          top: ScreenUtil().setHeight(4),
          bottom: ScreenUtil().setHeight(4)),
      width: ScreenUtil().setWidth(568),
      height: ScreenUtil().setHeight(210),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          // Text('${item}')
          _DetailsImage(item,index),
          new Column(
            children: <Widget>[
              Container(
                width: ScreenUtil().setWidth(370),
                height: ScreenUtil().setHeight(105),
                child: Text(
                  "${item['title']}",
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(30),
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              Container(
                  width: ScreenUtil().setWidth(370),
                  height: ScreenUtil().setHeight(105),
                  child: new Row(
                    children: <Widget>[
                      Text(
                        "价格:${item['sort']}",
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(30),
                            color: Color(0xFFE93C76)),
                      ),
                      Text(
                        "￥${item['status:']}",
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(24),
                          color: Color(0xFFC0BFC0),
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ))
            ],
          )
        ],
      ),
    );
  }

  Widget _DetailsImage(item,index) {
    return InkWell(
      onTap: () {
        print(item['id']);
        Routerapply.router.navigateTo(context, '/details?id=${item['_id']}');

      },
      child: Container(
        width: ScreenUtil().setWidth(198),
        height: ScreenUtil().setHeight(210),
        child: Image.network(
          "http://jd.itying.com/${item['pic']}",
          width: ScreenUtil().setWidth(198),
          height: ScreenUtil().setHeight(210),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
