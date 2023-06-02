import 'package:flutter/material.dart';
import 'package:front/ui/register/uiregister_babysiter.dart';

import '../tutor/home_tutor.dart';
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
int selectedRole = -1;

class SignUp extends StatelessWidget {
  const SignUp({super.key});

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
                    child: CityDropdown(),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: RoleSelector(
                      onRoleSelected: (int role) {
                        selectedRole = role;
                      },
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

void registerButtonFunction(BuildContext context) {
  if (_nameController.text.isNotEmpty &&
      _lastnameController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty &&
      _phonecontroller.text.isNotEmpty &&
      _addresscontroller.text.isNotEmpty &&
      _emailController.text.isNotEmpty &&
      _conpasswordcontroller.text.isNotEmpty &&
      selectedRole != -1) {
    if (selectedRole == 1) {
      // Navigating to RegisterB() if user selected the 'Niñer@' role
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => RegisterB()));
    } else {
      // Navigating to HomeT() if user selected the 'Tutor' role
      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeT()));
    }
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content:
              Text('Por favor, llena todos los campos y selecciona un rol')),
    );
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



//ECF2FF
//#FFFACD
//#A2D5F2
//#FFB6C1

//2
//#89CFF0

