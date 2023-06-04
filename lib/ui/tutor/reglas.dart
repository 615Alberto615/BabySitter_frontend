import 'package:flutter/material.dart';

class ReglasScreen extends StatelessWidget {
  const ReglasScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reglas de la Casa'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Text(
            'Aquí escribes las reglas de la casa'), // Puedes cambiar este texto por lo que quieras mostrar.
      ),
    );
  }
}
