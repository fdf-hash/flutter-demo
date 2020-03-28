import 'package:flutter/material.dart';

class MyDetailsPage extends StatefulWidget {
  MyDetailsPage({Key key}) : super(key: key);

  @override
  _MyDetailsPageState createState() => _MyDetailsPageState();
}

class _MyDetailsPageState extends State<MyDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.details),
        centerTitle: true,
        title: Text('商情页'),
        backgroundColor: Color(0xffe62565),
      ),
      body: new Container(
       child: Text('详情'),
      ),
    );
  }
}