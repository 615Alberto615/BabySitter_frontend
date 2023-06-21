import 'package:flutter/material.dart';
import 'package:front/cubit/login_cubit.dart';
import 'package:front/ui/login/uiLogin.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/ui/tutor/ayuda.dart';
import 'package:front/ui/tutor/reportesTutor.dart';

import '../../component/bottoms.dart';

import 'component/ColoresTutor.dart';
import 'component/icons.dart';

class OptionsT extends StatefulWidget {
  final userId;
  final tutorId;
  const OptionsT({Key? key, required this.userId, required this.tutorId})
      : super(key: key);
  _OptionsTState createState() => _OptionsTState();
}

class _OptionsTState extends State<OptionsT> {
  AnimationController? animationController;

  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  Widget tabBody = Container(
    color: ColoresTutor.background,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginCubit = context.read<LoginCubit>();

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
                          SizedBox(height: 30),
                          Container(
                            margin: EdgeInsets.only(top: 20, bottom: 20),
                            child: Text(
                              'Opciones',
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: HexColor('#20262E')),
                            ),
                          ),
                          SizedBox(height: 30),
                          CustomButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AyudaScreen()),
                              );
                            },
                            text: 'Ayuda',
                            icon: Icons.help,
                          ),
                          SizedBox(height: 5),
                          CustomButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ReportHis(
                                          userId: widget.userId,
                                          babysitterId: widget.tutorId,
                                        )),
                              );
                            },
                            text: 'Reportes de servicios',
                            icon: Icons.report_gmailerrorred,
                          ),
                          SizedBox(height: 5),
                          CustomButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Theme(
                                    data: Theme.of(context).copyWith(
                                        dialogBackgroundColor:
                                            HexColor("#9695ff")),
                                    child: AlertDialog(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0)),
                                      title: Text('Cerrar sesión',
                                          style:
                                              TextStyle(color: Colors.white)),
                                      content: Text(
                                          '¿Estás seguro de que quieres cerrar la sesión?',
                                          style:
                                              TextStyle(color: Colors.white)),
                                      actions: <Widget>[
                                        TextButton(
                                          child: Text('Cancelar',
                                              style: TextStyle(
                                                  color: Colors.white)),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                          child: Text('Aceptar',
                                              style: TextStyle(
                                                  color: Colors.white)),
                                          onPressed: () {
                                            loginCubit.logout();
                                            Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Login()),
                                              (route) => false,
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
