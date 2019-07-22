import 'package:flutter/material.dart';

import 'find_root_list_cell.dart';
import 'find_root_list_model.dart';

class FindRoot extends StatefulWidget {
  @override
  _FindRootState createState() => _FindRootState();
}

class _FindRootState extends State<FindRoot> {

  Color _themColor = Color.fromRGBO(220, 220, 220, 1.0);
  List<Widget> _listViewCells = [];

  void initState() {
    super.initState();

    List<FindRootListModel> _listData = [
      FindRootListModel(isFrist: true, title: '朋友圈', imgName: '朋友圈.png'),
      FindRootListModel(title: '扫一扫', imgName: '扫一扫2.png'),
      FindRootListModel(title: '摇一摇', imgName: '摇一摇.png'),
      FindRootListModel(isFrist: true, title: '看一看', imgName: '看一看icon.png'),
      FindRootListModel(title: '搜一搜', imgName: '搜一搜 2.png'),
      FindRootListModel(isFrist: true, title: '附近的人', imgName: '附近的人icon.png'),
      FindRootListModel(isFrist: true, title: '购物', imgName: '购物.png',
          subTitle: '618 限时特惠',subImgName:'badge.png'),
      FindRootListModel(title: '游戏', imgName: '游戏.png'),
      FindRootListModel(isFrist: true, title: '小程序', imgName: '小程序.png'),
    ];

    for (int i = 0; i < _listData.length; i++) {

      if(_listData[i].isFrist){

        _listViewCells.add(SizedBox(height: 10));
      }
      _listViewCells.add(FindRootListCell(_listData[i].title, _listData[i].imgName,
          subTitle:_listData[i].subTitle,
          subImgName:_listData[i].subImgName));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: _themColor,
          //安卓控制导航文字居中
          centerTitle: true,
          //导航条分割线
          elevation: 0.0,
          title: Text('发现'),
        ),
        body: Container(
          color: _themColor,
          height: 800,
          child: ListView(
            children: _listViewCells,
          ), //
        ),
      ),
    );
  }
}
