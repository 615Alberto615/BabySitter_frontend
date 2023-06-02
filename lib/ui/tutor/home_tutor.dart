import 'package:flutter/material.dart';

import 'component/Bottom_Tutor.dart';

class HomeT extends StatefulWidget {
  const HomeT({Key? key}) : super(key: key);
  @override
  _HomeTState createState() => _HomeTState();
}

class _HomeTState extends State<HomeT> with TickerProviderStateMixin {
  void tabClick(int index) {
    // Implementa aquí lo que quieras que suceda cuando se haga clic en una pestaña
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF2A9D8F),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).padding.top,
            ),
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: Text(
                "Servicios Pendientes",
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Expanded(
              child: Container(),
            ),
            BottomBarView(
              changeIndex: tabClick,
              addClick: () {
                // Implementa aquí lo que quieras que suceda cuando se haga clic en el botón de agregar
              },
            ),
          ],
        ),
      ),
    );
  }
}

class TabIconData {
  final String imagePath;
  final String selectedImagePath;
  final int index;
  bool isSelected;
  final AnimationController? animationController;

  TabIconData({
    required this.imagePath,
    required this.selectedImagePath,
    required this.index,
    this.isSelected = false,
    this.animationController,
  });
}
