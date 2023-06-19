import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/cubit/reglas_cubit.dart';
import 'package:front/service/ApiService_reglas.dart';
import 'package:front/ui/tutor/perfil.dart';

import '../../component/filds_forms.dart';
import 'component/img_top2.dart';

class ReglasScreen extends StatefulWidget {
  final int tutorId;
  final int userId;
  const ReglasScreen({Key? key, required this.tutorId, required this.userId})
      : super(key: key);
  @override
  _ReglasScreenState createState() => _ReglasScreenState();
}

class _ReglasScreenState extends State<ReglasScreen> {
  final TextEditingController _ruleController = TextEditingController();
  @override
  void initState() {
    super.initState();
    try {
      context.read<ReglasCubit>().fetchReglas(
          'http://10.0.2.2:8080/api/v1/tutorRules/tutor/',
          widget.tutorId.toString());
    } catch (e) {
      print(e);
    }
    print(widget.tutorId);
    print(widget.userId);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: BlocConsumer<ReglasCubit, ReglasState>(
            listener: (context, state) {
              if (state is ReglasError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: ${state.message}')),
                );
              } else if (state is ReglaDeleted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Registro eliminado correctamente')),
                );
                context.read<ReglasCubit>().fetchReglas(
                    'http://10.0.2.2:8080/api/v1/tutorRules/tutor/',
                    widget.tutorId.toString());
              } else if (state is ReglaCreated) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Registro creado correctamente')),
                );
                _ruleController.clear();
                context.read<ReglasCubit>().fetchReglas(
                    'http://10.0.2.2:8080/api/v1/tutorRules/tutor/',
                    widget.tutorId.toString());
              }
            },
            builder: (context, state) {
              return ListView(
                padding: EdgeInsets.all(20),
                children: [
                  myfam3(),
                  SizedBox(height: 10),
                  Center(
                    child: Text('Reglas de la Casa',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: HexColor('#20262E'))),
                  ),
                  SizedBox(height: 30),
                  fildform(
                    controller: _ruleController,
                    hint: 'Introduce la regla',
                    label: 'Regla',
                    icon: Icons.rule,
                  ),
                  SizedBox(height: 20),
                  PerfilButton(
                    text: 'Guardar Regla',
                    onPressed: () {
                      if (_ruleController.text.isNotEmpty) {
                        final childCubit = context.read<ReglasCubit>();
                        var result = childCubit.createRegla(
                          'http://10.0.2.2:8080/api/v1/tutorRules/',
                          {
                            'rulesHome': _ruleController.text,
                            'tutor': widget.tutorId.toInt(),
                          },
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content:
                                  Text('Por favor, llene el campo requerido.')),
                        );
                      }
                    },
                  ),
                  SizedBox(height: 20),
                  if (state is ReglasLoaded)
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: state.reglas.length,
                      itemBuilder: (context, index) {
                        final rule = state.reglas[index];
                        return Card(
                          elevation: 5.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: ListTile(
                            leading: Icon(Icons.rule_sharp,
                                color: HexColor('#20262E')),
                            title: Text(rule.rulesHome.toString(),
                                style: TextStyle(
                                    fontSize: 15, color: HexColor('#20262E'))),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.delete,
                                      color: HexColor('#20262E')),
                                  onPressed: () async {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return Dialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                          backgroundColor: HexColor("#9695ff"),
                                          child: Container(
                                            padding: EdgeInsets.all(20.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  'Eliminar Regla',
                                                  style: TextStyle(
                                                      fontSize: 24.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                SizedBox(height: 20.0),
                                                Text(
                                                    'Estás seguro que quieres eliminar esta regla?'),
                                                SizedBox(height: 20.0),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
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
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                    TextButton(
                                                      child: Text(
                                                        'Eliminar',
                                                        style: TextStyle(
                                                          color: Colors
                                                              .white, // Color de texto personalizado
                                                        ),
                                                      ),
                                                      onPressed: () async {
                                                        await context
                                                            .read<ReglasCubit>()
                                                            .deleteRegla(
                                                                'http://10.0.2.2:8080/api/v1/tutorRules/',
                                                                '${rule.tutorRulesId}');
                                                        Navigator.of(context)
                                                            .pop();
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
                          ),
                        );
                      },
                    ),
                  if (state is ReglasLoading) CircularProgressIndicator(),
                  SizedBox(height: 10),
                ],
              );
            },
          ),
        ));
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
