import 'package:flutter/material.dart';
import 'package:front/cubit/report_cubit.dart';
import 'package:front/cubit/review_cubit.dart';
import 'package:front/models/modelo_babysitter.dart';

import 'package:front/models/modelo_booking.dart';
import 'package:front/models/modelo_report.dart';
import 'package:front/ui/babysitter/component/img_topBs.dart';
import 'package:intl/intl.dart';
import '../../component/bottoms.dart';
import '../../component/filds_forms.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReportHis extends StatefulWidget {
  final int userId;
  final int babysitterId;

  const ReportHis({
    Key? key,
    required this.userId,
    required this.babysitterId,
  }) : super(key: key);
  @override
  _PerfilScreenState createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<ReportHis> {
  final TextEditingController _reviewController = TextEditingController();
  final TextEditingController _calificaciontelController =
      TextEditingController();
  void initState() {
    super.initState();

    try {
      fetchReviewsAndAverage();
    } catch (e) {
      print(e);
    }

    print(widget.userId);
    print(widget.babysitterId);
  }

  void fetchReviewsAndAverage() async {
    try {
      await context.read<ReportCubit>().fetchReport(
          'http://10.0.2.2:8080/api/v1/reportbabysitter/tutor/',
          widget.babysitterId.toString());
    } catch (e) {
      print(e);
    }
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
              }
            },
            builder: (context, state) {
              return ListView(
                padding: EdgeInsets.all(20),
                children: [
                  Center(
                    child: Text('Reportes que has recibido',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: HexColor('#20262E'))),
                  ),
                  tles3(),
                  SizedBox(height: 10),
                  Text(
                    'Lista de Reportes:',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: HexColor('#20262E'),
                    ),
                  ),
                  SizedBox(height: 20),
                  if (state is ReportLoaded)
                    ...state.report.isEmpty
                        ? [
                            Center(
                              child: Text('¡Felicidades! No tienes reportes.',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: HexColor('#20262E'),
                                  )),
                            )
                          ]
                        : [
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: state.report.length,
                              itemBuilder: (context, index) {
                                final rev = state.report[index];
                                return Card(
                                  elevation: 5.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: ListTile(
                                    leading: Icon(Icons.reviews_outlined,
                                        color: HexColor('#20262E')),
                                    title: Text(rev.reportBabysitterDeclaration,
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: HexColor('#20262E'))),
                                    //subtitle: Text(rev.calification.toString(),
                                    subtitle: Text(
                                        'Fecha: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(rev.reportBabysitterDate).toLocal())}',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: HexColor('#20262E'))),
                                  ),
                                );
                              },
                            ),
                            if (state is ReportLoading)
                              Center(child: CircularProgressIndicator()),
                            SizedBox(height: 10),
                          ],
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
