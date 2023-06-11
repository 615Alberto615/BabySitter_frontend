import 'package:flutter/material.dart';
import 'package:front/cubit/login_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/cubit/login_state.dart';
import 'package:front/models/modelo_token.dart';

import '../../component/bottoms.dart';
import '../babysitter/home_babysiiter.dart';
import '../tutor/mainT.dart';
import 'components/signup.dart';
import 'components/user.dart';

//LO DEMAS

final _userController = TextEditingController();
final _passwordController = TextEditingController();

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginCubit loginCubit = BlocProvider.of<LoginCubit>(context);
    final width = MediaQuery.of(context).size.width;
    return WillPopScope(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state.isSuccess) {
              if (state.userData != null) {
                final userId = state.userData!['userId'];
                final seRoleId = state.userData!['seRoleId'];
                final token = state.userData!['token'];
                //print(token);
                ModeloToken.token = token;
                String? tk = ModeloToken.token;
                /*print("Persistencia del toke: $tk");
                print(userId);
                print(seRoleId);*/
                // 1 es Tutor, 2 el Niñera
                if (seRoleId == 1) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MainScreen(
                                userId: userId,
                              )));
                  _passwordController.clear();
                  _userController.clear();
                } else if (seRoleId == 2) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MainScreenBs(
                                userId: userId,
                                seRoleId: seRoleId,
                              )));
                  _passwordController.clear();
                  _userController.clear();
                }
              } else if (state.userData == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        'Usuario o contraseña incorrectos. Intente denuevo por favor.'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            } else {
              print("Error en la Api");
            }
          },
          child: SingleChildScrollView(
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
                        "Iniciar sesión",
                        style: TextStyle(
                            color: Color.fromRGBO(49, 39, 79, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      )),
                      SizedBox(
                        height: 30,
                      ),
                      UserTextField(controller: _userController),
                      SizedBox(
                        height: 20,
                      ),
                      PasswordTextField(controller: _passwordController),
                      SizedBox(
                        height: 30,
                      ),
                      InkWell(
                        onTap: () {
                          if (_userController.text.isNotEmpty &&
                              _passwordController.text.isNotEmpty) {
                            loginCubit.loginUser(
                                _userController.text, _passwordController.text);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      'Por favor complete todos los campos')),
                            );
                          }
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
                              "Iniciar sesión",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                          child: Center(
                        child: RegistrarseButton(),
                      )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      onWillPop: () async {
        return false;
      },
    );
  }

  void verifyAndLogin(BuildContext context) {
    if (_userController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      /*
      Navigator.push(
        
      );*/
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor complete todos los campos')),
      );
    }
  }
}





//ECF2FF
//#FFFACD
//#A2D5F2
//#FFB6C1

//2
//#89CFF0