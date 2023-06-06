import 'package:flutter/material.dart';

import '../../component/bottoms.dart';
import '../../component/filds_forms.dart';
import '../register/components/filds_babysitter.dart';
import '../register/components/filds_signup.dart';
import '../tutor/component/img_top2.dart';

int selectedCityId = 4; // Predeterminado a 'La Paz'

class PerfilScreenB extends StatefulWidget {
  const PerfilScreenB({Key? key}) : super(key: key);
  @override
  _PerfilScreenState createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreenB> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _desController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
        backgroundColor: HexColor("#9695ff"),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          myfam4(),
          Text('Datos del perfil',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: HexColor('#20262E'))),
          SizedBox(height: 30),
          fildform(
            controller: _nameController,
            hint: 'Introduce tu nombre',
            label: 'Nombre',
            icon: Icons.person,
          ),
          SizedBox(height: 20),
          fildform(
            controller: _phoneController,
            hint: 'Introduce tu teléfono',
            label: 'Teléfono',
            icon: Icons.phone,
          ),
          SizedBox(height: 20),
          CityDropdown(
            initialCityId: selectedCityId,
            onCitySelected: (int cityId) {
              selectedCityId = cityId;
            },
          ),
          SizedBox(height: 20),
          DescriptionField(
            controller: _desController,
          ),
          SizedBox(height: 20),
          PerfilButton(
            text: 'Actualizar Perfil',
            onPressed: () {
              // Aquí puedes agregar la funcionalidad que necesitas para cuando se presione el botón
            },
          ),
        ],
      ),
    );
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

class PerfilButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  PerfilButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 50,
        margin: EdgeInsets.symmetric(horizontal: 60),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: HexColor("#9695ff"),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(196, 135, 198, .3),
              blurRadius: 20,
              offset: Offset(0, 10),
            )
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
