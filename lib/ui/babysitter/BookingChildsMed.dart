import 'package:flutter/material.dart';
import 'package:front/cubit/telefonos_cubit.dart';
import 'package:front/models/modelo_child.dart';
import 'package:front/ui/babysitter/component/img_topBs.dart';

import '../../component/bottoms.dart';
import '../../component/filds_forms.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class ChildMed extends StatefulWidget {
  final int tutorId;
  final int userId;
  final Child child;
  const ChildMed(
      {Key? key,
      required this.tutorId,
      required this.userId,
      required this.child})
      : super(key: key);
  @override
  _TelefonosScreenState createState() => _TelefonosScreenState();
}

class _TelefonosScreenState extends State<ChildMed> {
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
                    'Teléfonos en caso de emergencia para la reserva.',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: HexColor('#20262E'),
                    ),
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
                            leading:
                                Icon(Icons.phone, color: HexColor('#20262E')),
                            title: Text(tele.nameContact,
                                style: TextStyle(
                                    fontSize: 15, color: HexColor('#20262E'))),
                            subtitle: Text(tele.phoneContact,
                                style: TextStyle(
                                    fontSize: 15, color: HexColor('#20262E'))),
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
