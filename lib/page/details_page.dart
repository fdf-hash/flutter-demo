import 'package:flutter/material.dart';
import '../router/routerapply.dart'; //路由文件
import '../http/server.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; //  屏幕适配
import 'package:flutter_html/flutter_html.dart';
import 'package:provide/provide.dart';
import '../provide/cart_details.dart';

class Details extends StatefulWidget {
  final String goodsId;
  List list;
  Details(this.goodsId); //路由跳转传值
  @override
  _DetailsState createState() => _DetailsState(goodsId);
}

class _DetailsState extends State<Details> {
  final String goodsId;
  _DetailsState(this.goodsId); //路由跳转传值

  void initState() {
    super.initState();
    print(this.goodsId);
  }

  var data;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffafafa),
      appBar: AppBar(
        centerTitle: true,
        title: Text('商品详情'),
        backgroundColor: Color(0xffe62565),
      ),
      body: FutureBuilder(
        future: request('detailsList', 'get', {'id': widget.goodsId}),
        builder: (context, res) {
          print(res.data['result']);
          res.data['result']['pic'] =
              res.data['result']['pic'].replaceAll(new RegExp(r'\\'), '/');
          if (res.data == null) {
            return new Center(
              child: Text('正在加载。。'),
            );
          } else {
            return ConstrainedBox(
                constraints: BoxConstraints.expand(),
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Positioned(
                        width: ScreenUtil().setWidth(750),
                        height: ScreenUtil().setHeight(1330),
                        top: 0,
                        child: ListView(
                          children: <Widget>[
                            _DetailsImage(res.data['result']['pic']),
                            new Container(
                              width: ScreenUtil().setWidth(750),
                              height: ScreenUtil().setHeight(165),
                              padding: EdgeInsets.only(
                                  left: ScreenUtil().setWidth(30)),
                              child: Column(
                                children: <Widget>[
                                  _DetailsName(res.data['result']['title']),
                                  _DetailsNum(),
                                  _DetailsPrice(res.data['result']['price'],
                                      res.data['result']['old_price'])
                                ],
                              ),
                            ),
                            new Container(
                              padding: EdgeInsets.only(
                                  left: ScreenUtil().setWidth(30)),
                              margin: EdgeInsets.only(
                                  top: ScreenUtil().setHeight(25),
                                  bottom: ScreenUtil().setHeight(16)),
                              width: ScreenUtil().setWidth(750),
                              height: ScreenUtil().setHeight(76),
                              child: Text('说明:>极速送达>正品保障',
                                  style: TextStyle(
                                    fontSize: ScreenUtil().setSp(26),
                                    color: Color(0xfff5837d),
                                  )),
                            ),
                            DetailsPhope(),
                            new Container(
                              child: Html(
                                data: res.data['result']['content'],
                              ),
                            ),
                          ],
                        )),
                    Positioned(
                        left: 0,
                        bottom: 0,
                        width: ScreenUtil().setWidth(750),
                        height: ScreenUtil().setHeight(90),
                        child: DetailsBottom(res.data['result']))
                  ],
                ));
          }
        },
      ),
    );
  }

//图片
  Widget _DetailsImage(url) {
    return new Container(
      color: Colors.white,
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(740),
      child: Image.network("http://jd.itying.com/" + url,
          width: ScreenUtil().setWidth(750),
          height: ScreenUtil().setHeight(740)),
    );
  }

// 文字
  Widget _DetailsName(name) {
    print(name);
    return new Container(
      width: ScreenUtil().setWidth(750),
      child: Text(
        name,
        style: TextStyle(
          fontSize: ScreenUtil().setSp(28),
        ),
        maxLines: 1,
        overflow: TextOverflow.visible,
      ),
    );
  }

  // 商品编号
  Widget _DetailsNum() {
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
  Widget _DetailsPrice(int price, oldprice) {
    print(price);
    print(oldprice);
    return new Container(
        child: new Row(
      children: <Widget>[
        Text('$price',
            style: TextStyle(
              fontSize: ScreenUtil().setSp(26),
              color: Color(0xfffb3074),
            )),
        Text('$oldprice',
            style: TextStyle(
              fontSize: ScreenUtil().setSp(22),
              color: Color(0xffa7a7a7),
              decoration: TextDecoration.lineThrough,
            ))
      ],
    ));
  }

  // 底部
  Widget DetailsBottom(item) {
    return Container(
        color: Colors.white,
        width: ScreenUtil().setWidth(750),
        height: ScreenUtil().setHeight(90),
        child: Row(
          children: <Widget>[
            new Container(
              width: ScreenUtil().setWidth(108),
              height: ScreenUtil().setHeight(90),
              child: Icon(
                Icons.shopping_cart,
                color: Color(0xfff1433b),
              ),
            ),
            new Container(
              width: ScreenUtil().setWidth(320),
              height: ScreenUtil().setHeight(90),
              child: FlatButton(
                onPressed: () {
                  print(
                      '-----------------------------------------------------------------------------------');
                  print(item);
                  Provide.value<Cartadd>(context).add(item);
                },
                child: Text(
                  '加入购物车',
                  style: TextStyle(color: Colors.white),
                ),
                color: Color(0xff50ae55),
              ),
            ),
            new Container(
              width: ScreenUtil().setWidth(320),
              height: ScreenUtil().setHeight(90),
              child: FlatButton(
                onPressed: () {},
                child: Text(
                  '立即购买',
                  style: TextStyle(color: Colors.white),
                ),
                color: Color(0xfff1453d),
              ),
            ),
          ],
        ));
  }
}

class DetailsPhope extends StatefulWidget {
  DetailsPhope({Key key}) : super(key: key);

  @override
  _DetailsPhopeState createState() => _DetailsPhopeState();
}

class _DetailsPhopeState extends State<DetailsPhope> {
  @override
  var list = ["详情", "评论"];
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(70),
      child: new Row(
        children: <Widget>[
          new Container(
            width: ScreenUtil().setWidth(375),
            child: Text(
              '详情',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(22), color: Colors.red),
            ),
          ),
          new Container(
            width: ScreenUtil().setWidth(375),
            child: Text(
              '评论',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(22), color: Color(0xff8b8b8b)),
            ),
          )
        ],
      ),
    );
  }
}
