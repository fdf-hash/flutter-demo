import 'package:flutter/material.dart';

class CartPageWidget extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new CartPageWidgetState();
  }
}

class CartPageWidgetState extends State<CartPageWidget>{
  List list=[1,2,3];
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      // appBar: new AppBar(
      //   title: new Text('购物车'),
      // ),
      body: new Center(
        child: Column(children: <Widget>[
          Icon(Icons.shopping_cart,size: 130.0,color: Colors.blue,),
          Ztext('来了', Colors.red),
          Ztext('来了', Colors.red[50]),
          Ztext('来了', Colors.red[100]),
          Ztext('来了', Colors.red[200]),
          Ztext('来了', Colors.blue),
          f()
        ],)
      ),
    );
  }
  Widget f(){
    List<Widget> items = [];
    for (var item in list){
      items.add(Row(children: <Widget>[new Text('$item')],));
    }
    return Column(children:items,);
  }
}

class Ztext extends StatelessWidget {
  // const Ztext({Key key}) : super(key: key);
  String title;
  Color yanse;
  @override
  Ztext(this.title,this.yanse);
  Widget build(BuildContext context) {
    return Container(
      child: Text(title,style: TextStyle(color: yanse),),
    );
  }
}