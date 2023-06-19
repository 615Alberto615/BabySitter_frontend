import 'package:flutter/material.dart';
import 'package:front/cubit/user_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/models/modelo_usuario.dart';
import '../../component/bottoms.dart';
import '../../component/filds_forms.dart';
import '../register/components/filds_signup.dart';
import 'component/img_top2.dart';

int selectedCityId = 4; // Predeterminado a 'La Paz'

class PerfilScreen extends StatefulWidget {
  final int tutorId;
  final int userId;
  const PerfilScreen({Key? key, required this.tutorId, required this.userId})
      : super(key: key);
  @override
  _PerfilScreenState createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController adressController = TextEditingController();

  @override
  void initState() {
    print('Tutor ID: ${widget.userId}');
    context.read<UsuarioCubit>().fetchUsuario(
        'http://10.0.2.2:8080/api/v1/user/', widget.userId.toString());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UsuarioCubit, UsuarioState>(listener: (context, state) {
      // Aquí puedes manejar los estados que impliquen un cambio de pantalla o la
      // aparición de diálogos/snackbars
    }, builder: (context, state) {
      if (state is UsuarioLoading) {
        return CircularProgressIndicator();
      } else if (state is UsuarioLoaded) {
        usuario user = state.usuarios[0];
        nameController.text = user.userName;
        lastNameController.text = user.userLastname;
        emailController.text = user.userEmail;
        phoneController.text = user.userPhone;
        adressController.text = user.userAddress;
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: ListView(
            padding: EdgeInsets.all(20),
            children: [
              myfam4(),
              Text(' Datos del perfil',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: HexColor('#20262E'))),
              SizedBox(height: 30),
              Text('   Actualiza tus datos',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: HexColor('#20262E'))),
              SizedBox(height: 30),
              fildform(
                controller: nameController,
                hint: 'Introduce tu nombre',
                label: 'Nombre',
                icon: Icons.person,
              ),
              SizedBox(height: 20),
              fildform(
                controller: lastNameController,
                hint: 'Introduce tu Apellido',
                label: 'Apellido',
                icon: Icons.person,
              ),
              SizedBox(height: 20),
              fildform(
                controller: emailController,
                hint: 'introdece tu correo',
                label: 'Correo',
                icon: Icons.email,
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
                controller: adressController,
                hint: 'Introdece tu direccion',
                label: 'Direccion',
                icon: Icons.location_city,
              ),
              SizedBox(height: 20),
              PerfilButton(
                text: 'Actualizar Datos ',
                onPressed: () {
                  // Aquí puedes agregar la funcionalidad que necesitas para cuando se presione el botón
                },
              ),
            ],
          ),
        );
      } else {
        // Asegúrate de manejar todos los estados posibles, incluyendo error o inicial.
        return Container();
      }
    });
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
