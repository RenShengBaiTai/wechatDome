import 'package:flutter/material.dart';
import 'package:we_chat/common/const.dart';
import 'home_find.dart';
import 'home_model.dart';

class HomeFindCell extends StatelessWidget {

  final List<HomeModel> datas;

  const HomeFindCell({Key key, this.datas}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: WeChatThemColor,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (BuildContext context) => HomeFind(datas:datas)
            ),
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
  }
}
