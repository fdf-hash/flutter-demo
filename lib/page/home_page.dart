import 'package:demo_life/http/server.dart';
import 'package:flutter/material.dart'; //ui组件
import 'package:flutter/rendering.dart';
import 'package:flutter_swiper/flutter_swiper.dart'; //轮播组件
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; //  屏幕适配
import '../http/server.dart';
import 'package:toast/toast.dart';
import '../router/routerapply.dart';
// import '../http//path.dart';
class HomePageWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomePageWidgetState();
  }
}

class HomePageWidgetState extends State<HomePageWidget> {
  // 上拉加载
  bool isLoading = false;
  ScrollController scrollController = ScrollController();
  // 加载更多请求后返回数据存放数组
  bool absorb = true;
  // 轮播
  List arr;
  // 新品推荐
  List newList;
  // 热门
  List hotList;
  // 精华
  List bestList;
  // 全部商品
  List nine;
  // 加载请求页码
  int pageNum = 1;
  @override
  // 下拉刷新
  Future onRefresh() {
    return Future.delayed(Duration(seconds: 1), () {
      setState(() {
        pageNum = 1;
      });
      // 轮播
      getHttp();
      // 新品
      newHttp();
      // 热门
      hotHttp();
      // 精华
      bestHttp();
      // 全部商品
      nineHttp();

      // 给列表滚动添加监听
      this.scrollController.addListener(() {
        // 滑动到底部的关键判断
        if (!this.isLoading &&
            this.scrollController.position.pixels >=
                this.scrollController.position.maxScrollExtent) {
          // 开始加载数据
          setState(() {
            this.isLoading = true;
            this.loadMoreData();
          });
        }
      });
      Toast.show('当前已是最新数据', context);
    });
  }

  List nine2;
  void initState() {
    //页面初始化
    super.initState();
    // 轮播
    getHttp();
    // 新品
    newHttp();
    // 热门
    hotHttp();
    // 精华
    bestHttp();
    // 全部商品
    nineHttp();

    // 给列表滚动添加监听
    this.scrollController.addListener(() {
      // 滑动到底部的关键判断
      if (!this.isLoading &&
          this.scrollController.position.pixels >=
              this.scrollController.position.maxScrollExtent) {
        // 开始加载数据
        setState(() {
          this.isLoading = true;
          this.loadMoreData();
        });
      }
    });
  }

  //滚动触底事件
  Future loadMoreData() {
    return Future.delayed(Duration(seconds: 1), () {
      setState(() {
        this.isLoading = false;
        print('开始加载！！');
        // 触发pageNum++事件
        nineHttp2();
        // this.nine.addAll(newsList);
      });
    });
  }

  //发送加载更多请求
  Future nineHttp2() async {
    pageNum++;
    var da = {'page': '$pageNum'};
    // print(da);
    await request("homeHotList", "get", da).then((val) {
      //九宫格
      setState(() {
        nine2 = val['result'];
        nine.addAll(nine2);
      });
      print(val['result'].length);
      if (val['result'].length < 10) {
        setState(() {
          this.absorb = false;
        });
        renderBottom();
      } else {
        nine.forEach((item) =>
            {item['pic'] = item['pic'].replaceAll(new RegExp(r'\\'), '/')});
      }
    });
  }

  //占位组件
  Widget renderBottom() {
    if (this.isLoading) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '努力加载中...',
              style: TextStyle(
                fontSize: 15,
                color: Color(0xFF333333),
              ),
            ),
            Padding(padding: EdgeInsets.only(left: 10)),
            SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(strokeWidth: 3),
            ),
          ],
        ),
      );
    } else {
      if (absorb == false) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 15),
          alignment: Alignment.center,
          child: Text(
            '没有更多数据了',
            style: TextStyle(
              fontSize: 15,
              color: Color(0xFF333333),
            ),
          ),
        );
      } else {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 15),
          alignment: Alignment.center,
          child: Text(
            '上拉加载更多',
            style: TextStyle(
              fontSize: 15,
              color: Color(0xFF333333),
            ),
          ),
        );
      }
    }
  }

