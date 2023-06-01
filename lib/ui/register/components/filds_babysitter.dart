import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CarnetNumberField extends StatelessWidget {
  final TextEditingController _controller;

  CarnetNumberField({required TextEditingController controller})
      : _controller = controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      decoration: _decoration,
      child: TextField(
        controller: _controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          icon: Icon(Icons.credit_card, color: HexColor("20262E")),
          hintText: 'CI',
          labelText: "CI",
          hintStyle: _textStyle,
          labelStyle: _textStyle,
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(10.0),
        ),
      ),
    );
  }
}

class ExtensionDropdown extends StatefulWidget {
  final TextEditingController controller;

  ExtensionDropdown({required this.controller});

  @override
  _ExtensionDropdownState createState() => _ExtensionDropdownState();
}

class _ExtensionDropdownState extends State<ExtensionDropdown> {
  String dropdownValue = 'LP';

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        decoration: _decoration,
        child: DropdownButton<String>(
          value: dropdownValue,
          icon: const Icon(Icons.arrow_downward),
          iconSize: 24,
          style: TextStyle(color: HexColor("20262E")),
          onChanged: (String? newValue) {
            setState(() {
              dropdownValue = newValue!;
            });
            widget.controller.text =
                newValue!; // actualiza el controlador del texto
          },
          items: <String>[
            'LP',
            'OR',
            'PT',
            'CB',
            'SC',
            'BN',
            'PD',
            'CH',
            'TJ',
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ));
  }
}

class CarnetAndExtensionFields extends StatelessWidget {
  final TextEditingController ciController;
  final TextEditingController extController;

  CarnetAndExtensionFields({
    required this.ciController,
    required this.extController,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CarnetNumberField(controller: ciController),
        ),
        SizedBox(width: 10), // Add some space between the fields
        Expanded(
          child: ExtensionDropdown(controller: extController),
        ),
      ],
    );
  }
}

class ContactNumberField extends StatelessWidget {
  final TextEditingController _controller;

  ContactNumberField({required TextEditingController controller})
      : _controller = controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      decoration: _decoration,
      child: TextField(
        controller: _controller,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          icon: Icon(Icons.phone, color: HexColor("20262E")),
          hintText: 'Número de Contacto',
          labelText: "Número de Contacto",
          hintStyle: _textStyle,
          labelStyle: _textStyle,
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(10.0),
        ),
      ),
    );
  }
}

class DescriptionField extends StatelessWidget {
  final TextEditingController _controller;

  DescriptionField({required TextEditingController controller})
      : _controller = controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      decoration: _decoration,
      child: TextField(
        controller: _controller,
        maxLines: 5, // Increase this value to make the field larger
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          icon: Icon(Icons.description, color: HexColor("20262E")),
          hintText: 'Descripción',
          labelText: "Descripción",
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
