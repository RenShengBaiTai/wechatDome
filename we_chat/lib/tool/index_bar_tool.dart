import 'package:flutter/material.dart';
import 'package:we_chat/common/const.dart';

class indexBarTool extends StatefulWidget {
  final void Function(String str) indexBarCallBack;

  const indexBarTool({Key key, this.indexBarCallBack}) : super(key: key);

  @override
  _indexBarToolState createState() => _indexBarToolState();
}

class _indexBarToolState extends State<indexBarTool> {
  Color _bgColor = Color.fromRGBO(0, 0, 0, 0.0);
  Color _textColor = Colors.black;

  //保存上次返回的数据，处理重复数据
  var _oldIndex = -1;

  //气泡
  //气泡偏移位置
  double _y = -1.1;

  //气泡显示内容
  String _indexStr = 'A';

  //气泡是否显示
  bool _isShow = false;

  int _getIndex(Offset offset) {
    //坐标转换
    RenderBox box = context.findRenderObject();
    double y = box.globalToLocal(offset).dy;
    //获得每一个text的高度
    double indexHeight = ScreenHeight(context) / 2 / INDEX_WORDS.length;
    //获取当前点击的是哪一个text
    // "~/" 整除
    return (y ~/ indexHeight).clamp(0, INDEX_WORDS.length - 1);
  }

  @override
  Widget build(BuildContext context) {
    //列表数据
    List<Widget> _widgetList = [];
    for (int i = 0; i < INDEX_WORDS.length; i++) {
      _widgetList.add(Expanded(
          child: Text(
        INDEX_WORDS[i],
        style: TextStyle(fontSize: 10, color: _textColor),
      )));
    }

    return Positioned(
      height: ScreenHeight(context) / 2,
      width: 120,
      child: Row(
        children: <Widget>[
          Container(
            alignment: Alignment(0, _y),
            width: 100,
            child: _isShow
                ? Stack(alignment: Alignment(-0.3, 0), children: <Widget>[
                    Image(image: AssetImage('images/气泡.png'), width: 60),
                    Text(_indexStr,
                        style: TextStyle(color: Colors.white, fontSize: 35))
                  ])
                : Container(),
          ),
          GestureDetector(
              onVerticalDragDown: (DragDownDetails details) {
                int index = this._getIndex(details.globalPosition);
                if (index != _oldIndex) {
                  _oldIndex = index;
                  widget.indexBarCallBack(INDEX_WORDS[index]);
                }
                _bgColor = Color.fromRGBO(0, 0, 0, 0.3);
                _textColor = Colors.white;
                _indexStr = INDEX_WORDS[index];
                _isShow = true;
                _y = 2.2 / (INDEX_WORDS.length -1) * index- 1.1;
                setState(() {});
              },
              onVerticalDragEnd: (DragEndDetails details) {
                setState(() {
                  _bgColor = Color.fromRGBO(0, 0, 0, 0.0);
                  _textColor = Colors.black;
                  _isShow = false;
                  setState(() {});
                });
              },
              onVerticalDragUpdate: (DragUpdateDetails details) {
                int index = this._getIndex(details.globalPosition);
                if (index != _oldIndex) {
                  _oldIndex = index;
                  _indexStr = INDEX_WORDS[index];
                  _isShow = true;
                  _y = 2.2 / (INDEX_WORDS.length -1) * index- 1.1;
                  setState(() {});
                  widget.indexBarCallBack(INDEX_WORDS[index]);
                }
              },
              child: Container(
                width: 20,
                color: _bgColor,
                child: Column(children: _widgetList),
              )),
        ],
      ),
    );
  }
}

const INDEX_WORDS = [
  '🔍',
  '☆',
  'A',
  'B',
  'C',
  'D',
  'E',
  'F',
  'G',
  'H',
  'I',
  'J',
  'K',
  'L',
  'M',
  'N',
  'O',
  'P',
  'Q',
  'R',
  'S',
  'T',
  'U',
  'V',
  'W',
  'X',
  'Y',
  'Z'
];
