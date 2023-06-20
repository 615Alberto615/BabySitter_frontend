import 'package:flutter/material.dart';
import 'package:front/cubit/user_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/models/modelo_usuario.dart';
import 'package:front/ui/babysitter/home_babysiiter.dart';
import 'package:front/ui/tutor/mainT.dart';
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
    print(' ID: ${widget.userId}');
    print('tutor  ID: ${widget.tutorId}');
    context.read<UsuarioCubit>().fetchUsuario(
        'http://10.0.2.2:8080/api/v1/user/', widget.userId.toString());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UsuarioCubit, UsuarioState>(listener: (context, state) {
      if (state is UsuarioError) {
        // Muestra un mensaje de error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(state.message)),
        );
      } else if (state is UsuarioUpdated) {
        // Muestra un mensaje de éxito y navega a la pantalla principal
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registro modificado exitosamente')),
        );
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MainScreen(
                    userId: widget.userId,
                  )),
        );
      }
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
              myfam9(),
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
                onPressed: () async {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        backgroundColor: HexColor("#9695ff"),
                        child: Container(
                          padding: EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Modificar Datos de Perfil',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 20.0),
                              Text(
                                  'Estás seguro que quieres modificar tus datos?'),
                              SizedBox(height: 20.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  TextButton(
                                    child: Text(
                                      'Cancelar',
                                      style: TextStyle(
                                        color: Colors
                                            .white, // Color de texto personalizado
                                      ),
                                    ),
                                    onPressed: () {
                                      // Cerrar el AlertDialog
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: Text(
                                      'Modificar',
                                      style: TextStyle(
                                        color: Colors
                                            .white, // Color de texto personalizado
                                      ),
                                    ),
                                    onPressed: () async {
                                      try {
                                        if (nameController.text.isNotEmpty &&
                                            lastNameController
                                                .text.isNotEmpty &&
                                            emailController.text.isNotEmpty &&
                                            phoneController.text.isNotEmpty &&
                                            adressController.text.isNotEmpty) {
                                          if (!isValidEmail(
                                              emailController.text)) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                                        'Por favor, introduce un correo electrónico válido')));
                                            return;
                                          }
                                          if (!isValidPhoneNumber(
                                              phoneController.text)) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                                        'Por favor, introduce un número de teléfono válido en Bolivia')));
                                            return;
                                          }
                                          Map<String, dynamic> requestBody = {
                                            'userId': widget.userId.toString(),
                                            'seLocationId':
                                                user.seLocationId.toString(),
                                            'userName': nameController.text,
                                            'userLastname':
                                                lastNameController.text,
                                            'userEmail': emailController.text,
                                            'userAddres': adressController.text,
                                            'userPhone': phoneController.text,
                                            'userSecret':
                                                user.userSecret.toString(),
                                            'userStatus':
                                                user.userStatus.toString(),
                                          };
                                          context
                                              .read<UsuarioCubit>()
                                              .updateUsuario(
                                                  'http://10.0.2.2:8080/api/v1/user/',
                                                  widget.userId.toString(),
                                                  requestBody);
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                                content: Text(
                                                    'Por favor, llena todos los campos')),
                                          );
                                        }
                                      } catch (e) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                              content: Text(
                                                  'Formato de fecha incorrecto. Por favor ingrese la fecha en formato aaaa/mm/dd')),
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        );
      } else {
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

bool isValidEmail(String email) {
  final RegExp regex = RegExp(
      r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+'); // Una simple regex para validar el email.
  return regex.hasMatch(email);
}

bool isValidPhoneNumber(String phoneNumber) {
  final RegExp regex = RegExp(
      r'^[67]\d{7}$'); // Regex que verifica si el número tiene 8 dígitos y comienza con 6 o 7.
  return regex.hasMatch(phoneNumber);
}
