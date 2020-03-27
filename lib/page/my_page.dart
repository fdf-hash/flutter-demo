import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:dio/dio.dart'; //http请求组件
import 'package:flutter_screenutil/flutter_screenutil.dart';//  屏幕适配

class MyPageWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MyPageWidgetState();
  }
}

class MyPageWidgetState extends State<MyPageWidget> {
  List<dynamic> arr=[];
  void initState() {
    //页面初始化
    super.initState();
    getHttp().then((val){
      print(val['result']);
      setState(() {
        arr=val['result'];
      });
      print(arr);
      arr.forEach((item)=>{
        item['pic']=item['pic'].replaceAll(new RegExp(r'\\'),'/')
      });
    });
  }

  Future getHttp() async {//Future  异步处理
    try {
      Response response;
      Dio dio = new Dio(); //http请求实例化
      response = await dio.get('http://jd.itying.com/api/focus');
      print(response.data);
      return response.data;
    } catch (e) {
      return e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new ListView(
        // mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          new Container(
            child: new Swiper(
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: Image.network(
                    'http://jd.itying.com/${arr[index]['pic']}',
                    fit: BoxFit.fill,
                  ),
                );
              },
              itemCount: 3,
              autoplay: true,
              loop: true,
              pagination: new SwiperPagination(builder: SwiperPagination.dots),
            ),
            width: double.infinity,
            height: 200,
            padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
          ),
          new Container(
            child: Image.network('${this.arr[0]['pic']}')
          )
        ]);
  }
}