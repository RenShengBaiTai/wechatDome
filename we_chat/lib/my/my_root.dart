import 'package:flutter/material.dart';
import 'package:we_chat/find/find_root_list_cell.dart';
import 'package:we_chat/find/find_root_list_model.dart';

class MyRoot extends StatefulWidget {
  @override
  _MyRootState createState() => _MyRootState();
}

class _MyRootState extends State<MyRoot> {
  Widget TopView() {
    return Container(
      height: 200,
      color: Colors.white,
      child: Container(
        margin: EdgeInsets.only(top: 100),
        child: Container(
          margin: EdgeInsets.only(left: 20),
          padding: EdgeInsets.all(5),
          child: Row(
            children: <Widget>[
              Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: AssetImage('images/Hank.png'), fit: BoxFit.cover),
                ),
              ),
              Container(
                  child: Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        height: 35,
                        child: Text(
                          'name',
                          style: TextStyle(
                              fontSize: 25)
                        ),
                      ),
                      Container(
                        height: 35,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text('微信号：kdkdkdkd'),
                            Image(
                              image: AssetImage('images/icon_right.png'),
                              width: 15,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _listViewCells = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    List<FindRootListModel> _listData = [
      FindRootListModel(isFrist: true, title: '支付', imgName: '微信支付.png'),
      FindRootListModel(isFrist: true, title: '收藏', imgName: '微信收藏.png'),
      FindRootListModel(title: '相册', imgName: '微信相册.png'),
      FindRootListModel(title: '卡包', imgName: '微信卡包.png'),
      FindRootListModel(title: '表情', imgName: '微信表情.png'),
      FindRootListModel(isFrist: true, title: '设置', imgName: '微信设置.png'),
    ];

    for (int i = 0; i < _listData.length; i++) {
      if (_listData[i].isFrist) {
        _listViewCells.add(SizedBox(height: 10));
      }
      _listViewCells.add(FindRootListCell(
          _listData[i].title, _listData[i].imgName,
          subTitle: _listData[i].subTitle,
          subImgName: _listData[i].subImgName));
    }

    _listViewCells.insert(0, TopView());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
              color: Colors.grey,
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: ListView(
                  children: _listViewCells,
                ),
              )), //listView
          Container(
            margin: EdgeInsets.only(top: 44, right: 10),
            height: 44,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    print('我要发朋友圈！！！！！');
                  },
                  child: Image(
                    image: AssetImage('images/相机.png'),
                    width: 30,
                    height: 30,
                  ),
                ),
              ],
            ),
          ), //相机
        ],
      ),
    ));
  }
}
