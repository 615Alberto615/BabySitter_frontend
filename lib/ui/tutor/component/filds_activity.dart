import 'package:flutter/material.dart';

class Activity {
  final String title;
  bool value;

  Activity({required this.title, this.value = false});
}

class ActivitiesForm extends StatefulWidget {
  final ValueChanged<List<String>> onFieldChanged;

  ActivitiesForm({required this.onFieldChanged});

  @override
  _ActivitiesFormState createState() => _ActivitiesFormState();
}

class _ActivitiesFormState extends State<ActivitiesForm> {
  List<Activity> activities = [
    Activity(title: 'Cantar'),
    Activity(title: 'Dibujar'),
    Activity(title: 'Leer'),
    Activity(title: 'Jugar Videojuegos'),
    Activity(title: 'Ninguna de las anteriores'),
    // Añade más actividades si necesitas
  ];

  @override
  void initState() {
    super.initState();
  }

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
                  activities[index].value = value!;
                });
                widget.onFieldChanged(activities
                    .where((activity) => activity.value)
                    .map((activity) => activity.title)
                    .toList());
              },
            );
          },
        ),
      ],
    );
  }
}
