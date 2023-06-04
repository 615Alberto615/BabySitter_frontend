import 'package:flutter/material.dart';

import '../../component/bottoms.dart';
import '../../component/filds_forms.dart';

class PerfilScreen extends StatefulWidget {
  const PerfilScreen({Key? key}) : super(key: key);
  @override
  _PerfilScreenState createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          fildform(
            controller: nameController,
            hint: 'Introduce tu nombre',
            label: 'Nombre',
            icon: Icons.person,
          ),
          SizedBox(height: 20),
          fildform(
            controller: phoneController,
            hint: 'Introduce tu teléfono',
            label: 'Teléfono',
            icon: Icons.phone,
          ),
          SizedBox(height: 20),
          fildform(
            controller: cityController,
            hint: 'Introduce tu ciudad',
            label: 'Ciudad',
            icon: Icons.location_city,
          ),
          SizedBox(height: 20),
          CustomButton(
            onPressed: () {
              // Aquí colocas la lógica para guardar la información.
              // Por ejemplo, puedes guardar los datos en una base de datos o hacer una petición HTTP para guardarlos en un servidor.
            },
            text: 'Guardar Cambios',
            icon: Icons.save,
          ),
        ],
      ),
    );
  }
}
