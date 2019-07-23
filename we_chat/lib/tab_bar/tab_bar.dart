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
  final PageController _pageController = PageController(initialPage: 0);

  int _currentIndex = 0;

//  List<Widget> _pages = [
//    HomeRoot(),
//    AddressListRoot(),
//    FindRoot(),
//    MyRoot(),
//  ];

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
              _pageController.jumpToPage(index);
            },
            //tap
            items: <BottomNavigationBarItem>[
              TabBarItem('微信', 'tabbar_chat'),
              TabBarItem('通讯录', 'tabbar_friends'),
              TabBarItem('发现', 'tabbar_discover'),
              TabBarItem('我的', 'tabbar_mine'),
            ]),
//        body: _pages[_currentIndex],
        body: PageView(//默认可以滑动切换
          //禁止滑动
          physics: NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: <Widget>[
            HomeRoot(),
            AddressListRoot(),
            FindRoot(),
            MyRoot(),
          ],
        ),
      ),
    );
  }
}
