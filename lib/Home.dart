import 'dart:convert';
import 'package:employment/Card.dart';
import 'package:employment/Chart.dart';
import 'package:employment/Person.dart';
import 'package:employment/searchbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        height: 1000,
        child: Stack(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: 500,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4.0),
                    topRight: Radius.circular(4.0),
                  )),
              child: Padding(
                padding: const EdgeInsets.only(
                    bottom: 100.0, right: 8, left: 8, top: 20),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          height: 80,
                          width: 130,
//                      color: Colors.blue,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "欢迎回来",
                                style: TextStyle(
                                    fontSize: 28, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "王老师",
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right: 16.0),
                              child: Container(
                                child: IconButton(
                                    icon: Icon(Icons.person),
                                    onPressed: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => Pearson(),
                                        ),
                                      );
                                    }),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30.0),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey,
                                          offset: Offset(0, 5),
                                          blurRadius: 20)
                                    ]),
                              ),
                            ),
                            Container(
                              child: IconButton(
                                  icon: Icon(Icons.search),
                                  onPressed: () {
                                    showSearch(
                                        context: context,
                                        delegate: SearchBarView());
                                  }),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30.0),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(0, 5),
                                        blurRadius: 20)
                                  ]),
                            )
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 0, top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            height: 50,
                            width: 200,
                            child: Align(
                              alignment: Alignment.bottomLeft,
                              child: (
                                  Text("本数据于 2019 年 9 月更新")
                              ),
                            ),
                          ),
                          Container(
                            width: 100,
                            height: 50,
                            child: Center(
                                child: Text(
                              "软件工程",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            )),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey,
                                      offset: Offset(0, 5),
                                      blurRadius: 10)
                                ]),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: 200,
              child: Container(
                height: 900,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0, -1),
                          blurRadius: 10)
                    ]),
                child: Padding(
                  padding: const EdgeInsets.only(top: 16.0, left: 8, right: 8),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                        child: Column(
                      children: <Widget>[
                        Container(height: 200, child: DoubleLineChart()),
                        BarCard(category: "就业"),
                        BarCard(category: "考研")
                      ],
                    )),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoList extends StatefulWidget {
  String keyword;

  InfoList({Key key, this.keyword}) : super(key: key);

  _InfoListState createState() => _InfoListState();
}

/////////////////////获取数据保存状态/////////////////////////////
class _InfoListState extends State<InfoList>
    with AutomaticKeepAliveClientMixin {
  List infoList = [];

  getData() async {
    Dio dio = new Dio();

    Response res = await dio.get(
        'https://c.y.qq.com/splcloud/fcgi-bin/gethotkey.fcg?g_tk=5381&uin=0&notice=0&platform=h5&needNewCode=1&_=1513317614040');
    print('key');
    var hotkey = json.decode(res.data)['data']['hotkey'];
    setState(() {
      infoList = hotkey;
    });
  }

////页面保持状态
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.getData();
  }

//////////////////////搜索栏Listview搭建//////////////////////////
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container();
  }
///////////////////////////点击弹出//////////////////////////////

}
