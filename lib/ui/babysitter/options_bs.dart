import 'package:flutter/material.dart';
import 'package:front/ui/babysitter/perfil_bs.dart';
import 'package:front/ui/babysitter/verify_bs.dart';
import 'package:front/ui/login/uiLogin.dart';

import '../../component/bottoms.dart';
import '../tutor/component/ColoresTutor.dart';
import '../tutor/component/icons.dart';

// Asegúrate de importar CustomButton

class OptionsBs extends StatefulWidget {
  const OptionsBs({Key? key}) : super(key: key);
  _OptionsTState createState() => _OptionsTState();
}

class _OptionsTState extends State<OptionsBs> with TickerProviderStateMixin {
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
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20, bottom: 20),
                            child: Text(
                              'Opciones',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: HexColor('#20262E'),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          // Agrega los CustomButton aquí...
                          CustomButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PerfilScreenB()),
                              );
                              // Hacer algo cuando se presiona el botón
                            },
                            text: 'Perfil',
                            icon: Icons.person,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          CustomButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => verifyBs()),
                              );
                              // Hacer algo cuando se presiona el botón
                            },
                            text: 'Verificar',
                            icon: Icons.verified,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          CustomButton(
                            onPressed: () {
                              // Mostrar un AlertDialog con un estilo personalizado
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Theme(
                                    data: Theme.of(context).copyWith(
                                      dialogBackgroundColor: HexColor(
                                          "#9695ff"), // Color de fondo personalizado
                                    ),
                                    child: AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            20.0), // Bordes redondeados
                                      ),
                                      title: Text(
                                        'Cerrar sesión',
                                        style: TextStyle(
                                          color: Colors
                                              .white, // Color de texto personalizado
                                        ),
                                      ),
                                      content: Text(
                                        '¿Estás seguro de que quieres cerrar la sesión?',
                                        style: TextStyle(
                                          color: Colors
                                              .white, // Color de texto personalizado
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          child: Text(
                                            'Cancelar',
                                            style: TextStyle(
                                              color: Colors
                                                  .white, // Color de texto personalizado
                                            ),
                                          ),
                                          onPressed: () {
                                            // Cerrar el AlertDialog
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                          child: Text(
                                            'Aceptar',
                                            style: TextStyle(
                                              color: Colors
                                                  .white, // Color de texto personalizado
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Login()),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            text: 'Cerrar sesión',
                            icon: Icons.exit_to_app,
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
