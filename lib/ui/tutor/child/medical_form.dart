import 'package:flutter/material.dart';
import 'package:front/ui/register/components/filds_babysitter.dart';

import '../../babysitter/home_babysiiter.dart';
import '../component/SignUpScreenTopImage_child.dart';
import '../component/filds_medical.dart';
import '../mainT.dart';

class medicalForm extends StatefulWidget {
  const medicalForm({Key? key}) : super(key: key);

  @override
  _medicalFormState createState() => _medicalFormState();
}

class _medicalFormState extends State<medicalForm> {
  String medubi = '';
  String enfermedades = '';
  String medicamentos = '';

  bool get isFormValid =>
      medubi.isNotEmpty && enfermedades.isNotEmpty && medicamentos.isNotEmpty;

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
              height: 0,
            ),
            SignUpScreenTopImageMed(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      child: Text(
                    "Recomendaciones de Cuidado:\n  Información Médica",
                    style: TextStyle(
                        color: Color.fromRGBO(49, 39, 79, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  )),
                  SizedBox(
                    height: 20,
                  ),
                  // Resto de tu código
                  MedicalForm(
                    onFieldChanged: (value) {
                      setState(() {
                        enfermedades = value;
                      });
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  MedicalForm2(
                    onFieldChanged: (value) {
                      setState(() {
                        medicamentos = value;
                      });
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  mediubTextField(
                    onFieldChanged: (value) {
                      setState(() {
                        medubi = value;
                      });
                    },
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    child: GestureDetector(
                      onTap: () {
                        if (isFormValid) {
                          navigateToHomeB(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content:
                                    Text('Por favor, llena todos los campos')),
                          );
                        }
                      },
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
                            "Registrar Información",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
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

  void navigateToHomeB(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MainScreen()),
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

// Resto de tu código

