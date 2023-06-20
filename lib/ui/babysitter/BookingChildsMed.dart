import 'package:flutter/material.dart';
import 'package:front/cubit/med_cubit.dart';
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
      context.read<MedCubit>().fetchMed(
          'http://10.0.2.2:8080/api/v1/childMedicalForm/',
          widget.child.childId.toString() + "/");
    } catch (e) {
      print(e);
    }
    print(widget.child.childId.toString());
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
          body: BlocConsumer<MedCubit, MedState>(
            listener: (context, state) {
              if (state is MedError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: ${state.message}')),
                );
              }
            },
            builder: (context, state) {
              return ListView(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                children: [
                  tles2(),
                  Text(
                    "Información Médica del niño/a:",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color.fromRGBO(49, 39, 79, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                  Text(
                    "${widget.child.childName}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color.fromRGBO(49, 39, 79, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'INFORMACIÓN MÉDICA',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: HexColor('#20262E'),
                    ),
                  ),
                  SizedBox(height: 20),
                  if (state is MedLoaded)
                    Card(
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Column(
                        children: <Widget>[
                          Text(
                            '¿El niño tiene alguna enfermedad y/o alergia?',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: HexColor('#20262E'),
                            ),
                          ),
                          SizedBox(height: 5),
                          ListTile(
                            leading: Icon(Icons.medical_information_outlined,
                                color: HexColor('#20262E')),
                            title: Text(state.medForm.medicalAllergieType,
                                style: TextStyle(
                                    fontSize: 15, color: HexColor('#20262E'))),
                          ),
                          SizedBox(height: 5),
                          Text(
                            '¿El niño necesita algún medicamento?',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: HexColor('#20262E'),
                            ),
                          ),
                          SizedBox(height: 5),
                          ListTile(
                            leading: Icon(Icons.medication_outlined,
                                color: HexColor('#20262E')),
                            title: Text(state.medForm.medicalMedication,
                                style: TextStyle(
                                    fontSize: 15, color: HexColor('#20262E'))),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'En caso de emergencia: ¿Donde se encuentra el botiquin/medicamentos?',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: HexColor('#20262E'),
                            ),
                          ),
                          SizedBox(height: 5),
                          ListTile(
                            leading: Icon(Icons.location_history,
                                color: HexColor('#20262E')),
                            title: Text(
                                state.medForm.medicalMedicationUbication,
                                style: TextStyle(
                                    fontSize: 15, color: HexColor('#20262E'))),
                          ),
                        ],
                      ),
                    ),
                  if (state is MedLoading) CircularProgressIndicator(),
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
