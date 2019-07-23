import 'package:flutter/material.dart';

class HomeFind extends StatefulWidget {
  @override
  _HomeFindState createState() => _HomeFindState();
}

class _HomeFindState extends State<HomeFind> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(height: 80,color: Colors.red,),
        Container(height:800,color: Colors.green,),
      ],
    );
  }
}
