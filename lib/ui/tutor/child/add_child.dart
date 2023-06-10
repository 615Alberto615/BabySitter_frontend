import 'package:flutter/material.dart';
import 'package:front/ui/register/components/filds_babysitter.dart';
import 'package:front/ui/tutor/component/SignUpScreenTopImage_child.dart';
import 'package:front/ui/tutor/family_tutor.dart';
import '../../babysitter/home_babysiiter.dart';
import 'activity_form.dart';
import '../component/filds_child.dart';
import '../mainT.dart';
import 'medical_form.dart';

final _nameController = TextEditingController();
final _fnController = TextEditingController();

class RegisterBB extends StatefulWidget {
  RegisterBB({Key? key}) : super(key: key);

  @override
  _RegisterBBState createState() => _RegisterBBState();
}

class _RegisterBBState extends State<RegisterBB> {
  String? _selectedGender;

  @override
  Widget build(BuildContext context) {
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
              height: 20,
            ),
            SignUpScreenTopImageChild(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      child: Text(
                    "Registro Niñ@",
                    style: TextStyle(
                        color: Color.fromRGBO(49, 39, 79, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  )),
                  SizedBox(
                    height: 30,
                  ),
                  NameTextFieldB(
                    controller: _nameController,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  FNTextField(controller: _fnController),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Genero",
                    style: TextStyle(color: HexColor("20262E")),
                  ),
                  GenderSelector(
                      selectedGender: _selectedGender,
                      onGenderSelected: (value) {
                        setState(() {
                          _selectedGender = value;
                        });
                      }),
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (_fnController.text.isNotEmpty &&
                          _nameController.text.isNotEmpty &&
                          _selectedGender != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => medicalForm(
                                    selectedGender: _selectedGender,
                                    nameController: _nameController,
                                    fnController: _fnController,
                                  )),
                        );
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
                          "Registrar",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
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

class GenderSelector extends StatelessWidget {
  final String? selectedGender;
  final ValueChanged<String?> onGenderSelected;

  GenderSelector(
      {required this.selectedGender, required this.onGenderSelected});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: const Text(
            'Masculino',
            style: TextStyle(),
          ),
          leading: Radio(
            value: 'Masculino',
            groupValue: selectedGender,
            onChanged: (value) {
              onGenderSelected(value as String?);
            },
          ),
        ),
        ListTile(
          title: const Text(
            'Femenino',
            style: TextStyle(),
          ),
          leading: Radio(
            value: 'Femenino',
            groupValue: selectedGender,
            onChanged: (value) {
              onGenderSelected(value as String?);
            },
          ),
        ),
      ],
    );
  }
}
