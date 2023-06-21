import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:front/cubit/report_cubit.dart';
import 'package:front/cubit/review_cubit.dart';

import 'package:front/models/modelo_booking.dart';
import 'package:front/ui/babysitter/component/img_topBs.dart';
import 'package:front/ui/babysitter/home_babysiiter.dart';
import 'package:front/ui/tutor/component/img_top2.dart';
import 'package:intl/intl.dart';
import '../../component/bottoms.dart';
import '../../component/filds_forms.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReportScreen extends StatefulWidget {
  final int tutorId;
  final int userId;
  final Booking booking;
  final int babysitterId;
  const ReportScreen(
      {Key? key,
      required this.tutorId,
      required this.userId,
      required this.booking,
      required this.babysitterId})
      : super(key: key);
  @override
  _PerfilScreenState createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<ReportScreen> {
  final TextEditingController _reportController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  void initState() {
    super.initState();

    try {
      context.read<ReportCubit>().fetchReport(
          'http://10.0.2.2:8080/api/v1/reportbabysitter',
          widget.babysitterId.toString());
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
          body: BlocConsumer<ReportCubit, ReportState>(
            listener: (context, state) {
              if (state is ReportError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: ${state.message}')),
                );
              } else if (state is ReportCreated) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Registro creado correctamente')),
                );
                _reportController.clear();
                _dateController.clear();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainScreenBs(
                      userId: widget.userId,
                    ),
                  ),
                );
              }
            },
            builder: (context, state) {
              return ListView(
                padding: EdgeInsets.all(20),
                children: [
                  tles3(),
                  Center(
                    child: Text('Realiza un reporte para el tutor del servicio',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: HexColor('#20262E'))),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Ingresa los siguientes datos para realizar el reporte.',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: HexColor('#20262E'),
                    ),
                  ),
                  SizedBox(height: 30),
                  fildform(
                    controller: _reportController,
                    hint: 'Ingresa la descripción del reporte',
                    label: 'Reporte',
                    icon: Icons.report,
                  ),
                  SizedBox(height: 10),
                  fildform(
                    controller: _dateController,
                    hint: 'Ingresa fecha de reporte',
                    label: 'Fecha aaaa-mm-dd',
                    icon: Icons.calendar_today,
                  ),
                  SizedBox(height: 20),
                  CustomButton(
                    onPressed: () {
                      if (_dateController.text.isNotEmpty &&
                          _reportController.text.isNotEmpty) {
                        if (!isValidDate(_dateController.text)) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  'Por favor, introduce un formato de fecha válido, aaaa/mm/dd')));
                          return;
                        }
                        final telefonoCubit = context.read<ReportCubit>();
                        var result = telefonoCubit.createReport(
                          'http://10.0.2.2:8080/api/v1/reportbabysitter',
                          {
                            'tutorId': widget.tutorId,
                            'babysitterId': widget.babysitterId,
                            'reportBabysitterDeclaration':
                                _reportController.text,
                            'reportBabysitterDate': _dateController.text,
                          },
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              content: Text(
                                  'Por favor, complete los campos requeridos.')),
                        );
                      }
                    },
                    text: 'Guardar Reseña',
                    icon: Icons.save,
                  ),
                  SizedBox(height: 20),
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

bool isValidDate(String input) {
  try {
    DateFormat('yyyy-MM-dd').parseStrict(input);
    return true;
  } catch (e) {
    return false;
  }
}
