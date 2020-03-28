import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
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
        leading: Icon(Icons.shopping_cart),
        centerTitle: true,
        title: Text('购物车'),
        backgroundColor: Color(0xffe62565),
      ),
      body: new Center(
          child: Column(
        children: <Widget>[
          Icon(
            Icons.shopping_cart,
            size: 130.0,
            color: Colors.blue,
          ),
        ],
      )),
    );
  }
}


