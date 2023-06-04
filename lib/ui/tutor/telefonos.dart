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
        title: Text(
          'Teléfonos de Emergencia',
          style: TextStyle(
              color: Colors.white, fontFamily: 'Roboto', fontSize: 20.0),
        ),
        backgroundColor: HexColor("#9695ff"),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          //myfam5(),
          SizedBox(height: 10),
          Text(
            'Ingresas lo telefonos que tengas de familiares o amigos cercanos en caso de alguna emergencia',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: HexColor('#20262E'),
            ),
          ),
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
              if (phoneController.text.isNotEmpty &&
                  phoneController.text.contains(RegExp(r'^\d+$'))) {
                setState(() {
                  phones.add(phoneController.text);
                  phoneController.clear();
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Teléfono guardado exitosamente!')),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(
                          'Por favor, introduce un número de teléfono válido.')),
                );
              }
            },
            text: 'Guardar Teléfono',
            icon: Icons.save,
          ),
          SizedBox(height: 20),
          ...phones
              .map((phone) => Card(
                    child: ListTile(
                      title: Text(phone),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        20.0)), // Esto es para que el diálogo sea redondeado
                                backgroundColor: HexColor(
                                    "#9695ff"), // Aquí puedes cambiar el color del diálogo
                                child: Container(
                                  padding: EdgeInsets.all(20.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize
                                        .min, // Para hacer el diálogo más pequeño
                                    children: [
                                      Text('Eliminar número',
                                          style: TextStyle(
                                              fontSize: 24.0,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(height: 20.0),
                                      Text(
                                          'Estás seguro que quieres eliminar este número de teléfono?'),
                                      SizedBox(height: 20.0),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          TextButton(
                                            child: Text(
                                              'Cancelar',
                                              style: TextStyle(
                                                color: Colors
                                                    .white, // Color de texto personalizado
                                              ),
                                            ),
                                            onPressed: () {
                                              // Cerrar el AlertDialog
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          TextButton(
                                            child: Text(
                                              'Eliminar',
                                              style: TextStyle(
                                                color: Colors
                                                    .white, // Color de texto personalizado
                                              ),
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                phones.remove(phone);
                                              });
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
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
