import 'package:flutter/material.dart';
import '../http/server.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; //  屏幕适配

class Details extends StatefulWidget {
  final String goodsId;
  List list;
  Details(this.goodsId); //路由跳转传值
  @override
  _DetailsState createState() => _DetailsState(goodsId);
}

class _DetailsState extends State<Details> {
  final String goodsId;
  List list;
  _DetailsState(this.goodsId); //路由跳转传值

  void initState() {
    super.initState();
    print(this.goodsId);
    _DetailsHttp(); //请求接口的数据
  }

  // 封装接口
  void _DetailsHttp() async {
    var da = {'id': '$goodsId'};
    await request('detailsList', 'get', da).then((val) {
      print(da);
      list.add(val['result']);
      list = list;
      print(list);
      list.forEach((item) =>
          item['pic'] = item['pic'].replaceAll(new RegExp(r'\\'), '/'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffafafa),
      appBar: AppBar(
        centerTitle: true,
        title: Text('商品详情'),
        backgroundColor: Color(0xffe62565),
      ),
      body: ListView(
        //  itemCount: list.length,
        //  itemBuilder: (context, index) {
        //    return _DetailsImage(list[index]['pic']);
        //  },
        children: <Widget>[
          _DetailsImage(list),
        ],
        // children: <Widget>[
        //   // 图片
        //   new Container(
        //     width: ScreenUtil().setWidth(750),
        //     height: ScreenUtil().setHeight(740),
        //     // child: Image.network("http://jd.itying.com/${list}",
        //     //     width: ScreenUtil().setWidth(750),
        //     //     height: ScreenUtil().setHeight(740)),
        //     // child: Text('$list'),
        //   ),
        //   // 文字
        //   new Container(
        //     width: ScreenUtil().setWidth(750),
        //     height: ScreenUtil().setHeight(165),
        //     padding: EdgeInsets.only(left: ScreenUtil().setWidth(30)),
        //     child: new Column(
        //       children: <Widget>[
        //         new Container(
        //           width: ScreenUtil().setWidth(750),
        //           child: Text(
        //             '商品ID：$goodsId',
        //             style: TextStyle(
        //               fontSize: ScreenUtil().setSp(28),
        //             ),
        //           ),
        //         ),
        //         new Container(
        //           width: ScreenUtil().setWidth(750),
        //           padding: EdgeInsets.only(
        //               top: ScreenUtil().setHeight(25),
        //               bottom: ScreenUtil().setHeight(25)),
        //           child: Text(
        //             "编号:Instance of 'GooldInfo'",
        //             style: TextStyle(
        //               fontSize: ScreenUtil().setSp(24),
        //               color: Color(0xffe0e1e0),
        //             ),
        //           ),
        //         ),
        //         new Container(
        //             child: new Row(
        //           children: <Widget>[
        //             Text('10.0',
        //                 style: TextStyle(
        //                   fontSize: ScreenUtil().setSp(26),
        //                   color: Color(0xfffb3074),
        //                 )),
        //             Text('商场价12.0',
        //                 style: TextStyle(
        //                   fontSize: ScreenUtil().setSp(22),
        //                   color: Color(0xffa7a7a7),
        //                   decoration: TextDecoration.lineThrough,
        //                 ))
        //           ],
        //         ))
        //       ],
        //     ),
        //   ),
        //   // 说明
        //   new Container(
        //     padding: EdgeInsets.only(left: ScreenUtil().setWidth(30)),
        //     margin: EdgeInsets.only(
        //         top: ScreenUtil().setHeight(25),
        //         bottom: ScreenUtil().setHeight(16)),
        //     width: ScreenUtil().setWidth(750),
        //     height: ScreenUtil().setHeight(76),
        //     child: Text('说明:>极速送达>正品保障',
        //         style: TextStyle(
        //           fontSize: ScreenUtil().setSp(26),
        //           color: Color(0xfff5837d),
        //         )),
        //   ),
        // ],
      ),
    );
  }

//图片
  Widget _DetailsImage(url) {
    return new Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(740),
      // child: Image.network("http://jd.itying.com/"+url,
      //     width: ScreenUtil().setWidth(750),
      //     height: ScreenUtil().setHeight(740)),
      child: Text('$url'),
    );
  }

// 文字
  Widget _DetailsName(name) {
    return new Container(
      width: ScreenUtil().setWidth(750),
      child: Text(
        '商品ID：$goodsId',
        style: TextStyle(
          fontSize: ScreenUtil().setSp(28),
        ),
      ),
    );
  }

  // 商品编号
  Widget _DetailsNum(num) {
    return new Container(
      width: ScreenUtil().setWidth(750),
      padding: EdgeInsets.only(
          top: ScreenUtil().setHeight(25), bottom: ScreenUtil().setHeight(25)),
      child: Text(
        "编号:Instance of 'GooldInfo'",
        style: TextStyle(
          fontSize: ScreenUtil().setSp(24),
          color: Color(0xffe0e1e0),
        ),
      ),
    );
  }

  // 商品价格
  Widget _DetailsPrice(price) {
    return new Container(
        child: new Row(
      children: <Widget>[
        Text('10.0',
            style: TextStyle(
              fontSize: ScreenUtil().setSp(26),
              color: Color(0xfffb3074),
            )),
        Text('商场价12.0',
            style: TextStyle(
              fontSize: ScreenUtil().setSp(22),
              color: Color(0xffa7a7a7),
              decoration: TextDecoration.lineThrough,
            ))
      ],
    ));
  }
}
