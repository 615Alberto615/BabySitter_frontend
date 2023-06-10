import 'package:flutter/material.dart';
import 'package:front/ui/login/uiLogin.dart';
import 'package:front/ui/tutor/child/medical_form.dart';

import '../../../component/bottoms.dart';

import '../component/ColoresTutor.dart';
import '../component/SignUpScreenTopImage_child.dart';
import '../component/icons.dart';
import 'activity_form.dart';
import 'edit_child.dart';

// Asegúrate de importar CustomButton

class childOptions extends StatefulWidget {
  const childOptions({Key? key}) : super(key: key);
  _OptionsTState createState() => _OptionsTState();
}

class _OptionsTState extends State<childOptions> with TickerProviderStateMixin {
  AnimationController? animationController;

  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  Widget tabBody = Container(
    color: Colors.white,
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
      color: Colors.white,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
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
                          SizedBox(
                            height: 0,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20, bottom: 20),
                            child: Text(
                              'Opciones para el registro del hijo',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: HexColor('#20262E'),
                              ),
                            ),
                          ),
                          SignUpScreenTopImageChild(),
                          SizedBox(
                            height: 20,
                          ),
                          // Agrega los CustomButton aquí...
                          CustomButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => editBB()),
                              );
                              // Hacer algo cuando se presiona el botón
                            },
                            text: 'Datos Registro',
                            icon: Icons.child_care,
                          ),
                          SizedBox(
                            height: 7,
                          ),

                          SizedBox(
                            height: 7,
                          ),
                          CustomButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => activForm()),
                              );
                              // Hacer algo cuando se presiona el botón
                            },
                            text: 'Actividades',
                            icon: Icons.local_activity,
                          ),

                          // Agrega más botones según necesites...
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
