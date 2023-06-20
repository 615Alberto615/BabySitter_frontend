import 'package:flutter/material.dart';
import 'package:front/cubit/telefonos_cubit.dart';
import 'package:front/ui/babysitter/component/img_topBs.dart';

import '../../component/bottoms.dart';
import '../../component/filds_forms.dart';
import 'component/img_top2.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TelefonosScreen extends StatefulWidget {
  final int tutorId;
  final int userId;
  const TelefonosScreen({Key? key, required this.tutorId, required this.userId})
      : super(key: key);
  @override
  _TelefonosScreenState createState() => _TelefonosScreenState();
}

class _TelefonosScreenState extends State<TelefonosScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _nombretelController = TextEditingController();
  void initState() {
    super.initState();

    try {
      context.read<TelefonoCubit>().fetchTelefono(
          'http://10.0.2.2:8080/api/v1/tutorEmergencyContact/tutor/',
          widget.tutorId.toString());
    } catch (e) {
      print(e);
    }
    print(widget.tutorId);
    print(widget.userId);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: BlocConsumer<TelefonoCubit, TelefonoState>(
            listener: (context, state) {
              if (state is TelefonoError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: ${state.message}')),
                );
              } else if (state is TelefonoDeleted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Registro eliminado correctamente')),
                );
                context.read<TelefonoCubit>().fetchTelefono(
                    'http://10.0.2.2:8080/api/v1/tutorEmergencyContact/tutor/',
                    widget.tutorId.toString());
              } else if (state is TelefonoCreated) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Registro creado correctamente')),
                );
                _nombretelController.clear();
                _phoneController.clear();
                context.read<TelefonoCubit>().fetchTelefono(
                    'http://10.0.2.2:8080/api/v1/tutorEmergencyContact/tutor/',
                    widget.tutorId.toString());
              }
            },
            builder: (context, state) {
              return ListView(
                padding: EdgeInsets.all(20),
                children: [
                  tles(),
                  Center(
                    child: Text('Teléfonos de emergencia',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: HexColor('#20262E'))),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Ingresa algunos telefonos en caso de alguna emergencia',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: HexColor('#20262E'),
                    ),
                  ),
                  SizedBox(height: 30),
                  fildform(
                    controller: _nombretelController,
                    hint: 'Introduce el nombre del contacto',
                    label: 'Nombre',
                    icon: Icons.person,
                  ),
                  SizedBox(height: 10),
                  fildform(
                    controller: _phoneController,
                    hint: 'Introduce el teléfono de emergencia',
                    label: 'Teléfono',
                    icon: Icons.phone,
                  ),
                  SizedBox(height: 20),
                  CustomButton(
                    onPressed: () {
                      if (_nombretelController.text.isNotEmpty &&
                          _phoneController.text.isNotEmpty &&
                          _phoneController.text
                              .contains(RegExp(r'^[67]\d{7}$'))) {
                        final telefonoCubit = context.read<TelefonoCubit>();
                        var result = telefonoCubit.createTelefono(
                          'http://10.0.2.2:8080/api/v1/tutorEmergencyContact/',
                          {
                            'nameContact': _nombretelController.text,
                            'phoneContact': _phoneController.text,
                            'tutorId': widget.tutorId.toInt(),
                          },
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  'Por favor, complete los campos requeridos e introduce un numero valido.')),
                        );
                      }
                    },
                    text: 'Guardar Teléfono',
                    icon: Icons.save,
                  ),
                  SizedBox(height: 20),
                  if (state is TelefonoLoaded)
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: state.telefonos.length,
                      itemBuilder: (context, index) {
                        final tele = state.telefonos[index];
                        return Card(
                          elevation: 5.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: ListTile(
                            leading: Icon(Icons.rule_sharp,
                                color: HexColor('#20262E')),
                            title: Text(tele.nameContact,
                                style: TextStyle(
                                    fontSize: 15, color: HexColor('#20262E'))),
                            subtitle: Text(tele.phoneContact,
                                style: TextStyle(
                                    fontSize: 15, color: HexColor('#20262E'))),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.delete,
                                      color: HexColor('#20262E')),
                                  onPressed: () async {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Dialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                          backgroundColor: HexColor("#9695ff"),
                                          child: Container(
                                            padding: EdgeInsets.all(20.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  'Eliminar Regla',
                                                  style: TextStyle(
                                                      fontSize: 24.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(height: 20.0),
                                                Text(
                                                    'Estás seguro que quieres eliminar esta regla?'),
                                                SizedBox(height: 20.0),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
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
                                                        Navigator.of(context)
                                                            .pop();
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
                                                      onPressed: () async {
                                                        await context
                                                            .read<
                                                                TelefonoCubit>()
                                                            .deleteTelefono(
                                                                'http://10.0.2.2:8080/api/v1/tutorEmergencyContact/',
                                                                '${tele.tutorEmergencyContactId}');
                                                        Navigator.of(context)
                                                            .pop();
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
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  if (state is TelefonoLoading) CircularProgressIndicator(),
                  SizedBox(height: 10),
                ],
              );
            },
          ),
        ));
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
