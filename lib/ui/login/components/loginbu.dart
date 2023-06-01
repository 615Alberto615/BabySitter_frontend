import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../uiLogin.dart';
/*
class LoginButton extends StatelessWidget {
  final TextEditingController _userController;
  final TextEditingController _passwordController;

  LoginButton({
    Key? key,
    required TextEditingController userController,
    required TextEditingController passwordController,
  })  : _userController = userController,
        _passwordController = passwordController,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 100.0),
      child: ElevatedButton(
        child: Text('Iniciar Sesión',
            style: TextStyle(color: HexColor("FFEEEFF5"))),
        style: ElevatedButton.styleFrom(
          primary: HexColor('#20262E'),
          onPrimary: HexColor("20262E"),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        onPressed: () {
          // Llamar al AuthCubit y realizar una acción
          final authCubit = context.read<AuthCubit>();
          authCubit.login(
            _userController.text,
            _passwordController.text,
          );
        },
      ),
    );
  }
}
*/