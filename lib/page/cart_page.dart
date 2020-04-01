import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import '../provide/cart_details.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; //  屏幕适配
import '../provide/state.dart';

class CartPageWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new CartPageWidgetState();
  }
}

class CartPageWidgetState extends State<CartPageWidget> {
  List list = [1, 2, 3];
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        // leading: Icon(Icons.shopping_cart),
        centerTitle: true,
        title: Text('购物车'),
        backgroundColor: Color(0xffe62565),
      ),
      body: new Center(
          child: ListView(
        children: <Widget>[
          Provide<Cartadd>(
            builder: (context, child, val) {
              return Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Positioned(
                        // width: ScreenUtil().setWidth(750),
                        // height: ScreenUtil().setHeight(100),
                        // top: 0,
                        child: Container(
                          width: double.infinity,
                          height: ScreenUtil().setHeight(100),
                          color: Colors.white,
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: ScreenUtil().setWidth(150),
                                child: Row(
                                  children: <Widget>[
                                    Checkbox(
                                      value: false,
                                      activeColor: Colors.red,
                                      onChanged: (val) {
                                        Provide.value<Cartadd>(context)
                                            .cartFlage();
                                      },
                                    ),
                                    Text(
                                      '全选',
                                      style: TextStyle(
                                          fontSize: ScreenUtil().setSp(24)),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                height: ScreenUtil().setHeight(100),
                                margin: EdgeInsets.only(
                                    left: ScreenUtil().setWidth(120),
                                    right: ScreenUtil().setWidth(22)),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          '合计:',
                                          style: TextStyle(
                                              fontSize: ScreenUtil().setSp(24)),
                                        ),
                                        Text(
                                          '11',
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: ScreenUtil().setSp(24)),
                                        )
                                      ],
                                    ),
                                    Text('满10元免配送费,预购免配送费',
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontSize: ScreenUtil().setSp(24)))
                                  ],
                                ),
                              ),
                              Container(
                                width: ScreenUtil().setWidth(120),
                                height: ScreenUtil().setHeight(60),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(6)),
                                child: Text(
                                  '结算(5)',
                                  style: TextStyle(color: Colors.white),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
            },
          ),
        ],
      )),
    );
  }
}
