import 'package:flutter/material.dart';

class MedicalForm extends StatefulWidget {
  final ValueChanged<String> onFieldChanged;

  MedicalForm({required this.onFieldChanged});

  @override
  _MedicalFormState createState() => _MedicalFormState();
}

class _MedicalFormState extends State<MedicalForm> {
  bool tieneEnfermedad = false;
  final TextEditingController enfermedadController = TextEditingController();

  @override
  void initState() {
    super.initState();
    enfermedadController.addListener(() {
      widget.onFieldChanged(enfermedadController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text('El niño tiene alguna enfermedad y/o alergia?'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('No'),
              Radio<bool>(
                value: false,
                groupValue: tieneEnfermedad,
                onChanged: (value) {
                  setState(() {
                    tieneEnfermedad = value!;
                    if (!tieneEnfermedad) {
                      enfermedadController.text = '';
                    }
                    widget.onFieldChanged(enfermedadController.text);
                  });
                },
              ),
              Text('Sí'),
              Radio<bool>(
                value: true,
                groupValue: tieneEnfermedad,
                onChanged: (value) {
                  setState(() {
                    tieneEnfermedad = value!;
                  });
                },
              ),
            ],
          ),
        ),
        if (tieneEnfermedad)
          TextField(
            controller: enfermedadController,
            decoration: InputDecoration(
              labelText: 'Especifique',
            ),
          ),
      ],
    );
  }
}

class MedicalForm2 extends StatefulWidget {
  final ValueChanged<String> onFieldChanged;

  MedicalForm2({required this.onFieldChanged});

  @override
  _MedicalFormState2 createState() => _MedicalFormState2();
}

class _MedicalFormState2 extends State<MedicalForm2> {
  bool tieneEnfermedad = false;
  final TextEditingController enfermedadController = TextEditingController();

  @override
  void initState() {
    super.initState();
    enfermedadController.addListener(() {
      widget.onFieldChanged(enfermedadController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text('El niño necesita algún medicamento?'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('No'),
              Radio<bool>(
                value: false,
                groupValue: tieneEnfermedad,
                onChanged: (value) {
                  setState(() {
                    tieneEnfermedad = value!;
                    if (!tieneEnfermedad) {
                      enfermedadController.text = '';
                    }
                    widget.onFieldChanged(enfermedadController.text);
                  });
                },
              ),
              Text('Sí'),
              Radio<bool>(
                value: true,
                groupValue: tieneEnfermedad,
                onChanged: (value) {
                  setState(() {
                    tieneEnfermedad = value!;
                  });
                },
              ),
            ],
          ),
        ),
        if (tieneEnfermedad)
          TextField(
            controller: enfermedadController,
            decoration: InputDecoration(
              labelText: 'Especifique',
            ),
          ),
      ],
    );
  }
}

class mediubTextField extends StatefulWidget {
  final ValueChanged<String> onFieldChanged;

  mediubTextField({required this.onFieldChanged});

  @override
  _mediubTextFieldState createState() => _mediubTextFieldState();
}

class _mediubTextFieldState extends State<mediubTextField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      widget.onFieldChanged(_controller.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120.0,
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      decoration: _decoration,
      child: TextField(
        controller: _controller,
        maxLines: 3,
        decoration: InputDecoration(
          isDense: true,
          icon: Icon(Icons.home, color: HexColor("20262E")),
          hintText:
              'Ubicacion medicamentos y/o botiquin de emergencias en su casa',
          labelText: "Ubicacion medicamentos y/o botiquin.",
          hintStyle: _textStyle,
          labelStyle: _textStyle,
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(10.0),
        ),
      ),
    );
  }
}

// Resto de tu código

TextStyle _textStyle = TextStyle(
  color: HexColor("20262E"),
);

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

BoxDecoration _decoration = BoxDecoration(
  borderRadius: BorderRadius.circular(20),
  color: Colors.white,
  boxShadow: [
    BoxShadow(
      color: Color.fromRGBO(196, 135, 198, .3),
      blurRadius: 20,
      offset: Offset(0, 10),
    )
  ],
);
