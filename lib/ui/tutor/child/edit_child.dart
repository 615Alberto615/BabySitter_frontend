import 'package:flutter/material.dart';
import 'package:front/cubit/child_cubit.dart';
import 'package:front/models/modelo_child.dart';
import 'package:front/ui/register/components/filds_babysitter.dart';
import 'package:front/ui/tutor/component/SignUpScreenTopImage_child.dart';
import 'package:front/ui/tutor/family_tutor.dart';
import '../../babysitter/home_babysiiter.dart';
import 'activity_form.dart';
import '../component/filds_child.dart';
import '../mainT.dart';
import 'medical_form.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class editBB extends StatefulWidget {
  final Child child;
  final tutorId;
  final userId;
  const editBB({Key? key, required this.child, this.tutorId, this.userId})
      : super(key: key);

  @override
  _RegisterBBState createState() => _RegisterBBState();
}

class _RegisterBBState extends State<editBB> {
  late TextEditingController _nameController = TextEditingController();
  late TextEditingController _fnController = TextEditingController();
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.child.childName);
    _fnController = TextEditingController(text: widget.child.childBirthdate);
    print(widget.tutorId);
    print(widget.userId);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _fnController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return BlocConsumer<ChildCubit, ChildState>(listener: (context, state) {
      if (state is ChildError) {
        // Muestra un mensaje de error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(state.message)),
        );
      } else if (state is ChildUpdated) {
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
                      "Editar Registro Niñ@",
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
                    SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        try {
                          DateFormat('yyyy/MM/dd')
                              .parseStrict(_fnController.text);
                          if (_nameController.text.isNotEmpty) {
                            // Crear el requestBody con los datos del formulario
                            Map<String, dynamic> requestBody = {
                              'childName': _nameController.text,
                              'childBirthdate': _fnController.text,
                              'childGender':
                                  widget.child.childGender.toString(),
                              'childPhoneEmergency':
                                  widget.child.childPhoneEmergency.toString(),
                            };
                            context.read<ChildCubit>().updateChild(
                                'http://10.0.2.2:8080/api/v1/child/',
                                widget.child.childId.toString(),
                                requestBody);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      'Por favor, llena todos los campos')),
                            );
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(
                                    'Formato de fecha incorrecto. Por favor ingrese la fecha en formato aaaa/mm/dd')),
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
                            "Modificar Registro",
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
