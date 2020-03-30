import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
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
          Provide<Couter>(
            builder: (context, child, couter) {
              return Text(
                '${couter.value}',//获取
                style: TextStyle(fontSize: 30.0),
              );
            },
          ),
          MyButton()
        ],
      )),
    );
  }
}

class MyButton extends StatelessWidget {
  const MyButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
          onPressed: () {
            Provide.value<Couter>(context).add();
          },
          child: Text('增加'),
        ),
    );
  }
}
