import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NameTextFieldB extends StatelessWidget {
  final TextEditingController _controller;

  NameTextFieldB({required TextEditingController controller})
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
              icon: Icon(Icons.child_care, color: HexColor("20262E")),
              hintText: 'Nombre niñ@',
              labelText: "Nombre niñ@",
              hintStyle: TextStyle(
                color: HexColor("20262E"),
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

class FNTextField extends StatelessWidget {
  final TextEditingController _controller;

  FNTextField({required TextEditingController controller})
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
              icon: Icon(Icons.calendar_month, color: HexColor("20262E")),
              hintText: 'dd/mm/aaaa',
              labelText: "Fecha de Nacimiento",
              hintStyle: TextStyle(
                color: HexColor("20262E"),
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
