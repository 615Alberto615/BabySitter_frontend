import 'package:flutter/material.dart';

class formTextField extends StatelessWidget {
  final TextEditingController _controller;

  formTextField({required TextEditingController controller})
      : _controller = controller;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(196, 135, 198, .3),
                blurRadius: 20,
                offset: Offset(0, 10),
              )
            ],
          ),
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              icon: Icon(Icons.medication_sharp, color: HexColor("20262E")),
              hintText: 'El niño necesita algún medicamento?',
              labelText: "Medicamentos",
              hintStyle: TextStyle(
                color: HexColor("20262E"),
                fontSize: 12,
              ),
              labelStyle: TextStyle(
                color: HexColor("20262E"),
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(10.0),
            ),
            onChanged: (value) {},
          ),
        );
      },
    );
  }
}

class formTextField2 extends StatelessWidget {
  final TextEditingController _controller;

  formTextField2({required TextEditingController controller})
      : _controller = controller;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(196, 135, 198, .3),
                blurRadius: 20,
                offset: Offset(0, 10),
              )
            ],
          ),
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              icon: Icon(Icons.sick, color: HexColor("20262E")),
              hintText: 'El niño tiene alguna enfermedad y/o alergia?',
              labelText: "Enfermedad y/o Alergia",
              hintStyle: TextStyle(
                color: HexColor("20262E"),
                fontSize: 10,
              ),
              labelStyle: TextStyle(
                color: HexColor("20262E"),
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(10.0),
            ),
            onChanged: (value) {},
          ),
        );
      },
    );
  }
}

class formTextField3 extends StatelessWidget {
  final TextEditingController _controller;

  formTextField3({required TextEditingController controller})
      : _controller = controller;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(196, 135, 198, .3),
                blurRadius: 20,
                offset: Offset(0, 10),
              )
            ],
          ),
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              icon: Icon(Icons.medical_services, color: HexColor("20262E")),
              hintText: 'Donde se encuentra el botiquin/medicamentos?',
              labelText: "Botiquin y/o Medicamentos",
              hintStyle: TextStyle(
                color: HexColor("20262E"),
                fontSize: 10,
              ),
              labelStyle: TextStyle(
                color: HexColor("20262E"),
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(10.0),
            ),
            onChanged: (value) {},
          ),
        );
      },
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
