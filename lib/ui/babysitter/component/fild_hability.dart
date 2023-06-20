import 'package:flutter/material.dart';

class hability {
  final String title;
  bool value;

  hability({required this.title, this.value = false});
}

class ActivitiesForm extends StatefulWidget {
  final ValueChanged<List<bool>> onFieldChanged;

  ActivitiesForm({required this.onFieldChanged});

  @override
  _ActivitiesFormState createState() => _ActivitiesFormState();
}

class _ActivitiesFormState extends State<ActivitiesForm> {
  List<hability> activities = [
    hability(title: '1)	Conocimientos sobre el desarrollo infantil'),
    hability(title: '2)	Empatía y paciencia'),
    hability(title: '3)	Comunicación efectiva'),
    hability(title: '4)	Habilidades de organización'),
    hability(title: '5)	Flexibilidad y adaptabilidad'),
    hability(title: '6)	Conocimientos de primeros auxilios'),
    hability(title: '7)	Sensibilidad cultural'),
    hability(title: '8)	Habilidades de resolución de conflictos'),
    hability(title: '9)	Creatividad'),
    hability(title: '10)	Conocimiento de necesidades especiales'),
    hability(title: '11)	Observación atenta'),
    hability(title: '12)	Gusto por la enseñanza'),
    hability(title: 'Ninguna de las anteriores'),
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
