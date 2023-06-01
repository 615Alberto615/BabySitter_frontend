// RegistrarseButton.dart

import 'package:flutter/material.dart';

import '../../register/uiSignUp.dart';

class RegistrarseButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: SlideTransition(
        position: AlwaysStoppedAnimation(
            const Offset(0, 0)), // Modify this as per your need
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '¿No tienes una cuenta?',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
                fontWeight: FontWeight.normal,
              ),
            ),
            GestureDetector(
              onTap: () {
                // Ir a la página de registro.
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUp()),
                );
              },
              child: Text(
                '  Registrate',
                style: TextStyle(
                  color: Color(0xff132137),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
