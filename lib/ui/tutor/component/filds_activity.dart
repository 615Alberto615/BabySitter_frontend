import 'package:flutter/material.dart';

class Activity {
  final String title;
  bool value;

  Activity({required this.title, this.value = false});
}

class ActivitiesForm extends StatefulWidget {
  final ValueChanged<List<bool>> onFieldChanged;
  final List<bool> initialActivities;

  ActivitiesForm(
      {required this.onFieldChanged, required this.initialActivities});

  @override
  _ActivitiesFormState createState() => _ActivitiesFormState();
}

class _ActivitiesFormState extends State<ActivitiesForm> {
  @override
  void initState() {
    super.initState();
    // Inicializar activities con los valores de widget.initialActivities
    for (int i = 0; i < activities.length; i++) {
      activities[i].value = widget.initialActivities[i];
    }
  }

  List<Activity> activities = [
    Activity(title: '1)	Juegos de mesa'),
    Activity(title: '2)	Artes y manualidades'),
    Activity(title: '3)	Lectura de libros'),
    Activity(title: '4)	Cocina y repostería'),
    Activity(title: '5)	Actividades al aire libre'),
    Activity(title: '6)	Construcción con bloques'),
    Activity(title: '7)	Juegos de roles'),
    Activity(title: '8)	Música y baile'),
    Activity(title: '9) Jugar videojuegos'),
    Activity(title: '10) Jardinería'),
    Activity(title: '11) Construcción de fortalezas'),
    Activity(title: '12) Películas y programas de televisión'),
    Activity(title: 'Ninguna de las anteriores'),
    // Añade más actividades si necesitas
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Actividades a realizar',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: activities.length,
          itemBuilder: (context, index) {
            return CheckboxListTile(
              title: Text(activities[index].title),
              value: activities[index].value,
              onChanged: (bool? value) {
                setState(() {
                  activities[index].value = value ?? false;
                });
                widget.onFieldChanged(
                    activities.map((activity) => activity.value).toList());
              },
            );
          },
        ),
      ],
    );
  }
}
