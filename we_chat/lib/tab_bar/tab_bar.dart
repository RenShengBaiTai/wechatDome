import 'package:flutter/material.dart';
import 'package:we_chat/address_list/address_list_root.dart';
import 'package:we_chat/find/find_root.dart';
import 'package:we_chat/home/home_root.dart';
import 'package:we_chat/my/my_root.dart';
import 'package:we_chat/tab_bar/tab_bar_item.dart';

class TabBarControl extends StatefulWidget {
  @override
  _TabBarControlState createState() => _TabBarControlState();
}

class _TabBarControlState extends State<TabBarControl> {

  int _currentIndex = 0;
  List<Widget> _pages = [
    HomeRoot(),
    AddressListRoot(),
    FindRoot(),
    MyRoot(),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            fixedColor: Colors.green,
            selectedFontSize: 12.0,
            currentIndex: _currentIndex,
            onTap: (int index) {
              _currentIndex = index;
              setState(() {});
            },//tap
            items: <BottomNavigationBarItem>[
              TabBarItem('微信'  ,'tabbar_chat'),
              TabBarItem('通讯录','tabbar_friends'),
              TabBarItem('发现'  ,'tabbar_discover'),
              TabBarItem('我的'  ,'tabbar_mine'),
            ]),
        body: _pages[_currentIndex],
      ),
    );
  }
}
