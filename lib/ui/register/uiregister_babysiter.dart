/*import 'package:flutter/material.dart';
import 'package:front/ui/register/components/filds_babysitter.dart';

import '../babysitter/home_babysiiter.dart';
import 'components/filds_signup.dart';
import 'components/login.dart';
import 'components/sign_up_top_image.dart';

final _ciController = TextEditingController();
final _extController = TextEditingController();
final _phoneController = TextEditingController();
final _descController = TextEditingController();

class RegisterB extends StatelessWidget {
  const RegisterB({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SignUpScreenTopImage(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      child: Text(
                    "Registro Niñer@",
                    style: TextStyle(
                        color: Color.fromRGBO(49, 39, 79, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  )),
                  SizedBox(
                    height: 30,
                  ),
                  CarnetAndExtensionFields(
                    ciController: _ciController,
                    extController: _extController,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ContactNumberField(controller: _phoneController),
                  SizedBox(
                    height: 20,
                  ),
                  DescriptionField(controller: _descController),
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
                            "Registrarse",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    )),
                  )),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                      child: Center(
                    child: IniciarSesionButton(),
                  )),
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
  if (_ciController.text.isNotEmpty &&
      _extController.text.isNotEmpty &&
      _phoneController.text.isNotEmpty &&
      _descController.text.isNotEmpty) {
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
*/