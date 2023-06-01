// IniciarSesionButton.dart

import 'package:flutter/material.dart';

import '../../login/uiLogin.dart';

class IniciarSesionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          '¿Ya tienes una cuenta?',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
        ),
        GestureDetector(
          onTap: () {
            // Ir a la página de inicio de sesión.
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Login()),
            );
          },
          child: Text(
            "  Iniciar sesión",
            style: TextStyle(
              color: Color(0xff132137),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
