import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front/ui/login/uiLogin.dart';

import '../../../component/bottoms.dart';

class UserTextField extends StatelessWidget {
  final TextEditingController _controller;

  UserTextField({required TextEditingController controller})
      : _controller = controller;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(196, 135, 198, .3),
                blurRadius: 20,
                offset: Offset(0, 10),
              )
            ],
          ),
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              icon: Icon(Icons.person, color: HexColor("20262E")),
              hintText: 'Correo electrónico',
              labelText: "Correo electrónico",
              hintStyle: TextStyle(
                color: HexColor("20262E"),
              ),
              labelStyle: TextStyle(
                color: HexColor("20262E"),
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(10.0),
            ),
            onChanged: (value) {},
          ),
        );
      },
    );
  }
}

class PasswordTextField extends StatefulWidget {
  final TextEditingController _controller;

  PasswordTextField({required TextEditingController controller})
      : _controller = controller;

  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(196, 135, 198, .3),
                blurRadius: 20,
                offset: Offset(0, 10),
              )
            ],
          ),
          child: TextField(
            controller: widget._controller,
            obscureText: _obscureText,
            decoration: InputDecoration(
              icon: Icon(Icons.lock, color: HexColor("20262E")),
              hintText: 'Contraseña',
              labelText: "Contraseña",
              hintStyle: TextStyle(
                color: HexColor("20262E"),
              ),
              labelStyle: TextStyle(
                color: HexColor("20262E"),
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(10.0),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: HexColor("20262E"),
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              ),
            ),
            onChanged: (value) {},
          ),
        );
      },
    );
  }
}

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
}*/
