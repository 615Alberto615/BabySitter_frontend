import 'package:flutter/material.dart';
import 'package:front/ui/tutor/perfil.dart';

import '../../component/filds_forms.dart';
import 'component/img_top2.dart';

class ReglasScreen extends StatefulWidget {
  @override
  _ReglasScreenState createState() => _ReglasScreenState();
}

class _ReglasScreenState extends State<ReglasScreen> {
  final TextEditingController ruleController = TextEditingController();
  List<String> rules = []; // Mantén una lista de reglas.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reglas de la casa'),
        backgroundColor: HexColor("#9695ff"),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          myfam3(),
          SizedBox(height: 10),
          Center(
            child: Text('Reglas de la Casa',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: HexColor('#20262E'))),
          ),
          SizedBox(height: 30),
          fildform(
            controller: ruleController,
            hint: 'Introduce la regla',
            label: 'Regla',
            icon: Icons.rule,
          ),
          SizedBox(height: 20),
          PerfilButton(
            text: 'Guardar Regla',
            onPressed: () {
              setState(() {
                rules.add(
                    ruleController.text); // Agrega la nueva regla a la lista.
                ruleController.clear(); // Limpia el campo después de agregarlo.
              });
            },
          ),
          SizedBox(height: 20),
          ...rules
              .map((rule) => Card(
                    // Genera una tarjeta por cada regla.
                    child: ListTile(
                      title: Text(rule),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            rules.remove(
                                rule); // Elimina la regla cuando se presiona el botón de eliminar.
                          });
                        },
                      ),
                    ),
                  ))
              .toList(),
        ],
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
