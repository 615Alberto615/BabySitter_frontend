import 'package:flutter/material.dart';
import 'package:front/ui/register/uiregister_babysiter.dart';

import '../../service/ApiService.dart';
import '../babysitter/home_babysiiter.dart';
import '../login/uiLogin.dart';
import '../tutor/home_tutor.dart';
import '../tutor/mainT.dart';
import 'components/filds_babysitter.dart';
import 'components/filds_signup.dart';
import 'components/login.dart';
import 'components/sign_up_top_image.dart';

final _nameController = TextEditingController();
final _passwordController = TextEditingController();
final _lastnameController = TextEditingController();
final _phonecontroller = TextEditingController();
final _addresscontroller = TextEditingController();
final _emailController = TextEditingController();
final _conpasswordcontroller = TextEditingController();

int _selectedRole = -1;
int _selectedCityId = 4;
final _ciController = TextEditingController();
final _extController = TextEditingController();
final _contactNumberController = TextEditingController();
final _descriptionController = TextEditingController();

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 400,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: -40,
                    height: 400,
                    width: width,
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/f1v.png'),
                              fit: BoxFit.fill)),
                    ),
                  ),
                  Positioned(
                    height: 400,
                    width: width + 20,
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/f2a.png'),
                              fit: BoxFit.fill)),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      child: Text(
                    "Registro",
                    style: TextStyle(
                        color: Color.fromRGBO(49, 39, 79, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  )),
                  SizedBox(
                    height: 30,
                  ),
                  NameTextField(controller: _nameController),
                  SizedBox(
                    height: 20,
                  ),
                  LastNameTextField(controller: _lastnameController),
                  SizedBox(
                    height: 20,
                  ),
                  PhoneTextField(controller: _phonecontroller),
                  SizedBox(
                    height: 20,
                  ),
                  AddressTextField(controller: _addresscontroller),
                  SizedBox(
                    height: 20,
                  ),
                  EmailTextField(controller: _emailController),
                  SizedBox(
                    height: 20,
                  ),
                  PasswordTextField(controller: _passwordController),
                  SizedBox(
                    height: 30,
                  ),
                  ConfirmPasswordTextField(controller: _conpasswordcontroller),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: CityDropdown(
                      initialCityId: _selectedCityId,
                      onCitySelected: (int cityId) {
                        setState(() {
                          _selectedCityId = cityId;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: RoleSelector(
                      onRoleSelected: (int role) {
                        setState(() {
                          _selectedRole = role;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Visibility(
                    visible: _selectedRole ==
                        1, // Mostrar solo cuando el rol seleccionado es 'Niñera'
                    child: Column(
                      children: [
                        CarnetAndExtensionFields(
                          ciController: _ciController,
                          extController: _extController,
                        ),
                        SizedBox(height: 20),
                        ContactNumberField(
                            controller: _contactNumberController),
                        SizedBox(height: 20),
                        DescriptionField(controller: _descriptionController),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
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
                      child: RegisterButton(),
                    ),
                  )),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                      child: Center(
                    child: IniciarSesionButton(),
                  )),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

void registerButtonFunction(BuildContext context) async {
  if (_nameController.text.isNotEmpty &&
      _lastnameController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty &&
      _phonecontroller.text.isNotEmpty &&
      _addresscontroller.text.isNotEmpty &&
      _emailController.text.isNotEmpty &&
      _conpasswordcontroller.text.isNotEmpty &&
      _selectedRole != -1) {
    if (!isValidEmail(_emailController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Por favor, introduce un correo electrónico válido')));
      return;
    }
    if (!isValidPhoneNumber(_phonecontroller.text)) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Por favor, introduce un número de teléfono válido en Bolivia')));
      return;
    }
    try {
      var userData = {
        "userName": _nameController.text,
        "userLastname": _lastnameController.text,
        "userPhone": _phonecontroller.text,
        "userAddres": _addresscontroller.text,
        "userEmail": _emailController.text,
        "userSecret": _passwordController.text,
        "seLocationId": _selectedCityId,
        "CI": _ciController.text,
        "extension": _extController.text,
        "phoneContact": _contactNumberController.text,
        "description": _descriptionController.text,
      };

      Map<String, dynamic> response =
          await ApiService().registerUser(userData, _selectedRole == 1);

      if (response["code"] == 200) {
        // Mostrar un mensaje de éxito
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Registrado satisfactoriamente')));

        // Limpiar todos los campos del formulario

        if (_selectedRole == 1) {
          // Navigating to RegisterB() if user selected the 'Niñer@' role
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Login()));
          _nameController.clear();
          _lastnameController.clear();
          _passwordController.clear();
          _phonecontroller.clear();
          _addresscontroller.clear();
          _emailController.clear();
          _conpasswordcontroller.clear();
          _ciController.clear();
          _descriptionController.clear();
          // Restablecer la ciudad y el rol seleccionado a sus valores predeterminados
          _selectedRole = -1;
          _selectedCityId = 4;
        } else {
          // Navigating to HomeT() if user selected the 'Tutor' role
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Login()));
          _nameController.clear();
          _lastnameController.clear();
          _passwordController.clear();
          _phonecontroller.clear();
          _addresscontroller.clear();
          _emailController.clear();
          _conpasswordcontroller.clear();
          _ciController.clear();
          _contactNumberController.clear();
          _descriptionController.clear();
          // Restablecer la ciudad y el rol seleccionado a sus valores predeterminados
          _selectedRole = -1;
          _selectedCityId = 4;
        }
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(response["message"])));
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Hubo un error al registrarse')));
    }
  } else {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content:
            Text('Por favor, llena todos los campos y selecciona un rol')));
  }
}

class RegisterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        registerButtonFunction(context);
      },
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
            "Registrarse",
            style: TextStyle(color: Colors.white),
          ),
        ),
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
