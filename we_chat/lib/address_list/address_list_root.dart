import 'package:flutter/material.dart';
import 'package:we_chat/common/const.dart';
import 'package:we_chat/tool/index_bar_tool.dart';

import 'address_list_model.dart';

class AddressListRoot extends StatefulWidget {
  @override
  _AddressListRootState createState() => _AddressListRootState();
}

class _AddressListRootState extends State<AddressListRoot> {
  //列表数据
  final List<AddressListModel> _listDatas = [];
  ScrollController _scrollController;

  //保存滚动的位置
  final Map _groupMap = {
    INDEX_WORDS[0]: 0.0,
    INDEX_WORDS[1]: 0.0,
  };

  //记录滚动位置
  double _groupOffset = 54.0 * 4;

  @override
  void initState() {
    super.initState();

    _listDatas..addAll(datas)..addAll(datas);
    _listDatas.sort((AddressListModel a, AddressListModel b) {
      return a.indexLetter.compareTo(b.indexLetter);
    });

    for (int i = 0; i < _listDatas.length; i++) {
      //第一个一定是头
      if (i == 0) {
        _groupMap.addAll({_listDatas[i].indexLetter: _groupOffset});
        _groupOffset += 84; //头+cell的高度
      } else if (_listDatas[i].indexLetter == _listDatas[i - 1].indexLetter) {
        //没有头
        _groupOffset += 54;
      } else {
        //有头的
        _groupMap.addAll({_listDatas[i].indexLetter: _groupOffset});
        _groupOffset += 84;
      }
    }

    _scrollController = ScrollController();
  }

  final List<AddressListModel> _headerData = [
    AddressListModel(
      imgUrl: 'images/新的朋友.png',
      name: '新的朋友',
    ),
    AddressListModel(
      imgUrl: 'images/群聊.png',
      name: '群聊',
    ),
    AddressListModel(
      imgUrl: 'images/标签.png',
      name: '标签',
    ),
    AddressListModel(
      imgUrl: 'images/公众号.png',
      name: '公众号',
    )
  ];

  Widget _itemForRow(BuildContext context, int index) {
    if (index < _headerData.length) {
      return _AddressListCell(
        assetImage: _headerData[index].imgUrl,
        name: _headerData[index].name,
      );
    }

    //只有租的第一个显示indexLetter
    if (index > 4 &&
        (_listDatas[index - 4].indexLetter ==
            _listDatas[index - 5].indexLetter)) {
      return _AddressListCell(
        imgUrl: _listDatas[index - 4].imgUrl,
        name: _listDatas[index - 4].name,
      );
    }

    return _AddressListCell(
      imgUrl: _listDatas[index - 4].imgUrl,
      name: _listDatas[index - 4].name,
      groupTitle: _listDatas[index - 4].indexLetter,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('通讯录'),
          backgroundColor: WeChatThemColor,
          actions: <Widget>[
            GestureDetector(
              onTap: () {
                print('我要添加联系人');
              },
              child: Container(
                margin: EdgeInsets.only(right: 20),
                child: Image(
                  image: AssetImage('images/icon_friends_add.png'),
                  width: 25,
                ),
              ),
            )
          ],
        ),
        body: Stack(
          alignment: Alignment(1, 0),
          children: <Widget>[
            Container(
              color: Colors.white,
              child: ListView.builder(
                controller: _scrollController,
                itemCount: _listDatas.length + _headerData.length,
                itemBuilder: _itemForRow,
              ),
            ),
            indexBarTool(
              indexBarCallBack: (String str) {
                if (_groupMap[str] != null &&
                    _groupMap[str] <=
                        _scrollController.position.maxScrollExtent) {
                  _scrollController.animateTo(
                    _groupMap[str],
                    duration: Duration(milliseconds: 10),
                    curve: Curves.easeIn,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _AddressListCell extends StatelessWidget {
  final String imgUrl;
  final String name;
  final String groupTitle;
  final String assetImage;

  _AddressListCell({this.imgUrl, this.name, this.groupTitle, this.assetImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          groupTitle == null
              ? Container()
              : Container(
                  width: ScreenWidth(context),
                  padding: EdgeInsets.only(left: 15, top: 8),
                  height: 30,
                  color: Colors.grey,
                  child: Text(groupTitle),
                ),
          Container(
              child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(10),
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6.0),
                    image: DecorationImage(
                      image: imgUrl != null
                          ? NetworkImage(imgUrl)
                          : AssetImage(assetImage),
                    )),
              ),
              Container(
                child: Text(
                  name,
                  style: TextStyle(fontSize: 18),
                ),
              )
            ],
          )),
          Container(
            margin: EdgeInsets.only(left: 54),
            height: 0.5,
            color: WeChatThemColor,
          )
        ],
      ),
    );
  }
}
