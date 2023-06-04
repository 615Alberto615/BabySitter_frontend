import 'package:flutter/material.dart';

import 'component/Bottom_Tutor.dart';
import 'component/ColoresTutor.dart';

import 'component/icons.dart';
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
                  ListView(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    children: [
                      SizedBox(height: 50),
                      Container(
                        margin: EdgeInsets.only(top: 20, bottom: 20),
                        child: Text(
                          'Familia',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: HexColor('#20262E'),
                          ),
                        ),
                      ),
                      Text('Perfil',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: HexColor('#20262E'))),
                      SizedBox(height: 10),
                      fildform(
                          controller: nameController,
                          hint: 'Nombre',
                          label: 'Nombre',
                          icon: Icons.person),
                      SizedBox(height: 10),
                      fildform(
                          controller: surnameController,
                          hint: 'Apellido',
                          label: 'Apellido',
                          icon: Icons.person_outline),
                      SizedBox(height: 10),
                      fildform(
                          controller: cityController,
                          hint: 'Ciudad',
                          label: 'Ciudad',
                          icon: Icons.location_city),
                      SizedBox(height: 30),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: HexColor('9695ff'),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'Modificar campos de perfil',
                          style: TextStyle(color: HexColor('20262E')),
                        ),
                        onPressed: modificarPerfil,
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Hijos Registrados',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: HexColor('#20262E'))),
                          IconButton(
                            onPressed: () {
                              /*
                              // Aquí va el código que debe ejecutarse cuando se presiona el botón
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()),
                              );*/
                            },
                            icon: Icon(Icons.add, color: HexColor('#20262E')),
                          ),
                        ],
                      ),
                      Column(
                        children: hijos.map((hijo) {
                          return Card(
                            child: ListTile(
                              leading: Icon(Icons.child_care,
                                  color: HexColor("20262E")),
                              title: Text(hijo),
                              trailing: IconButton(
                                icon: Icon(Icons.delete,
                                    color: HexColor("20262E")),
                                onPressed: () {
                                  setState(() {
                                    hijos.remove(hijo);
                                  });
                                },
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
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
          icon: Icon(icon, color: HexColor("20262E")),
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
