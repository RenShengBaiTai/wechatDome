import 'package:flutter/material.dart';
import 'package:we_chat/common/const.dart';

class SearchBar extends StatefulWidget {

  final ValueChanged<String> onChange;

  const SearchBar({Key key, this.onChange}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final TextEditingController _textEditingController = TextEditingController();
  bool _showClear = false;

  _onChange(String text) {
    if (text.length > 0) {
      setState(() {
        _showClear = true;
      });
    } else {
      setState(() {
        _showClear = false;
      });
    }
    widget.onChange(text);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 84,
      color: WeChatThemColor,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 40,
          ), //头部
          Container(
            height: 44,
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1, //权重
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                    ),
                    margin: EdgeInsets.only(left: 10, right: 10, bottom: 4),
                    child: Row(
                      children: <Widget>[
                        SizedBox(width: 5),
                        Image(
                          image: AssetImage('images/放大镜b.png'),
                          width: 18,
                          color: WeChatThemColor,
                        ),
                        Expanded(
                          flex: 1,
                          child: TextField(
                            controller: _textEditingController,
                            onChanged: _onChange,
                            cursorColor: Colors.green,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(left: 5),
                              hintText: '搜索',
                            ),
                          ),
                        ),
                        _showClear
                            ? GestureDetector(
                          onTap: () {
                            _textEditingController.clear();
                            _onChange('');
                          },
                          child: Icon(
                            Icons.cancel,
                            color: Colors.grey,
                          ),
                        )
                            : Container()
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: EdgeInsets.only(right: 10),
                      child: Text(
                        '取消',
                        style: TextStyle(fontSize: 18),
                      ),
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}