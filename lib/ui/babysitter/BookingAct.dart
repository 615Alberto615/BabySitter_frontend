import 'package:flutter/material.dart';
import 'package:front/cubit/activity_cubit.dart';
import 'package:front/models/modelo_activiy.dart';
import 'package:front/ui/register/components/filds_babysitter.dart'; //Asegúrate de que la ruta de importación sea correcta
import 'package:front/ui/tutor/component/SignUpScreenTopImage_child.dart';
import 'package:front/ui/tutor/mainT.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

final _ciController = TextEditingController();
final _extController = TextEditingController();
final _phoneController = TextEditingController();
final _descController = TextEditingController();

class ActivFormBs extends StatefulWidget {
  final tutorId;
  final userId;
  const ActivFormBs({
    Key? key,
    this.tutorId,
    this.userId,
  }) : super(key: key);

  @override
  _RegisterBBState createState() => _RegisterBBState();
}

class _RegisterBBState extends State<ActivFormBs> {
  late TextEditingController _nameController = TextEditingController();
  late TextEditingController _fnController = TextEditingController();

  List<String> _getSelectedActivities(Activity activity) {
    List<String> selectedActivities = [];

    if (activity.activityTableGames) {
      selectedActivities.add('Juegos de mesa');
    }
    if (activity.activityArtsAndCrafts) {
      selectedActivities.add('Artes y manualidades');
    }
    if (activity.activityReadingOfBooks) {
      selectedActivities.add('Lectura de libros');
    }
    if (activity.activityCookingAndPastry) {
      selectedActivities.add('Cocina y repostería');
    }
    if (activity.activityOutdoorActivities) {
      selectedActivities.add('Actividades al aire libre');
    }
    if (activity.activityBlockConstruction) {
      selectedActivities.add('Construcción con bloques');
    }
    if (activity.activityRolePlays) {
      selectedActivities.add('Juegos de roles');
    }
    if (activity.activityMusicAndDance) {
      selectedActivities.add('Música y baile');
    }
    if (activity.activityExercisesAndYoga) {
      selectedActivities.add('Jugar videojuegos');
    }
    if (activity.activityGardening) {
      selectedActivities.add('Jardinería');
    }
    if (activity.activityConstructionOfFortresses) {
      selectedActivities.add('Construcción de fortalezas');
    }
    if (activity.activityMoviesAndTvShows) {
      selectedActivities.add('Películas y programas de televisión');
    }
    if (activity.activityNone) {
      selectedActivities.add('Ninguna');
    }

    // Haz esto para cada actividad
    // ...

    return selectedActivities;
  }

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
      }
    }, builder: (context, state) {
      if (state is ActivityLoaded) {
        List<String> selectedActivities =
            _getSelectedActivities(state.activity);
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
                          "Recomendaciones de Cuidado:",
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
                      Container(
                        child: Text(
                          "  Actividades Permitidas/Sugeridas:",
                          style: TextStyle(
                            color: Color.fromRGBO(49, 39, 79, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      for (var activity in selectedActivities)
                        Card(
                          child: ListTile(
                            title: Text(activity),
                          ),
                        ),
                      SizedBox(
                        height: 30,
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
      } else if (state is ActivityError) {
        // Devuelve un widget de error
        return Center(child: Text('Error: ${state.message}'));
      } else {
        // Devuelve un widget de carga para cualquier otro estado
        return Center(child: CircularProgressIndicator());
      }
    });
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
