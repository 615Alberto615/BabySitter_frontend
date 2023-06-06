import 'package:flutter/material.dart';
import 'package:front/ui/babysitter/options_bs.dart';

import '../tutor/component/ColoresTutor.dart';
import '../tutor/component/icons.dart';
import 'component/Bottom_bs.dart';
import 'list_bs.dart';

class MainScreenBs extends StatefulWidget {
  const MainScreenBs({Key? key}) : super(key: key);
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreenBs>
    with TickerProviderStateMixin {
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
        BottomBarViewV2(
          tabIconsList: tabIconsList,
          changeIndex: (int index) {
            if (index == 0) {
              setState(() {
                tabBody = HomeLB();
                for (int i = 0; i < tabIconsList.length; i++) {
                  tabIconsList[i].isSelected = i == index;
                }
              });
            } else if (index == 3) {
              setState(() {
                tabBody = OptionsBs();
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
