import 'package:flutter/material.dart';
import 'package:front/cubit/activity_cubit.dart';
import 'package:front/cubit/hability_cubit.dart';
import 'package:front/ui/babysitter/component/fild_hability.dart';
import 'package:front/ui/babysitter/home_babysiiter.dart';
import 'package:front/ui/register/components/filds_babysitter.dart'; //Asegúrate de que la ruta de importación sea correcta
import 'package:front/ui/tutor/component/SignUpScreenTopImage_child.dart';

import 'package:front/ui/tutor/mainT.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

final _ciController = TextEditingController();
final _extController = TextEditingController();
final _phoneController = TextEditingController();
final _descController = TextEditingController();
List<bool> _selectedActivities = [];

class HabilityForm extends StatefulWidget {
  final babysitterId;
  final userId;
  const HabilityForm({Key? key, this.userId, this.babysitterId})
      : super(key: key);

  @override
  _RegisterBBState createState() => _RegisterBBState();
}

class _RegisterBBState extends State<HabilityForm> {
  List<bool> _selectedActivities = List.filled(13, false);
  //List<bool> _selectedActivities = [];
  late TextEditingController _nameController = TextEditingController();
  late TextEditingController _fnController = TextEditingController();
  void initState() {
    super.initState();

    print(widget.userId);
    context.read<HabilityCubit>().fetchHabilityByTutorId(
          'http://10.0.2.2:8080/api/v1/babysitterAbility/babysitter/',
          widget.babysitterId,
        );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _fnController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return BlocConsumer<HabilityCubit, HabilityState>(
      listener: (context, state) {
        if (state is HabilityError) {
          // Muestra un mensaje de error
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        } else if (state is HabilityLoaded) {
          // Cuando se carguen los datos de la actividad, establece _selectedActivities
          setState(() {
            _selectedActivities = [
              state.activity.abilityKnowledgeChildDevelopment,
              state.activity.abilityEmpeathyAndPatience,
              state.activity.abilityEfectiveCommunication,
              state.activity.abilityOrganizationalSkills,
              state.activity.abilityFlexibilityAndAdaptability,
              state.activity.abilityFirstAid,
              state.activity.abilityCulturalSensitivity,
              state.activity.abilityConflictsResolution,
              state.activity.abilityCreativity,
              state.activity.abilitySpecialNeeds,
              state.activity.abilityCrefulObservation,
              state.activity.abilityTasteForTeaching,
              state.activity.abilityNone,
            ];
          });
          for (var i = 0; i < _selectedActivities.length; i++) {
            print('xd');
            print(_selectedActivities[i]);
          }
        } else if (state is HabilityUpdated) {
          // Muestra un mensaje de éxito y navega a la pantalla principal
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Registro realizado exitosamente')),
          );
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MainScreenBs(
                      userId: widget.userId,
                    )),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
          ),
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 5,
                ),
                SignUpScreenTopImageAct(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text(
                          "Mis Habilidades",
                          style: TextStyle(
                            color: Color.fromRGBO(49, 39, 79, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Rellene los campos con sus habilidades, recuerde que debe seleccionar al menos una habilidad para poder continuar con el registro, ademas llene el fromulario con responsabilidad y veracidad.",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: Color.fromRGBO(49, 39, 79, 1),
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ActivitiesForm(
                        // Pasar _selectedActivities a ActivitiesForm
                        initialActivities: _selectedActivities,
                        onFieldChanged: (activities) {
                          _selectedActivities = activities;
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      GestureDetector(
                        onTap: () {
                          print(_selectedActivities);
                          print(_selectedActivities.length);
                          print(_selectedActivities[0]);
                          print(_selectedActivities[1]);
                          try {
                            if (_selectedActivities.isNotEmpty) {
                              // Crear el requestBody con los datos del formulario
                              Map<String, dynamic> requestBody = {
                                'babysitterId': widget.babysitterId,
                                "abilityKnowledgeChildDevelopment":
                                    _selectedActivities[0],
                                "abilityEmpeathyAndPatience":
                                    _selectedActivities[1],
                                "abilityEfectiveCommunication":
                                    _selectedActivities[2],
                                "abilityOrganizationalSkills":
                                    _selectedActivities[3],
                                "abilityFlexibilityAndAdaptability":
                                    _selectedActivities[4],
                                "abilityFirstAid": _selectedActivities[5],
                                "abilityCulturalSensitivity":
                                    _selectedActivities[6],
                                "abilityConflictsResolution":
                                    _selectedActivities[7],
                                "abilityCreativity": _selectedActivities[8],
                                "abilitySpecialNeeds": _selectedActivities[9],
                                "abilityCrefulObservation":
                                    _selectedActivities[10],
                                "abilityTasteForTeaching":
                                    _selectedActivities[11],
                                "abilityNone": _selectedActivities[12]
                              };
                              context.read<HabilityCubit>().updateHability(
                                  'http://10.0.2.2:8080/api/v1/babysitterAbility/',
                                  widget.babysitterId,
                                  requestBody);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                        'Por favor, llena todos los campos')),
                              );
                            }
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      'Formato de fecha incorrecto. Por favor ingrese la fecha en formato aaaa/mm/dd')),
                            );
                          }
                        },
                        child: Container(
                          height: 50,
                          margin: EdgeInsets.symmetric(horizontal: 60),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: HexColor("#9695ff"),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromRGBO(196, 135, 198, .3),
                                blurRadius: 20,
                                offset: Offset(0, 10),
                              )
                            ],
                          ),
                          child: Center(
                            child: Text(
                              "Modificar Registro",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
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
