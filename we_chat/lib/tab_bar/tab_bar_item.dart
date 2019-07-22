import 'package:flutter/material.dart';

BottomNavigationBarItem TabBarItem(tabBarItemName, tabBarItemImgName) {
  return BottomNavigationBarItem(

    title: Text('$tabBarItemName'),
    icon: Image(
      width: 20,
      height: 20,
      image: AssetImage('images/$tabBarItemImgName.png'),
    ),
    activeIcon: Image(
      width: 20,
      height: 20,
      image: AssetImage('images/' + '$tabBarItemImgName' + '_hl.png'),
    ),
  );
}
