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

const URL = 'http://jd.itying.com/'; //用于图片路径拼接

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
      body: new ConstrainedBox(
        // width: ScreenUtil().setWidth(750),
        // height: ScreenUtil().setHeight(1200),
        constraints: BoxConstraints.expand(),
        child: Provide<Cartadd>(
          builder: (context, child, val) {
            return Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Positioned(
                    width: ScreenUtil().setWidth(750),
                    height: ScreenUtil().setHeight(1200),
                    child: ListView.builder(
                      itemCount: val.list.length,
                      itemBuilder: (context, index) {
                        return Container(
                          // margin: index == 0 ? EdgeInsets.only(top: 60) : null,
                          width: double.infinity,
                          padding: EdgeInsets.fromLTRB(
                            0,
                            ScreenUtil().setHeight(20),
                            10,
                            ScreenUtil().setHeight(30),
                          ),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1, color: Colors.black38))),
                          child: Row(
                            children: <Widget>[
                              //单选开始
                              Checkbox(
                                value:val.list[index]['flage'],
                                activeColor: Colors.red,
                                onChanged: (bool val) {
                                  // print(val);
                                  Provide.value<Cartadd>(context).cartFlage(index);
                                },
                              ),
                              Container(
                                width: ScreenUtil().setWidth(140),
                                height: ScreenUtil().setHeight(140),
                                child: Image.network(
                                  'http://jd.itying.com/${val.list[index]['pic']}',
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                              Container(
                                width: ScreenUtil().setWidth(250),
                                margin: EdgeInsets.only(left: 20),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                        width: ScreenUtil().setWidth(200),
                                        child: Wrap(
                                          children: <Widget>[
                                            Text(
                                              '${val.list[index]['title']}',
                                              textAlign: TextAlign.center,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        )),
                                    Container(
                                      width: ScreenUtil().setWidth(200),
                                      height: ScreenUtil().setHeight(10),
                                    ),
                                    Row(
                                      children: <Widget>[
                                        //购物车数量减一
                                        GestureDetector(
                                          onTap: () {
                                            Provide.value<Cartadd>(context).jian(index);
                                          },
                                          child: Container(
                                            width: ScreenUtil().setWidth(45),
                                            height: ScreenUtil().setHeight(45),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 1,
                                                    color: Colors.black38)),
                                            child: Text(
                                              '-',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: ScreenUtil().setWidth(45),
                                          height: ScreenUtil().setHeight(45),
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  top: BorderSide(
                                                      width: 1,
                                                      color: Colors.black38),
                                                  bottom: BorderSide(
                                                      width: 1,
                                                      color: Colors.black38))),
                                          child: Text(
                                            '${val.list[index]['num']}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        GestureDetector(
                                          //购物车数量加一
                                          onTap: () {
                                            Provide.value<Cartadd>(context).jia(index);
                                          },
                                          child: Container(
                                            width: ScreenUtil().setWidth(45),
                                            height: ScreenUtil().setHeight(45),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 1,
                                                    color: Colors.black38)),
                                            child: Text(
                                              '+',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              //删除按钮
                              Container(
                                width: ScreenUtil().setWidth(180),
                                height: ScreenUtil().setHeight(140),
                                padding: EdgeInsets.only(
                                    top: ScreenUtil().setWidth(30)),
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      '￥${val.list[index]['price']*val.list[index]['num']}',
                                      style: TextStyle(
                                          fontSize: ScreenUtil().setSp(24)),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                         Provide.value<Cartadd>(context).del(index);
                                      },
                                      child: Icon(
                                        Icons.delete_forever,
                                        size: ScreenUtil().setSp(40),
                                        color: Colors.black38,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    )),
                Positioned(
                  width: ScreenUtil().setWidth(750),
                  height: ScreenUtil().setHeight(100),
                  bottom: ScreenUtil().setHeight(100),
                  left: 0,
                  child: Container(
                    width: ScreenUtil().setHeight(750),
                    height: ScreenUtil().setHeight(100),
                    color: Colors.white,
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: ScreenUtil().setWidth(150),
                          child: Row(
                            children: <Widget>[
                              Checkbox(
                                value: val.isquan,
                                activeColor: Colors.red,
                                onChanged: (val) {
                                  Provide.value<Cartadd>(context).quan();
                                },
                              ),
                              Text(
                                '全选',
                                style:
                                    TextStyle(fontSize: ScreenUtil().setSp(24)),
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: ScreenUtil().setHeight(100),
                          margin: EdgeInsets.only(
                              left: ScreenUtil().setWidth(100),
                              right: ScreenUtil().setWidth(10)
                              ),
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
                                    '${val.num}',
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
                          // width: ScreenUtil().setWidth(120),
                          height: ScreenUtil().setHeight(60),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(6)),
                          child: Text(
                            '结算(${val.jiage})',
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
      ),
    );
  }
}