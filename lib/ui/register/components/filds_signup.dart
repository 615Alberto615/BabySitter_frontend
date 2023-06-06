import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NameTextField extends StatelessWidget {
  final TextEditingController _controller;

  NameTextField({required TextEditingController controller})
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
              icon: Icon(Icons.person, color: HexColor("20262E")),
              hintText: 'Nombre',
              labelText: "Nombre",
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

class LastNameTextField extends StatelessWidget {
  final TextEditingController _controller;

  LastNameTextField({required TextEditingController controller})
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
              icon: Icon(Icons.person, color: HexColor("20262E")),
              hintText: 'Apellido',
              labelText: "Apellido",
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

class EmailTextField extends StatelessWidget {
  final TextEditingController _controller;

  EmailTextField({required TextEditingController controller})
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
              icon: Icon(Icons.person, color: HexColor("20262E")),
              hintText: 'Correo electrónico',
              labelText: "Correo electrónico",
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

class PasswordTextField extends StatefulWidget {
  final TextEditingController _controller;

  PasswordTextField({required TextEditingController controller})
      : _controller = controller;

  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          decoration: _decoration,
          child: TextField(
            controller: widget._controller,
            obscureText: _obscureText,
            decoration: InputDecoration(
              icon: Icon(Icons.lock, color: HexColor("20262E")),
              hintText: 'Contraseña',
              labelText: "Contraseña",
              hintStyle: _textStyle,
              labelStyle: _textStyle,
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(10.0),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                  color: HexColor("20262E"),
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              ),
            ),
            onChanged: (value) {},
          ),
        );
      },
    );
  }
}

class PhoneTextField extends StatelessWidget {
  final TextEditingController _controller;

  PhoneTextField({required TextEditingController controller})
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
          icon: Icon(Icons.phone, color: HexColor("20262E")),
          hintText: 'Teléfono',
          labelText: "Teléfono",
          hintStyle: _textStyle,
          labelStyle: _textStyle,
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(10.0),
        ),
        onChanged: (value) {},
      ),
    );
  }
}

class ConfirmPasswordTextField extends StatefulWidget {
  final TextEditingController _controller;

  ConfirmPasswordTextField({required TextEditingController controller})
      : _controller = controller;

  @override
  _ConfirmPasswordTextFieldState createState() =>
      _ConfirmPasswordTextFieldState();
}

class _ConfirmPasswordTextFieldState extends State<ConfirmPasswordTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      decoration: _decoration,
      child: TextField(
        controller: widget._controller,
        obscureText: _obscureText,
        decoration: InputDecoration(
          icon: Icon(Icons.lock, color: HexColor("20262E")),
          hintText: 'Confirmar Contraseña',
          labelText: "Confirmar Contraseña",
          hintStyle: _textStyle,
          labelStyle: _textStyle,
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(10.0),
          suffixIcon: IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility : Icons.visibility_off,
              color: HexColor("20262E"),
            ),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          ),
        ),
        onChanged: (value) {},
      ),
    );
  }
}

class AddressTextField extends StatelessWidget {
  final TextEditingController _controller;

  AddressTextField({required TextEditingController controller})
      : _controller = controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      decoration: _decoration,
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
          icon: Icon(Icons.home, color: HexColor("20262E")),
          hintText: 'Dirección',
          labelText: "Dirección",
          hintStyle: _textStyle,
          labelStyle: _textStyle,
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(10.0),
        ),
        onChanged: (value) {},
      ),
    );
  }
}

/*
class CityDropdown extends StatefulWidget {
  CityDropdown({Key? key}) : super(key: key);

  @override
  _CityDropdownState createState() => _CityDropdownState();
}

class _CityDropdownState extends State<CityDropdown> {
  String dropdownValue = 'La Paz';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        children: <Widget>[
          Text(
            'Selecciona tu localidad:       ',
            style: TextStyle(color: HexColor("20262E")),
          ),
          DropdownButton<String>(
            value: dropdownValue,
            icon: const Icon(Icons.arrow_downward),
            iconSize: 24,
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue!;
              });
            },
            items: <String>[
              'Beni',
              'Chuquisaca',
              'Cochabamba',
              'La Paz',
              'Oruro',
              'Pando',
              'Potosí',
              'Santa Cruz',
              'Tarija',
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}*/
class CityDropdown extends StatefulWidget {
  final void Function(int) onCitySelected;
  final int initialCityId;

  CityDropdown({Key? key, required this.onCitySelected, this.initialCityId = 4})
      : super(key: key);

  @override
  _CityDropdownState createState() => _CityDropdownState();
}

class _CityDropdownState extends State<CityDropdown> {
  final Map<String, int> cityIds = {
    'Beni': 1,
    'Chuquisaca': 2,
    'Cochabamba': 3,
    'La Paz': 4,
    'Oruro': 5,
    'Pando': 6,
    'Potosí': 7,
    'Santa Cruz': 8,
    'Tarija': 9,
  };

  late String dropdownValue;

  @override
  void initState() {
    super.initState();
    dropdownValue = cityIds.keys.firstWhere(
        (key) => cityIds[key] == widget.initialCityId,
        orElse: () => 'La Paz');
  }

  @override
  Widget build(BuildContext context) {
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
      child: Row(
        children: <Widget>[
          Icon(Icons.location_city, color: HexColor("20262E")),
          SizedBox(width: 10),
          Text(
            'Localidad:     ',
            style: TextStyle(color: HexColor("20262E")),
          ),
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                value: dropdownValue,
                icon: const Icon(Icons.arrow_downward),
                iconSize: 24,
                style: TextStyle(color: HexColor("20262E")),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                  widget.onCitySelected(cityIds[dropdownValue] ?? 4);
                },
                items:
                    cityIds.keys.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class RoleSelector extends StatefulWidget {
  final ValueChanged<int> onRoleSelected;

  // Haz que el parámetro onRoleSelected sea requerido.
  RoleSelector({required this.onRoleSelected});

  @override
  _RoleSelectorState createState() => _RoleSelectorState();
}

class _RoleSelectorState extends State<RoleSelector> {
  final List<bool> _isSelected = [false, false];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
          child: Text(
            'Elige tu rol',
            style: TextStyle(
              color: HexColor("20262E"),
              fontSize: 18,
            ),
          ),
        ),
        ToggleButtons(
          borderColor: HexColor("20262E"),
          fillColor: HexColor("20262E"),
          borderWidth: 1,
          selectedBorderColor: HexColor("20262E"),
          selectedColor: Colors.white,
          borderRadius: BorderRadius.circular(10),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                'Tutor',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                'Niñer@',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
          onPressed: (int newIndex) {
            setState(() {
              for (int index = 0; index < _isSelected.length; index++) {
                if (index == newIndex) {
                  _isSelected[index] = true;
                } else {
                  _isSelected[index] = false;
                }
              }
            });
            if (widget.onRoleSelected != null) {
              widget.onRoleSelected(
                  newIndex); // llama a la función de devolución de llamada
            }
          },
          isSelected: _isSelected,
        ),
      ],
    );
  }
}

int selectedRole = -1; // -1 indica que el usuario no ha seleccionado nada aún

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
