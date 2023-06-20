import 'package:flutter/material.dart';
import 'package:front/cubit/activity_cubit.dart';
import 'package:front/cubit/hability_cubit.dart';
import 'package:front/models/modelo_activiy.dart';
import 'package:front/models/modelo_hability.dart';
import 'package:front/ui/register/components/filds_babysitter.dart'; //Asegúrate de que la ruta de importación sea correcta
import 'package:front/ui/tutor/component/SignUpScreenTopImage_child.dart';
import 'package:front/ui/tutor/mainT.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

final _ciController = TextEditingController();
final _extController = TextEditingController();
final _phoneController = TextEditingController();
final _descController = TextEditingController();

class HabFormBs extends StatefulWidget {
  final babysitterId;
  final userId;
  const HabFormBs({
    Key? key,
    this.userId,
    this.babysitterId,
  }) : super(key: key);

  @override
  _RegisterBBState createState() => _RegisterBBState();
}

class _RegisterBBState extends State<HabFormBs> {
  late TextEditingController _nameController = TextEditingController();
  late TextEditingController _fnController = TextEditingController();

  List<String> _getSelectedActivities(hability activity) {
    List<String> selectedActivities = [];

    if (activity.abilityKnowledgeChildDevelopment) {
      selectedActivities.add('Conocimientos sobre el desarrollo infantil');
    }
    if (activity.abilityEmpeathyAndPatience) {
      selectedActivities.add('Empatía y paciencia');
    }
    if (activity.abilityEfectiveCommunication) {
      selectedActivities.add('Comunicación efectiva');
    }
    if (activity.abilityOrganizationalSkills) {
      selectedActivities.add('Habilidades de organización');
    }
    if (activity.abilityFlexibilityAndAdaptability) {
      selectedActivities.add('Flexibilidad y adaptabilidad');
    }
    if (activity.abilityFirstAid) {
      selectedActivities.add('Conocimientos de primeros auxilios');
    }
    if (activity.abilityCulturalSensitivity) {
      selectedActivities.add('Sensibilidad cultural: ');
    }
    if (activity.abilityConflictsResolution) {
      selectedActivities.add('Habilidades de resolución de conflictos');
    }
    if (activity.abilityCreativity) {
      selectedActivities.add('Creatividad');
    }
    if (activity.abilitySpecialNeeds) {
      selectedActivities.add('Conocimiento de necesidades especiales');
    }
    if (activity.abilityCrefulObservation) {
      selectedActivities.add('Observación atenta');
    }
    if (activity.abilityTasteForTeaching) {
      selectedActivities.add('Gusto por la enseñanza');
    }
    if (activity.abilityNone) {
      selectedActivities.add('Ninguna');
    }

    return selectedActivities;
  }

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
      }
    }, builder: (context, state) {
      if (state is HabilityLoaded) {
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
                          "Habilidades de la Niñera",
                          style: TextStyle(
                            color: Color.fromRGBO(49, 39, 79, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: Text(
                          "Estas son las habilidades que la niñera tiene para cuidar a tu hijo/a:",
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
      } else if (state is HabilityError) {
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
