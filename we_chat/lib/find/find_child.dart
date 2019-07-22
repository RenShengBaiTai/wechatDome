import 'package:flutter/material.dart';

class FindChild extends StatelessWidget {

  final String title;

  const FindChild({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        title: Text(title),
      ),
      body: Container(
        alignment: Alignment(0, 0),
        child: Text(title),
      ),
    );
  }
}
