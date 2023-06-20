import 'package:flutter/material.dart';
import 'package:front/ui/babysitter/component/img_topBs.dart';
import 'package:front/ui/tutor/child/activity_form.dart';
import 'package:front/ui/tutor/child/add_child.dart';

import 'package:front/ui/tutor/component/Bottom_Tutor.dart' as bottomTutor;
import 'package:front/ui/tutor/child/medical_form.dart';
import 'package:front/ui/tutor/component/icons.dart';
import 'package:front/ui/tutor/component/img_top.dart';
import 'package:front/ui/tutor/perfil.dart';
import 'package:front/ui/tutor/reglas.dart';
import 'package:front/ui/tutor/telefonos.dart';
import '../../component/bottoms.dart';
import '../../models/modelo_child.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/cubit/child_cubit.dart';

class BookingChilds extends StatefulWidget {
  final int tutorId;
  final int userId;
  const BookingChilds({
    Key? key,
    required this.tutorId,
    required this.userId,
  }) : super(key: key);
  _familyTState createState() => _familyTState();
}

class _familyTState extends State<BookingChilds> {
  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  @override
  void initState() {
    super.initState();

    try {
      context.read<ChildCubit>().fetchChildren(
          'http://10.0.2.2:8080/api/v1/child/tutor/',
          widget.tutorId.toString());
    } catch (e) {
      print(e);
    }
    print(widget.tutorId);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        backgroundColor: Colors.transparent,
        body: BlocConsumer<ChildCubit, ChildState>(
          listener: (context, state) {
            if (state is ChildError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            } else if (state is ChildDeleted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Registro eliminado correctamente')),
              );
              context.read<ChildCubit>().fetchChildren(
                  'http://10.0.2.2:8080/api/v1/child/tutor/',
                  widget.tutorId.toString());
            }
          },
          builder: (context, state) {
            return ListView(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              children: <Widget>[
                SizedBox(height: 0),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Text(
                      'Niños de la familia',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: bottomTutor.HexColor('#20262E'),
                      ),
                    ),
                  ),
                ),
                childs(),
                SizedBox(height: 10),
                Center(
                  child: Text('Informacion',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: HexColor('#20262E'))),
                ),
                SizedBox(height: 10),
                if (state is ChildrenLoaded)
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: state.children.length,
                    itemBuilder: (context, index) {
                      final hijo = state.children[index];
                      return Card(
                        elevation: 5.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: ListTile(
                          leading: Icon(Icons.child_care,
                              color: bottomTutor.HexColor('#20262E')),
                          title: Text(hijo.childName +
                              ' ' +
                              '\nEdad: ' +
                              getAge(hijo.childBirthdate).toString() +
                              ' años'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.medical_information,
                                    color: bottomTutor.HexColor('#20262E')),
                                onPressed: () {},
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                if (state is ChildLoading)
                  Center(child: CircularProgressIndicator()),
                SizedBox(height: 20),
                SizedBox(height: 10),
                SizedBox(height: 120),
              ],
            );
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

int getAge(String birthdate) {
  DateTime now = DateTime.now();
  List<String> parts = birthdate.split('/');
  int year = int.parse(parts[0]);
  int month = int.parse(parts[1]);
  int day = int.parse(parts[2]);
  DateTime dob = DateTime(year, month, day);
  Duration difference = now.difference(dob);
  int age = ((difference.inDays / 365).floor());
  int a = (age / 1000).floor();
  return age;
}
