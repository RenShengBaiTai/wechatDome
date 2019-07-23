import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:we_chat/common/const.dart';
import 'package:http/http.dart' as http;

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

class _HomeRootState extends State<HomeRoot> {
  List<HomeModel> _datas = [];
  //控制是否超时
  bool _cancelConnect = false;

  @override
  void initState() {
    super.initState();

    //也可以try cache
    _getDatas().then((datas) {

      if(!_cancelConnect){

        setState(() {
          _datas = datas;
        });
      }
    }).catchError((error) {
      print(error);
    }).whenComplete(() {
      print('完毕！');
    }).timeout(Duration(seconds: 10)).catchError((error) {
      print('超时！');
      _cancelConnect = true;
    });
  }

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
          body: _datas.length == 0
              ? Center(
            child: Text('loading...'),
          )
              : ListView.builder(
            itemCount: _datas.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(_datas[index].name),
                subtitle: Text(
                  _datas[index].msg,
                  overflow: TextOverflow.ellipsis,
                ),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(_datas[index].imgUrl),
                ),
              );
            },
          )),
    );
  }
}
