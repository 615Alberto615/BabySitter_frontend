import 'package:flutter/material.dart';

import 'package:front/ui/tutor/component/Bottom_Tutor.dart' as bottomTutor;
import 'package:front/ui/tutor/perfil.dart';
import 'package:front/ui/tutor/reglas.dart';
import 'package:front/ui/tutor/telefonos.dart';
import '../../component/bottoms.dart';
import 'component/ColoresTutor.dart';

import 'component/icons.dart';
import 'component/img_top.dart';
import 'history_tutor.dart';
import 'home_tutor.dart';
import 'opciones_tutor.dart';

class familyT extends StatefulWidget {
  const familyT({Key? key}) : super(key: key);
  _familyTState createState() => _familyTState();
}

class _familyTState extends State<familyT> with TickerProviderStateMixin {
  AnimationController? animationController;

  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  List<String> hijos = ['Hijo 1', 'Hijo 2', 'Hijo 3'];

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
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
        backgroundColor: Colors.transparent,
        body: FutureBuilder<bool>(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            } else {
              return ListView(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                children: <Widget>[
                  SizedBox(height: 50),
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Text(
                        'Mi Familia',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: bottomTutor.HexColor('#20262E'),
                        ),
                      ),
                    ),
                  ),
                  myfam(),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Hijos Registrados',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: bottomTutor.HexColor('#20262E'))),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.add,
                          color: bottomTutor.HexColor('#20262E'),
                        ),
                      ),
                    ],
                  ),
                  ...hijos.map((hijo) {
                    return Card(
                      child: ListTile(
                        leading: Icon(Icons.child_care,
                            color: bottomTutor.HexColor('#20262E')),
                        title: Text(hijo),
                        trailing: IconButton(
                          icon: Icon(Icons.delete,
                              color: bottomTutor.HexColor('#20262E')),
                          onPressed: () {
                            setState(() {
                              hijos.remove(hijo);
                            });
                          },
                        ),
                      ),
                    );
                  }).toList(),
                  SizedBox(height: 20),
                  SizedBox(height: 10),
                  Text('Opciones',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: bottomTutor.HexColor('#20262E'))),
                  SizedBox(height: 10),
                  CustomButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PerfilScreen()),
                      );
                      // Hacer algo cuando se presiona el botón
                    },
                    text: 'Perfil',
                    icon: Icons.person,
                  ),
                  SizedBox(height: 6),
                  CustomButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ReglasScreen()),
                      );
                      // Hacer algo cuando se presiona el botón
                    },
                    text: 'Reglas de la casa',
                    icon: Icons.medical_information,
                  ),
                  SizedBox(height: 6),
                  CustomButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TelefonosScreen()),
                      );
                      // Hacer algo cuando se presiona el botón
                    },
                    text: 'Telefonos de emergencia',
                    icon: Icons.phone,
                  ),
                  SizedBox(height: 120),
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

class fildform extends StatelessWidget {
  final TextEditingController _controller;
  final String hint;
  final String label;
  final IconData icon;

  fildform(
      {required TextEditingController controller,
      required this.hint,
      required this.label,
      required this.icon})
      : _controller = controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      decoration: _decoration,
      child: TextField(
        controller: _controller,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          icon: Icon(icon, color: bottomTutor.HexColor('#20262E')),
          hintText: hint,
          labelText: label,
          hintStyle: _textStyle,
          labelStyle: _textStyle,
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(10.0),
        ),
      ),
    );
  }
}

BoxDecoration _decoration = BoxDecoration(
  borderRadius: BorderRadius.circular(20),
  color: Colors.white,
  boxShadow: [
    BoxShadow(
      color: Color.fromRGBO(196, 135, 198, .3),
      blurRadius: 20,
      offset: Offset(0, 10),
    )
  ],
);

TextStyle _textStyle = TextStyle(
  color: HexColor("20262E"),
);
void modificarPerfil() {
  // En esta función se puede implementar la lógica de actualización del perfil.
  print("Perfil actualizado"); // Este es un ejemplo de implementación.
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
