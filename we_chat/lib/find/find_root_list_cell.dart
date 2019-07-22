import 'package:flutter/material.dart';

import 'find_child.dart';

class FindRootListCell extends StatefulWidget {
  final String title;
  final String imgName;
  final String subTitle;
  final String subImgName;

  const FindRootListCell(
    this.title,
    this.imgName, {
    Key key,
    this.subTitle,
    this.subImgName,
  }) : super(key: key);

  @override
  _FindRootListCellState createState() => _FindRootListCellState();
}

class _FindRootListCellState extends State<FindRootListCell> {
  Color _backColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) {
            return FindChild(title: widget.title);
          }),
        );
        _backColor = Colors.white;
        setState(() {
        });
      },

      onTapDown: (onTapDown){
        _backColor = Colors.grey;
        setState(() {
        });
      },

      onTapCancel: (){
        _backColor = Colors.white;
        setState(() {
        });
      },
      child: Container(
        color: _backColor,
        height: 54,
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
                child: Row(
              children: <Widget>[
                Image(
                  image: AssetImage('images/' + widget.imgName),
                  width: 20,
                  height: 20,
                ),
                SizedBox(width: 15),
                Text(widget.title),
              ],
            )),
            Container(
              child: Row(
                children: <Widget>[
                  Text(
                    widget.subTitle != null ? widget.subTitle : '',
                    style: TextStyle(color: Colors.grey),
                  ),
                  widget.subImgName != null
                      ? Container(
                          child: Image(
                            image: AssetImage('images/' + widget.subImgName),
                            width: 15,
                          ),
                          margin: EdgeInsets.only(left: 10, right: 10),
                        )
                      : Container(),
                  Image(
                    image: AssetImage('images/icon_right.png'),
                    width: 15,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
