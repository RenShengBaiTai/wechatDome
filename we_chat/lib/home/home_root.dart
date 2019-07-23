import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:we_chat/common/const.dart';
import 'package:http/http.dart' as http;

import 'home_find.dart';
import 'home_model.dart';

class HomeRoot extends StatefulWidget {
  @override
  _HomeRootState createState() => _HomeRootState();
}

//创建item方法
PopupMenuItem<String> _buildItme(String imgAss, String name) {
  return PopupMenuItem(
    child: Row(
      children: <Widget>[
        Image(
          image: AssetImage(imgAss),
          width: 20,
        ),
        SizedBox(width: 20),
        Text(
          name,
          style: TextStyle(color: Colors.white),
        ),
      ],
    ),
  );
}

//回调
List<PopupMenuItem<String>> _buildPopupMenuItem(BuildContext context) {
  return <PopupMenuItem<String>>[
    _buildItme('images/发起群聊.png', '发起群聊'),
    _buildItme('images/添加朋友.png', '添加朋友'),
    _buildItme('images/扫一扫 (1).png', '扫一扫'),
    _buildItme('images/收付款.png', '收付款'),
  ];
}

//with 混入
//AutomaticKeepAliveClientMixin 这个类可以保存状态，不希望每次打开页面重新请求网络，
//步骤：
//1.with AutomaticKeepAliveClientMixin<T>
//2.重写wantKeepAlive => true;
//3.调用super.build(context);
class _HomeRootState extends State<HomeRoot>
    with AutomaticKeepAliveClientMixin<HomeRoot> {
  List<HomeModel> _datas = [];

  //控制是否超时
  bool _cancelConnect = false;

  //是否保存状态
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    //也可以try cache
    _getDatas()
        .then((datas) {
          if (!_cancelConnect) {
            setState(() {
              _datas = datas;
            });
          }
        })
        .catchError((error) {
          print(error);
        })
        .whenComplete(() {
          print('完毕！');
        })
        .timeout(Duration(seconds: 10))
        .catchError((error) {
          print('超时！');
          _cancelConnect = true;
        });
  }

  //获取数据
  Future<List<HomeModel>> _getDatas() async {
    _cancelConnect = false;
    final response = await http
        .get('http://rap2api.taobao.org/app/mock/225547/api/chat/list');
    if (response.statusCode == 200) {
      final _responseBody = json.decode(response.body);
      List _list = _responseBody['list'];
      List<HomeModel> _homeList =
          _list.map((item) => HomeModel.fromJson(item)).toList();
      return _homeList;
    } else {
      throw Exception('statusCode:${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: WeChatThemColor,
          title: Text('微信'),
          centerTitle: true,
          actions: <Widget>[
            Container(
              padding: EdgeInsets.only(right: 10),
              child: PopupMenuButton(
                offset: Offset(0, 60),
                child: Image(
                  image: AssetImage('images/圆加.png'),
                  width: 25,
                  color: Colors.white,
                ),
                itemBuilder: _buildPopupMenuItem, //需要一个回调，不是调用一个方法
              ),
            ),
          ],
        ),
        body: _getBodyView(_datas),
      ),
    );
  }
}

Widget _getBodyView(List<HomeModel> _datas) {
  if (_datas.length == 0) {
    //没有数据加载loading 页面
    return Center(child: Text('loading...'));
  } else {
    return ListView.builder(
      //在头部多加一个搜索功能的view
      itemCount: _datas.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          //搜索条
          return Container(
            height: 50,
            color: WeChatThemColor,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) {
                    return HomeFind();
                  }),
                );
              },
              child: Container(
                margin: EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image(
                      image: AssetImage('images/放大镜b.png'),
                      width: 18,
                      color: WeChatThemColor,
                    ),
                    SizedBox(width: 5),
                    Text(
                      '搜索',
                      style: TextStyle(color: WeChatThemColor, fontSize: 15),
                    )
                  ],
                ),
              ),
            ),
          );
        } else {
          //cell
          return ListTile(
            title: Text(_datas[index - 1].name),
            subtitle: Text(
              _datas[index - 1].msg,
              overflow: TextOverflow.ellipsis,
            ),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(_datas[index - 1].imgUrl),
            ),
          );
        }
      },
    );
  }
}
