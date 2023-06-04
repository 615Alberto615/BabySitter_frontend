import 'package:flutter/material.dart';

import '../../component/bottoms.dart';
import '../../component/filds_forms.dart';
import 'component/img_top2.dart';

class TelefonosScreen extends StatefulWidget {
  @override
  _TelefonosScreenState createState() => _TelefonosScreenState();
}

class _TelefonosScreenState extends State<TelefonosScreen> {
  final TextEditingController phoneController = TextEditingController();
  List<String> phones = []; // Mantén una lista de teléfonos.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teléfonos de Emergencia'),
        backgroundColor: HexColor("#9695ff"),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          myfam5(),
          SizedBox(height: 10),
          Text(
              'Ingresas lo telefonos que tengas de familiares o amigos cercanos en caso de alguna emergencia',
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: HexColor('#20262E'))),
          SizedBox(height: 30),
          fildform(
            controller: phoneController,
            hint: 'Introduce el teléfono de emergencia',
            label: 'Teléfono',
            icon: Icons.phone,
          ),
          SizedBox(height: 20),
          CustomButton(
            onPressed: () {
              setState(() {
                phones.add(phoneController
                    .text); // Agrega el nuevo teléfono a la lista.
                phoneController
                    .clear(); // Limpia el campo después de agregarlo.
              });
            },
            text: 'Guardar Teléfono',
            icon: Icons.save,
          ),
          SizedBox(height: 20),
          ...phones
              .map((phone) => Card(
                    // Genera una tarjeta por cada teléfono.
                    child: ListTile(
                      title: Text(phone),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          setState(() {
                            phones.remove(
                                phone); // Elimina el teléfono cuando se presiona el botón de eliminar.
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
