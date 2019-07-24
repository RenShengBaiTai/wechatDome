import 'package:flutter/material.dart';
import 'package:we_chat/tool/search_bar.dart';

import 'home_model.dart';

class HomeFind extends StatefulWidget {
  final List<HomeModel> datas;

  const HomeFind({Key key, this.datas}) : super(key: key);

  @override
  _HomeFindState createState() => _HomeFindState();
}

class _HomeFindState extends State<HomeFind> {
  List<HomeModel> _modals = [];
  String _searchStr = '';

  void _serachData(String text) {
    if (text.length == 0) {
      setState(() {
        _modals = [];
      });
    } else {
      _modals.clear();
      for (int i = 0; i < widget.datas.length; i++) {
        if (widget.datas[i].name.contains(text)) {
          _modals.add(widget.datas[i]);
        }
      }
    }
    _searchStr = text;
    setState(() {});
  }

  _title(String name) {
    TextStyle normalStyle = TextStyle(fontSize: 16, color: Colors.black);
    TextStyle highlighStyle = TextStyle(fontSize: 16, color: Colors.green);
    List<TextSpan> spans = [];

    List<String> strs = name.split(_searchStr);
    for (int i = 0; i < strs.length; i++) {
      String str = strs[i];
      if (str == '' && i < strs.length - 1) {
        spans.add(TextSpan(text: _searchStr, style: highlighStyle));
      } else {
        spans.add(TextSpan(text: str, style: normalStyle));
        if (i < strs.length - 1) {
          spans.add(TextSpan(text: _searchStr, style: highlighStyle));
        }
      }
    }
    return RichText(text: TextSpan(children: spans));
  }

  Widget _itemForRow(BuildContext context, int index) {
    return ListTile(
      title: _title(_modals[index].name),
      subtitle: Text(
        _modals[index].msg,
        overflow: TextOverflow.ellipsis,
      ),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(_modals[index].imgUrl),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SearchBar(
            onChange: (String str) {
              _serachData(str);
            },
          ),
          Expanded(
            flex: 1, //权重
            child: MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: NotificationListener(
                  onNotification: (ScrollNotification noti) {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  child: ListView.builder(
                    itemCount: _modals.length,
                    itemBuilder: _itemForRow,
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