// 轮播接口
  Future getHttp() async {
    await request("homeBanner", "get", null).then((val) {
      setState(() {
        arr = val['result'];
      });
      arr.forEach((item) =>
          {item['pic'] = item['pic'].replaceAll(new RegExp(r'\\'), '/')});
    });
  }

// 新品推荐
  Future newHttp() async {
    var da = {'is_new': 1};
    // print(da);
    await request("homeHotList", "get", da).then((val) {
      print('开始新品');
      setState(() {
        newList = val['result'];
        // print(newList);
      });
      newList.forEach((item) =>
          {item['pic'] = item['pic'].replaceAll(new RegExp(r'\\'), '/')});
    });
  }

// 热门推荐
  Future hotHttp() async {
    var da = {'is_hot': 1};
    // print(da);
    await request("homeHotList", "get", da).then((val) {
      print('开始热门');
      setState(() {
        hotList = val['result'];
      });
      hotList.forEach((item) =>
          {item['pic'] = item['pic'].replaceAll(new RegExp(r'\\'), '/')});
    });
  }

  // 精华推荐
  Future bestHttp() async {
    var da = {'is_best': 1};
    // print(da);
    await request("homeHotList", "get", da).then((val) {
      print('开始热门');
      setState(() {
        bestList = val['result'];
        // print(bestList);
      });
      bestList.forEach((item) =>
          {item['pic'] = item['pic'].replaceAll(new RegExp(r'\\'), '/')});
    });
  }

  //页面初始化请求全部商品
  Future nineHttp() async {
    var da = {'page': '$pageNum'};
    // print(da);
    await request("homeHotList", "get", da).then((val) {
      print('开始');
      setState(() {
        nine = val['result'];
        // print(nine);
      });
      nine.forEach((item) =>
          {item['pic'] = item['pic'].replaceAll(new RegExp(r'\\'), '/')});
    });
  }

  //创建一个自定义组件   全部商品渲染
  Widget _hotList(BuildContext context) {
    // 定义新数组
    List<Widget> items = [];
    if (nine.length != 0) {
      // 循环遍历请求到的数组   添加到新数组
      nine.forEach((item) => {items.add(_hot(context, item))});
      // 返回一个组件   根据情况而定
      return Wrap(
        spacing: ScreenUtil().setWidth(2), //一行几个元素
        alignment: WrapAlignment.spaceBetween, //类似弹性盒子的space-between
        runSpacing: ScreenUtil().setHeight(6), //纵轴间距
        children: items, //关键点，留意233行
      );
    } else {
      return new Container(
        child: Text(
          '暂无数据',
          textAlign: TextAlign.center,
        ),
        padding: EdgeInsets.only(top: 5),
      );
    }
  }

  //214行 _hot就是这个 自定义组件   全部商品渲染
  Widget _hot(BuildContext context, items) {
    // 相当于 75行   children: items, 中的items    下面就是循环遍历    自己写样式  再看372-374
    return Container(
      child: Column(
        children: <Widget>[
          new Container(
            width: ScreenUtil().setWidth(368),
            height: ScreenUtil().setHeight(440),
            color: Colors.white,
            child: new Column(
              children: <Widget>[
                new Container(
                  child: Image.network(
                    'http://jd.itying.com/' + items['pic'],
                    width: ScreenUtil().setHeight(368),
                    height: ScreenUtil().setHeight(345),
                  ),
                ),
                new Container(
                  child: Text(
                    items['title'],
                    style: TextStyle(
                        color: Colors.red, fontSize: ScreenUtil().setSp(25)),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                new Container(
                  child: Row(
                    children: <Widget>[
                      new Container(
                          child: Text('￥${items['price']}',
                              style:
                                  TextStyle(fontSize: ScreenUtil().setSp(20)))),
                      new Container(
                          child: Text('￥${items['old_price']}',
                              style: TextStyle(
                                  fontSize: ScreenUtil().setSp(20),
                                  decoration: TextDecoration.lineThrough,
                                  color: Color(0xffcccccc)))),
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  //创建一个自定义组件   新品渲染
  Widget _newList(BuildContext context) {
    // 定义新数组
    List<Widget> items = [];
    if (newList.length != 0) {
      // 循环遍历请求到的数组   添加到新数组
      newList.forEach((item) => {items.add(_new(context, item))});
      // 返回一个组件   根据情况而定
      return Wrap(
        spacing: ScreenUtil().setWidth(2), //一行几个元素
        alignment: WrapAlignment.spaceBetween, //类似弹性盒子的space-between
        runSpacing: ScreenUtil().setHeight(6), //纵轴间距
        children: items, //关键点，留意312行
      );
    } else {
      return new Container(
        child: Text(
          '暂无数据',
          textAlign: TextAlign.center,
        ),
        padding: EdgeInsets.only(top: 5),
      );
    }
  }

  //292行 _new就是这个 自定义组件    新品渲染
  Widget _new(BuildContext context, items) {
    // 相当于 75行   children: items, 中的items    下面就是循环遍历    自己写样式  再看372-374
    return Container(
      child: Column(
        children: <Widget>[
          new Container(
            width: ScreenUtil().setWidth(368),
            height: ScreenUtil().setHeight(440),
            color: Colors.white,
            child: new Column(
              children: <Widget>[
                new Container(
                  child: Image.network(
                    'http://jd.itying.com/' + items['pic'],
                    width: ScreenUtil().setHeight(368),
                    height: ScreenUtil().setHeight(345),
                  ),
                ),
                new Container(
                  child: Text(
                    items['title'],
                    style: TextStyle(
                        color: Colors.red, fontSize: ScreenUtil().setSp(25)),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                new Container(
                  child: Row(
                    children: <Widget>[
                      new Container(
                          child: Text('￥${items['price']}',
                              style:
                                  TextStyle(fontSize: ScreenUtil().setSp(20)))),
                      new Container(
                          child: Text('￥${items['old_price']}',
                              style: TextStyle(
                                  fontSize: ScreenUtil().setSp(20),
                                  decoration: TextDecoration.lineThrough,
                                  color: Color(0xffcccccc)))),
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

//创建一个自定义组件   热门渲染
  Widget _HotList(BuildContext context) {
    // 定义新数组
    List<Widget> items = [];
    if (hotList.length != 0) {
      // 循环遍历请求到的数组   添加到新数组
      hotList.forEach((item) => {items.add(_new(context, item))});
      // 返回一个组件   根据情况而定
      return Wrap(
        spacing: ScreenUtil().setWidth(2), //一行几个元素
        alignment: WrapAlignment.spaceBetween, //类似弹性盒子的space-between
        runSpacing: ScreenUtil().setHeight(6), //纵轴间距
        children: items, //关键点，留意79行
      );
    } else {
      return new Container(
        child: Text(
          '暂无数据',
          textAlign: TextAlign.center,
        ),
        padding: EdgeInsets.only(top: 5),
      );
    }
  }

  //370行 _new就是这个 自定义组件    热门渲染
  Widget _Hot(BuildContext context, items) {
    // 相当于 75行   children: items, 中的items    下面就是循环遍历    自己写样式  再看372-374
    return Container(
      child: Column(
        children: <Widget>[
          new Container(
            width: ScreenUtil().setWidth(368),
            height: ScreenUtil().setHeight(440),
            color: Colors.white,
            child: new Column(
              children: <Widget>[
                new Container(
                  child: Image.network(
                    'http://jd.itying.com/' + items['pic'],
                    width: ScreenUtil().setHeight(368),
                    height: ScreenUtil().setHeight(345),
                  ),
                ),
                new Container(
                  child: Text(
                    items['title'],
                    style: TextStyle(
                        color: Colors.red, fontSize: ScreenUtil().setSp(25)),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                new Container(
                  child: Row(
                    children: <Widget>[
                      new Container(
                          child: Text('￥${items['price']}',
                              style:
                                  TextStyle(fontSize: ScreenUtil().setSp(20)))),
                      new Container(
                          child: Text('￥${items['old_price']}',
                              style: TextStyle(
                                  fontSize: ScreenUtil().setSp(20),
                                  decoration: TextDecoration.lineThrough,
                                  color: Color(0xffcccccc)))),
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  //创建一个自定义组件   热门渲染
  Widget _BestList(BuildContext context) {
    // 定义新数组
    List<Widget> items = [];
    if (bestList.length != 0) {
      // 循环遍历请求到的数组   添加到新数组
      bestList.forEach((item) => {items.add(_best(context, item))});
      // 返回一个组件   根据情况而定
      return Wrap(
        spacing: ScreenUtil().setWidth(2), //一行几个元素
        alignment: WrapAlignment.spaceBetween, //类似弹性盒子的space-between
        runSpacing: ScreenUtil().setHeight(6), //纵轴间距
        children: items, //关键点，留意79行
      );
    } else {
      return new Container(
        child: Text(
          '暂无数据',
          textAlign: TextAlign.center,
        ),
        padding: EdgeInsets.only(top: 5),
      );
    }
  }

  //370行 _new就是这个 自定义组件    热门渲染
  Widget _best(BuildContext context, items) {
    // 相当于 75行   children: items, 中的items    下面就是循环遍历    自己写样式  再看372-374
    return Container(
      child: InkWell(
        onTap: () {
          print(items['_id']);
          Routerapply.router.navigateTo(context, '/details?id=${items['_id']}');
        },
        child: Column(
          children: <Widget>[
            new Container(
              width: ScreenUtil().setWidth(368),
              height: ScreenUtil().setHeight(440),
              color: Colors.white,
              child: new Column(
                children: <Widget>[
                  new Container(
                    child: Image.network(
                      'http://jd.itying.com/' + items['pic'],
                      width: ScreenUtil().setHeight(368),
                      height: ScreenUtil().setHeight(345),
                    ),
                  ),
                  new Container(
                    child: Text(
                      items['title'],
                      style: TextStyle(
                          color: Colors.red, fontSize: ScreenUtil().setSp(25)),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  new Container(
                    child: Row(
                      children: <Widget>[
                        new Container(
                            child: Text('￥${items['price']}',
                                style: TextStyle(
                                    fontSize: ScreenUtil().setSp(20)))),
                        new Container(
                            child: Text('￥${items['old_price']}',
                                style: TextStyle(
                                    fontSize: ScreenUtil().setSp(20),
                                    decoration: TextDecoration.lineThrough,
                                    color: Color(0xffcccccc)))),
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //  if判断  如果图片未加载，那么显示正在加载
  @override
  Widget build(BuildContext context) {
    //  if判断  如果图片未加载，那么显示正在加载

    return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.people),
          centerTitle: true,
          title: Text('百姓生活+'),
          backgroundColor: Color(0xffe62565),
        ),
        // 下拉刷新
        // onRefresh: this.onRefresh,
        // RefreshIndicator
        body: RefreshIndicator(
            onRefresh: this.onRefresh,
            child: ListView(
                // 上拉加载
                controller: this.scrollController,

                // mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new Container(
                    child: new Swiper(
                      //轮播
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          child: Image.network(
                            'http://jd.itying.com/${arr[index]['pic']}',
                            fit: BoxFit.fill,
                          ),
                          width: ScreenUtil().setWidth(750),
                          height: ScreenUtil().setHeight(356),
                        );
                      },
                      itemCount: 3,
                      autoplay: true,
                      loop: true,
                      pagination: new SwiperPagination(
                          builder: DotSwiperPaginationBuilder(
                        color: Colors.white,
                        activeColor: Color(0xffe62565),
                      )),
                    ),
                    width: double.infinity,
                    height: 160,
                  ),
                  new Container(
                    //九宫格
                    width: ScreenUtil().setWidth(750),
                    height: ScreenUtil().setHeight(260),
                    padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(36), 0,
                        ScreenUtil().setWidth(36), 0),
                    margin: EdgeInsets.fromLTRB(
                      0,
                      ScreenUtil().setWidth(16),
                      0,
                      ScreenUtil().setWidth(40),
                    ),
                    child: Wrap(
                      spacing: ScreenUtil().setWidth(55), //横向间距
                      runSpacing: ScreenUtil().setHeight(18), //纵向间距
                      runAlignment: WrapAlignment.start, //纵向排列方式
                      children: <Widget>[
                        Mynine('images/life_07.jpg', '白酒'),
                        Mynine('images/life_09.jpg', '啤酒'),
                        Mynine('images/life_11.jpg', '葡萄酒'),
                        Mynine('images/life_13.jpg', '清酒洋酒'),
                        Mynine('images/life_15.jpg', '保健酒'),
                        Mynine('images/life_22.jpg', '预调酒'),
                        Mynine('images/life_23.jpg', '下菜小酒'),
                        Mynine('images/life_24.jpg', '饮料'),
                        Mynine('images/life_25.jpg', '乳制品'),
                        Mynine('images/life_26.jpg', '休闲零食')
                      ],
                    ),
                  ),
                  new Container(
                    child: Image.asset('images/life_32.jpg'),
                    width: ScreenUtil().setWidth(750),
                    height: ScreenUtil().setHeight(90),
                  ),
                  // 新品专区
                  new Container(
                    child: Text(
                      '新品专区',
                      textAlign: TextAlign.center,
                    ),
                    padding: EdgeInsets.only(top: ScreenUtil().setHeight(5)),
                    margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(10)),
                  ),
                  new Container(
                    child: _newList(context),
                  ),
                  // 热门专区
                  new Container(
                    child: Text(
                      '热门专区',
                      textAlign: TextAlign.center,
                    ),
                    padding: EdgeInsets.only(top: ScreenUtil().setHeight(40)),
                    margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(20)),
                  ),
                  new Container(
                    child: _HotList(context),
                  ),
                  // 精华专区
                  new Container(
                    child: Text(
                      '精华专区',
                      textAlign: TextAlign.center,
                    ),
                    padding: EdgeInsets.only(top: ScreenUtil().setHeight(40)),
                    margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(20)),
                  ),
                  new Container(
                    child: _BestList(context),
                  ),
                  // 全部商品
                  new Container(
                    child: Text(
                      '全部商品',
                      textAlign: TextAlign.center,
                    ),
                    padding: EdgeInsets.only(top: ScreenUtil().setHeight(40)),
                    margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(20)),
                  ),
                  new Container(
                    child: _hotList(
                        context), //创建的自定义组件   拿来这里进行渲染 要带参数context    语法就这样
                  ),
                  renderBottom(),
                ])));
  }
}

// 自定义组件
class Mynine extends StatelessWidget {
  // const Mynine({Key key}) : super(key: key);
  String imgUrl;
  String title;
  Mynine(this.imgUrl, this.title);
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: Column(
        children: <Widget>[
          new Container(
            child: Image.asset(
              this.imgUrl,
              fit: BoxFit.cover,
              width: ScreenUtil().setWidth(84),
              height: ScreenUtil().setHeight(84),
            ),
            margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(4)),
          ),
          new Container(
            child: Text(
              '${this.title}',
              style: TextStyle(fontSize: ScreenUtil().setSp(20)),
            ),
          )
        ],
      ),
      width: ScreenUtil().setWidth(90),
      height: ScreenUtil().setHeight(120),
    );
  }
}
