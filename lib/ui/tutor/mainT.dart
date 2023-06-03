import 'package:flutter/material.dart';

import 'component/Bottom_Tutor.dart';
import 'component/ColoresTutor.dart';
import 'component/icons.dart';
import 'family_tutor.dart';
import 'history_tutor.dart';
import 'home_tutor.dart';
import 'opciones_tutor.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  AnimationController? animationController;
  List<TabIconData> tabIconsList = TabIconData.tabIconsList;
  Widget tabBody = Container(color: ColoresTutor.background);

  @override
  void initState() {
    tabIconsList.forEach((TabIconData tab) {
      tab.isSelected = false;
    });
    tabIconsList[0].isSelected = true;

    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);

    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColoresTutor.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            tabBody,
            bottomBar(),
          ],
        ),
      ),
    );
  }

  Widget bottomBar() {
    return Column(
      children: <Widget>[
        const Expanded(
          child: SizedBox(),
        ),
        BottomBarView(
          tabIconsList: tabIconsList,
          addClick: () {},
          changeIndex: (int index) {
            if (index == 0) {
              setState(() {
                tabBody = HomeT();
                for (int i = 0; i < tabIconsList.length; i++) {
                  tabIconsList[i].isSelected = i == index;
                }
              });
            } else if (index == 1) {
              setState(() {
                tabBody = familyT();
                for (int i = 0; i < tabIconsList.length; i++) {
                  tabIconsList[i].isSelected = i == index;
                }
              });
            } else if (index == 2) {
              setState(() {
                tabBody = HistoryT();
                for (int i = 0; i < tabIconsList.length; i++) {
                  tabIconsList[i].isSelected = i == index;
                }
              });
            } else if (index == 3) {
              setState(() {
                tabBody = OptionsT();
                for (int i = 0; i < tabIconsList.length; i++) {
                  tabIconsList[i].isSelected = i == index;
                }
              });
            }
          },
        ),
      ],
    );
  }
}
