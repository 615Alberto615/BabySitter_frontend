import 'package:flutter/material.dart';
import 'package:front/ui/register/components/filds_babysitter.dart'; //Asegúrate de que la ruta de importación sea correcta

import '../../babysitter/home_babysiiter.dart';
import '../component/SignUpScreenTopImage_child.dart';
import '../component/filds_activity.dart';

final _ciController = TextEditingController();
final _extController = TextEditingController();
final _phoneController = TextEditingController();
final _descController = TextEditingController();
List<String> _selectedActivities = [];

class activForm extends StatelessWidget {
  const activForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 5,
            ),
            SignUpScreenTopImageAct(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      child: Text(
                    "Recomendaciones de Cuidado:\n          Actividades",
                    style: TextStyle(
                        color: Color.fromRGBO(49, 39, 79, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  )),
                  SizedBox(
                    height: 30,
                  ),
                  ActivitiesForm(
                    onFieldChanged: (activities) {
                      _selectedActivities = activities;
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                      child: Container(
                    height: 50,
                    margin: EdgeInsets.symmetric(horizontal: 60),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: HexColor("#9695ff"),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(196, 135, 198, .3),
                          blurRadius: 20,
                          offset: Offset(0, 10),
                        )
                      ],
                    ),
                    child: Center(
                        child: GestureDetector(
                      onTap: () => navigateToHomeB(context),
                      child: Container(
                        height: 50,
                        margin: EdgeInsets.symmetric(horizontal: 60),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: HexColor("#9695ff"),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(196, 135, 198, .3),
                              blurRadius: 20,
                              offset: Offset(0, 10),
                            )
                          ],
                        ),
                        child: Center(
                          child: Text(
                            "Registrar",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    )),
                  )),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
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

void navigateToHomeB(BuildContext context) {
  if (_selectedActivities.isNotEmpty) {
    // verifica que al menos una actividad ha sido seleccionada
    // Si todos los campos están completos, navega a HomeB
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MainScreenBs()),
    );
  } else {
    // Si no, muestra un snackbar indicando que todos los campos deben ser completados
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Por favor, llena todos los campos')),
    );
  }
}
