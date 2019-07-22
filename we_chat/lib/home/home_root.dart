import 'package:flutter/material.dart';
import 'package:we_chat/common/const.dart';

class HomeRoot extends StatefulWidget {
  @override
  _HomeRootState createState() => _HomeRootState();
}

//创建item方法
PopupMenuItem<String> _buildItme(String imgAss, String name) {
  return PopupMenuItem(
    child: Row(
      children: <Widget>[
        Image(image: AssetImage(imgAss),width: 20,),
        SizedBox(width: 20),
        Text(name,style: TextStyle(color: Colors.white),),
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
        body: Container(
          child: Text('weixing'),
        ),
      ),
    );
  }
}
