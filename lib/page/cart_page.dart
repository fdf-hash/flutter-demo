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
          Number(),
          Mybutton()
        ],
      )),
    );
  }
}

class Number extends StatelessWidget {
  const Number({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top:10),
      child: Provide<Couter>(
        // 
        builder:(context,child,couter){
          return Text(
            '${couter.value}'
          );
        },
      )
    );
  }
}

class Mybutton extends StatelessWidget {
  const Mybutton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
        onPressed: (){
          Provide.value<Couter>(context).add();
        },
        child: Text('+++'),
      )
    );
  }
}

