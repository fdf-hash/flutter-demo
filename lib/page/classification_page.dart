import 'package:flutter/material.dart';
import '../http/server.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; //  屏幕适配
class ClassPageWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new ClassPageWidgetState();
  }
}

class ClassPageWidgetState extends State<ClassPageWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('商品分类'),),
      body: Container(
        child: Row(
          children: <Widget>[
            LeftCategoryNav(),
            RightCategoryNav()
          ],
        ),
      ),
    );
  }
}

//左侧大类导航
class LeftCategoryNav extends StatefulWidget {
  @override
  _LeftCategoryNavState createState() => _LeftCategoryNavState();
}
class _LeftCategoryNavState extends State<LeftCategoryNav> {
  List list=['白酒','葡萄酒','黄酒','清酒','可乐','清酒','保健酒','洋酒','预调酒','下菜小酒','饮料','乳制品','休闲粮食','粮油调味','雪碧','泉水','橙子','橘子',];
  int isRight = 0;
  
  @override

  void initState() {
    super.initState();
    // _getCategory();//请求接口的数据
  }
  @override
  Widget build(BuildContext context) {
    
    return Container(
      width: ScreenUtil().setWidth(180),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          right: BorderSide(width:1.0,color: Colors.black12),//有边框
        )
      ),
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (contex,index){
          return _leftInkWell(index);
        },
      ),
    );
  }
 
  Widget _leftInkWell(int index){
    // print(index);
    bool  isRighrBool = false;
    isRighrBool=(index==isRight)?true:false;
    return InkWell(
      onTap: (){
          setState(() {
            isRight==index;
          });
          // var ch
      },
      child: Container(
        height: ScreenUtil().setHeight(100),
        padding: EdgeInsets.only(left:10.0,top:10.0),
        decoration: BoxDecoration(
          color: isRighrBool?Colors.black26:Colors.white,
          border: Border(
            bottom: BorderSide(width: 1.0,color: Colors.black12)
          )
        ),
        child: Text(
          list[index],
          style: TextStyle(fontSize: ScreenUtil().setSp(28)),//设置字体大小，为了兼容使用setSp
        ),
      ),
    );
  }
  //  void _getCategory() async{
  //   await request('CidList','get',null).then((val){
  //     var data=json.decode(val.toString());
  //     //print(data);
  //     CategoryModel category= CategoryModel.fromJson(data);
  //     setState(() {
  //      list=category.data;
  //     });
  //     //list.data.forEach((item)=>print(item.mallCategoryName));
  //   });
  // }
}


// 右侧分类导航
class RightCategoryNav extends StatefulWidget{
  @override
  _RightCategoryNav createState() => _RightCategoryNav();
}
class _RightCategoryNav extends State<RightCategoryNav>{
  @override
  Widget build(BuildContext context) {
    return new Container(
      width: ScreenUtil().setWidth(570),
      child: Column(
        // width: ScreenUtil().setWidth(570),
        children: <Widget>[
          RightTopNav(),
          // RightDetails()
        ],
      ),
    );
  }
}

// 右侧导航的顶部导航
class RightTopNav extends StatefulWidget{
  @override
  _RightTopNav createState()=> _RightTopNav();
}
// / 右侧导航的顶部导航
class _RightTopNav extends State<RightTopNav>{
  List list=['白酒','葡萄酒','黄酒','清酒','可乐','清酒','保健酒','洋酒','预调酒','下菜小酒','饮料','乳制品','休闲粮食'];
  @override
  Widget build(BuildContext context) {
    return new Container(
      width: ScreenUtil().setWidth(570),
      height: ScreenUtil().setHeight(88),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 1.0,color: Colors.black12)
        )
      ),
      child: ListView.builder(
        // width: ScreenUtil().setWidth(570),
        scrollDirection: Axis.horizontal,
        itemCount:list.length,
        itemBuilder: (context,index){
          return _RightInkll(list[index]);
        },
      ),
    );
  }
  Widget _RightInkll(String item){
    
    return InkWell(
      onTap: (){},
      child: Container(
       padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
       child: Text(item,style: TextStyle(fontSize: ScreenUtil().setSp(28),color: Colors.red),),
      ),
    );
  }
}


// 右侧的具体分类内容
class RightDetails extends StatefulWidget {
  @override
  _RightDetailsState createState() => _RightDetailsState();
}

class _RightDetailsState extends State<RightDetails> {
   List list=['白酒','葡萄酒','黄酒','清酒','可乐','清酒','保健酒','洋酒','预调酒','下菜小酒','饮料','乳制品','休闲粮食'];
  @override
  Widget build(BuildContext context) {
    return Container(
       color: Colors.white,
      //  width: ScreenUtil().setWidth(570),
       child: ListView.builder(
        itemCount:list.length,
        itemBuilder: (context,index){
          return _RightDetails(list[index]);
        },
      ),
    );
  }
  Widget _RightDetails(String item){
    return InkWell(
      onTap: (){},
      child: Container(
       padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
       child: Text(item,style: TextStyle(fontSize: ScreenUtil().setSp(28)),),
      ),
    );
  }
}