import 'package:flutter/material.dart';
import 'package:front/cubit/activity_cubit.dart';
import 'package:front/ui/register/components/filds_babysitter.dart'; //Asegúrate de que la ruta de importación sea correcta
import 'package:front/ui/tutor/mainT.dart';

import '../../babysitter/home_babysiiter.dart';
import '../component/SignUpScreenTopImage_child.dart';
import '../component/filds_activity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final _ciController = TextEditingController();
final _extController = TextEditingController();
final _phoneController = TextEditingController();
final _descController = TextEditingController();

class ActivForm extends StatefulWidget {
  final tutorId;
  final userId;
  const ActivForm({Key? key, this.tutorId, this.userId}) : super(key: key);

  @override
  _RegisterBBState createState() => _RegisterBBState();
}

class _RegisterBBState extends State<ActivForm> {
  List<bool> _selectedActivities = List.filled(13, false);
  //List<bool> _selectedActivities = [];
  late TextEditingController _nameController = TextEditingController();
  late TextEditingController _fnController = TextEditingController();
  void initState() {
    super.initState();

    print(widget.tutorId);
    print(widget.userId);
    context.read<ActivityCubit>().fetchActivityByTutorId(
          'http://10.0.2.2:8080/api/v1/childActivity/tutor/',
          widget.tutorId,
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
    return BlocConsumer<ActivityCubit, ActivityState>(
      listener: (context, state) {
        if (state is ActivityError) {
          // Muestra un mensaje de error
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        } else if (state is ActivityLoaded) {
          // Cuando se carguen los datos de la actividad, establece _selectedActivities
          setState(() {
            _selectedActivities = [
              state.activity.activityTableGames,
              state.activity.activityArtsAndCrafts,
              state.activity.activityReadingOfBooks,
              state.activity.activityCookingAndPastry,
              state.activity.activityOutdoorActivities,
              state.activity.activityBlockConstruction,
              state.activity.activityRolePlays,
              state.activity.activityMusicAndDance,
              state.activity.activityExercisesAndYoga,
              state.activity.activityGardening,
              state.activity.activityConstructionOfFortresses,
              state.activity.activityMoviesAndTvShows,
              state.activity.activityNone,
            ];
          });
          for (var i = 0; i < _selectedActivities.length; i++) {
            print('xd');
            print(_selectedActivities[i]);
          }
        } else if (state is ActivityUpdated) {
          // Muestra un mensaje de éxito y navega a la pantalla principal
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Registro realizado exitosamente')),
          );
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MainScreen(
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
                          "Recomendaciones de Cuidado:\n          Actividades",
                          style: TextStyle(
                            color: Color.fromRGBO(49, 39, 79, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
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
                          print(widget.tutorId);
                          try {
                            if (_selectedActivities.isNotEmpty) {
                              // Crear el requestBody con los datos del formulario
                              Map<String, dynamic> requestBody = {
                                'tutorId': widget.tutorId,
                                "activityTableGames": _selectedActivities[0],
                                "activityArtsAndCrafts": _selectedActivities[1],
                                "activityReadingOfBooks":
                                    _selectedActivities[2],
                                "activityCookingAndPastry":
                                    _selectedActivities[3],
                                "activityOutdoorActivities":
                                    _selectedActivities[4],
                                "activityBlockConstruction":
                                    _selectedActivities[5],
                                "activityRolePlays": _selectedActivities[6],
                                "activityMusicAndDance": _selectedActivities[7],
                                "activityExercisesAndYoga":
                                    _selectedActivities[8],
                                "activityGardening": _selectedActivities[9],
                                "activityConstructionOfFortresses":
                                    _selectedActivities[10],
                                "activityMoviesAndTvShows":
                                    _selectedActivities[11],
                                "activityNone": _selectedActivities[12]
                              };
                              context.read<ActivityCubit>().updateActivity(
                                  'http://10.0.2.2:8080/api/v1/childActivity/tutor/',
                                  widget.tutorId,
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
