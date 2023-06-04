import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class fildform extends StatelessWidget {
  final TextEditingController _controller;
  final String hint;
  final String label;
  final IconData icon;

  fildform(
      {required TextEditingController controller,
      required this.hint,
      required this.label,
      required this.icon})
      : _controller = controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      decoration: _decoration,
      child: TextField(
        controller: _controller,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          icon: Icon(icon, color: HexColor("20262E")),
          hintText: hint,
          labelText: label,
          hintStyle: _textStyle,
          labelStyle: _textStyle,
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(10.0),
        ),
      ),
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
