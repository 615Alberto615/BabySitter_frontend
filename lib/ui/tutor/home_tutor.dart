import 'package:flutter/material.dart';

import 'package:front/ui/tutor/component/Bottom_Tutor.dart' as bottomTutor;
import 'component/ColoresTutor.dart';

import 'component/icons.dart';
import 'family_tutor.dart';
import 'history_tutor.dart';
import 'opciones_tutor.dart';

class HomeT extends StatefulWidget {
  const HomeT({Key? key}) : super(key: key);
  _HomeTState createState() => _HomeTState();
}

class _HomeTState extends State<HomeT> with TickerProviderStateMixin {
  AnimationController? animationController;

  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  Widget tabBody = Container(
    color: ColoresTutor.background,
  );

  @override
  void initState() {
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
        body: FutureBuilder<bool>(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            } else {
              return Stack(
                children: <Widget>[
                  ListView(children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 20, bottom: 20),
                            child: Text(
                              'Lista de Reservas',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: bottomTutor.HexColor('#20262E'),
                              ),
                            ),
                          ),
                          // Agrega más hijos a la lista aquí...
                        ],
                      ),
                    ),
                  ]),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
