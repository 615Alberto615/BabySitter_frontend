import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:front/ui/register/components/filds_babysitter.dart';

import '../../../cubit/child_cubit.dart';
import '../../babysitter/home_babysiiter.dart';
import '../component/SignUpScreenTopImage_child.dart';
import '../component/filds_medical.dart';
import '../mainT.dart';
import 'package:http/http.dart' as http;

final _enfController = TextEditingController();
final _medController = TextEditingController();
final _medubiController = TextEditingController();

class medicalForm extends StatefulWidget {
  final String? selectedGender;
  final TextEditingController nameController;
  final TextEditingController fnController;

  const medicalForm({
    Key? key,
    this.selectedGender,
    required this.nameController,
    required this.fnController,
  }) : super(key: key);

  @override
  _medicalFormState createState() => _medicalFormState();
}

class _medicalFormState extends State<medicalForm> {
  String medubi = '';
  String enfermedades = _enfController.text;
  String medicamentos = _medController.text;

  bool get isFormValid =>
      widget.selectedGender != null &&
      widget.nameController.text.isNotEmpty &&
      widget.fnController.text.isNotEmpty &&
      enfermedades.isNotEmpty &&
      medicamentos.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChildCubit, ChildState>(
      builder: (context, state) {
        if (state is ChildLoading) {
          return CircularProgressIndicator();
        } else if (state is ChildError) {
          return Text(state.message);
        } else {
          return yourFormWidget(
              context, state); // Muestras el formulario en caso contrario.
        }
      },
    );
  }

  Widget yourFormWidget(BuildContext context, ChildState state) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 0,
            ),
            SignUpScreenTopImageMed(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      child: Text(
                    "Recomendaciones de Cuidado:\n  Información Médica",
                    style: TextStyle(
                        color: Color.fromRGBO(49, 39, 79, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  )),
                  SizedBox(
                    height: 20,
                  ),
                  // Resto de tu código
                  formTextField2(controller: _enfController),
                  SizedBox(height: 20),
                  formTextField(controller: _medController),
                  SizedBox(
                    height: 20,
                  ),
                  formTextField3(controller: _medubiController),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    child: GestureDetector(
                      onTap: () {
                        if (isFormValid) {
                          navigateToHomeB(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content:
                                    Text('Por favor, llena todos los campos')),
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
                            "Registrar Información",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),

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

  Future<void> navigateToHomeB(BuildContext context) async {
    String selectedGender = widget.selectedGender ?? "";
    int gender = selectedGender == "Masculino" ? 1 : 2;
    String name = widget.nameController.text;
    String fn = widget.fnController.text;
    String medubi = _medubiController.text;
    String enfermedades = _enfController.text;
    String medicamentos = _medController.text;

    print("selectedGender: $selectedGender");
    print("gender: $gender");
    print("name: $name");
    print("fn: $fn");
    print("medubiValue: $medubi");
    print("enfermedadesValue: $enfermedades");
    print("medicamentosValue: $medicamentos");
    if (_medController.text.isNotEmpty &&
        _medubiController.text.isNotEmpty &&
        _enfController.text.isNotEmpty) {
      final childCubit = context.read<ChildCubit>();
      var result = await childCubit.createChild(
        'http://10.0.2.2:8080/api/v1/child/',
        {
          'name': name,
          'birthdate': fn,
          'phoneEmergency': '123', // Cambiar a los datos correspondientes
          'gender': gender,
          'childStatus': 1, // Cambiar a los datos correspondientes

          'allergieType': enfermedades,
          'medication': medicamentos,
          'medicationUbication': medubi,
        },
      );
      if (result) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MainScreen(),
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('El registro fue exitoso')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('El registro no fue exitoso')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, llena todos los campos')),
      );
    }

    // Verifica si el resultado es exitoso, de lo contrario muestra un mensaje de error.
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
