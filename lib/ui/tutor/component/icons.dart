import 'package:flutter/material.dart';

class TabIconData {
  TabIconData({
    this.imagePath = '',
    this.index = 0,
    this.selectedImagePath = '',
    this.isSelected = false,
    this.animationController,
  });

  String imagePath;
  String selectedImagePath;
  bool isSelected;
  int index;

  AnimationController? animationController;

  static List<TabIconData> tabIconsList = <TabIconData>[
    TabIconData(
      imagePath: 'assets/bottom_bar/tab_1.png',
      selectedImagePath: 'assets/bottom_bar/tab_1s.png',
      index: 0,
      isSelected: true,
      animationController: null,
    ),
    TabIconData(
      imagePath: 'assets/bottom_bar/tab_5.png',
      selectedImagePath: 'assets/bottom_bar/tab_5s.png',
      index: 1,
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      imagePath: 'assets/bottom_bar/tab_6.png',
      selectedImagePath: 'assets/bottom_bar/tab_6s.png',
      index: 2,
      isSelected: false,
      animationController: null,
    ),
    TabIconData(
      imagePath: 'assets/bottom_bar/tab_4.png',
      selectedImagePath: 'assets/bottom_bar/tab_4s.png',
      index: 3,
      isSelected: false,
      animationController: null,
    ),
  ];
}
