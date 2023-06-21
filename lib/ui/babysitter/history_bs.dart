import 'package:flutter/material.dart';
import 'package:front/cubit/booking_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/ui/babysitter/report.dart';
import 'package:front/ui/tutor/component/Bottom_Tutor.dart' as bottomTutor;
import 'package:front/ui/tutor/component/ColoresTutor.dart';
import 'package:front/ui/tutor/component/icons.dart';
import 'package:intl/intl.dart';

class HistoryBs extends StatefulWidget {
  final int userId;
  final int babysitterId;

  const HistoryBs({
    Key? key,
    required this.userId,
    required this.babysitterId,
  }) : super(key: key);
  _HistoryTState createState() => _HistoryTState();
}

class _HistoryTState extends State<HistoryBs> {
  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  Widget tabBody = Container(
    color: ColoresTutor.background,
  );

  @override
  void initState() {
    context.read<BookingCubit>().fetchBookings(
        'http://10.0.2.2:8080/api/v1/booking/babysitter/',
        '${widget.babysitterId}/');

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  String getBookingStatus(int statusNumber) {
    switch (statusNumber) {
      case 1:
        return "Pendiente";
      case 2:
        return "En Proceso";
      case 3:
        return "Terminado";
      case 4:
        return "Cancelado";
      default:
        return "Estado desconocido";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColoresTutor.background,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        backgroundColor: Colors.transparent,
        body: FutureBuilder<bool>(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            } else {
              return BlocConsumer<BookingCubit, BookingState>(
                listener: (context, state) {
                  if (state is BookingError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error: ${state.message}'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  } else if (state is BookingUpdated) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Reserva actualizada con éxito!'),
                        backgroundColor: HexColor('#B799FF'),
                      ),
                    );
                    context.read<BookingCubit>().fetchBookings(
                        'http://10.0.2.2:8080/api/v1/booking/babysitter/',
                        '${widget.babysitterId}/');
                  }
                },
                builder: (context, state) {
                  if (state is BookingLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is BookingsLoaded) {
                    var filteredBookings = state.bookings
                        .where((booking) =>
                            booking.babysitterId == widget.babysitterId &&
                            booking.bookingCompleted == 3)
                        .toList();

                    return Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 10, bottom: 20),
                          child: Text(
                            'Lista de Reservas',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: HexColor('#20262E'),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListView.separated(
                            padding: EdgeInsets.all(20),
                            itemCount: filteredBookings.length,
                            separatorBuilder: (context, index) =>
                                Divider(height: 15, color: Colors.transparent),
                            itemBuilder: (context, index) {
                              final booking = filteredBookings[index];
                              Color statusColor;
                              switch (booking.bookingCompleted) {
                                case 1:
                                  statusColor = Colors.yellow;
                                  break;
                                case 2:
                                  statusColor = HexColor('#ffab7d');
                                  break;
                                case 3:
                                  statusColor = Colors.green;
                                  break;
                                case 4:
                                  statusColor = HexColor('#ff6b6b');
                                  break;
                                default:
                                  statusColor = HexColor('#B799FF');
                              }
                              return Card(
                                shadowColor: HexColor('#B799FF'),
                                elevation: 5.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: ListTile(
                                  leading: Icon(
                                    Icons.book,
                                    size: 30,
                                    color: statusColor,
                                  ),
                                  title: Text(
                                    'Reserva: ${booking.userName} ${booking.userLastName}',
                                    style: TextStyle(
                                      color: statusColor,
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Precio ${booking.bookingAmount}'),
                                      Text('Zona: ${booking.bookingChild}'),
                                      Text(
                                          'Fecha: ${DateFormat('yyyy/MM/dd').format(DateTime.parse(booking.bookingDate).toLocal())}'),
                                      Text(
                                          'Estado: ${getBookingStatus(booking.bookingCompleted)}'),
                                    ],
                                  ),
                                  trailing: IconButton(
                                    icon: Icon(Icons.report),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Text(
                                                  'Opciones Reporte',
                                                  textAlign: TextAlign.center,
                                                  style:
                                                      TextStyle(fontSize: 20),
                                                ),
                                                IconButton(
                                                  icon: Icon(Icons.close),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                            ),
                                            content: Text(
                                              '¿Desea hacer una reporte por el servicio a ${booking.userName} ${booking.userLastName}?',
                                              textAlign: TextAlign.justify,
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                child: Text(
                                                  'Hacer reporte',
                                                  style: TextStyle(
                                                      color:
                                                          HexColor('#ff6b6b')),
                                                ),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          ReportScreen(
                                                        booking: booking,
                                                        tutorId:
                                                            booking.tutorId,
                                                        babysitterId: booking
                                                            .babysitterId,
                                                        userId: widget.userId,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 70,
                        ),
                      ],
                    );
                  } else {
                    return Container();
                  }
                },
              );
            }
          },
        ),
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
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
