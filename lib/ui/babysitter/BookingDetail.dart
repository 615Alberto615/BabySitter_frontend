import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:front/component/bottoms.dart';
import 'package:front/cubit/booking_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/models/modelo_babysitter.dart';
import 'package:front/models/modelo_booking.dart';
import 'package:front/ui/babysitter/BookingChilds.dart';
import 'package:front/ui/babysitter/BookingDetail.dart';
import 'package:front/ui/babysitter/BookingPhones.dart';
import 'package:front/ui/babysitter/BookingRules.dart';
import 'package:front/ui/babysitter/component/img_topBs.dart';
import 'package:front/ui/babysitter/home_babysiiter.dart';
import '../tutor/component/ColoresTutor.dart';
import '../tutor/component/icons.dart';
import 'package:intl/intl.dart';

import 'package:flutter/rendering.dart';

class BookingDetail extends StatefulWidget {
  final int userId;
  final int babysitterId;
  final Booking booking;
  const BookingDetail(
      {Key? key,
      required this.userId,
      required this.babysitterId,
      required this.booking})
      : super(key: key);
  _HomeTState createState() => _HomeTState();
}

class _HomeTState extends State<BookingDetail> {
  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  Widget tabBody = Container(
    color: ColoresTutor.background,
  );

  @override
  void initState() {
    print("idbabysitter: ${widget.userId}");
    print("idbabysitter: ${widget.babysitterId}");
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
                            booking.bookingId == widget.booking.bookingId)
                        .toList();

                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 0, bottom: 0),
                            child: Text(
                              'Más Información',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: HexColor('#20262E'),
                              ),
                            ),
                          ),
                          info(),
                          Container(
                            height: 150,
                            margin: EdgeInsets.only(top: 0, bottom: 0),
                            child: ListView.separated(
                              padding: EdgeInsets.symmetric(
                                horizontal: 20,
                              ), //vertical: 10),
                              itemCount: filteredBookings.length,
                              separatorBuilder: (context, index) => Divider(
                                  height: 15, color: Colors.transparent),
                              itemBuilder: (context, index) {
                                final booking = filteredBookings[index];
                                Color statusColor;
                                switch (booking.bookingCompleted) {
                                  case 1:
                                    statusColor = HexColor('#DBDFAA');
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
                                          Text(
                                              'Precio ${booking.bookingAmount}'),
                                          Text('Zona: ${booking.bookingChild}'),
                                          Text(
                                              'Fecha: ${DateFormat('yyyy/MM/dd').format(DateTime.parse(booking.bookingDate).toLocal())}'),
                                          Text(
                                              'Estado: ${getBookingStatus(booking.bookingCompleted)}'),
                                        ],
                                      ),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                            icon: Icon(Icons.more),
                                            onPressed: () {
                                              if (booking.bookingCompleted !=
                                                  3) {
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: <Widget>[
                                                          Text(
                                                            'Opciones reserva',
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                          IconButton(
                                                            icon: Icon(
                                                                Icons.close),
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.0),
                                                      ),
                                                      content: Text(
                                                          'Elige una opción para la reserva:'),
                                                      actions: <Widget>[
                                                        TextButton(
                                                          child: Text(
                                                              'Cancelar',
                                                              style: TextStyle(
                                                                  color: HexColor(
                                                                      '#ff6b6b'))),
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                            context
                                                                .read<
                                                                    BookingCubit>()
                                                                .updateBookingStatus(
                                                                    'http://10.0.2.2:8080/api/v1/booking/status/',
                                                                    '${booking.bookingId}',
                                                                    4);
                                                          },
                                                        ),
                                                        TextButton(
                                                          child: Text('Aceptar',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black)),
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                            context
                                                                .read<
                                                                    BookingCubit>()
                                                                .updateBookingStatus(
                                                                    'http://10.0.2.2:8080/api/v1/booking/status/',
                                                                    '${booking.bookingId}',
                                                                    2);
                                                          },
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              }
                                            },
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.notifications),
                                            onPressed: () {
                                              if (booking.bookingCompleted ==
                                                  2) {
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    String amountPaid = '';

                                                    return StatefulBuilder(
                                                      // Añade un StatefulBuilder
                                                      builder:
                                                          (BuildContext context,
                                                              StateSetter
                                                                  setState) {
                                                        return AlertDialog(
                                                          title: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: <Widget>[
                                                              Text(
                                                                'Reserva en proceso',
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                              IconButton(
                                                                icon: Icon(Icons
                                                                    .close),
                                                                onPressed: () {
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20.0),
                                                          ),
                                                          content: Container(
                                                            // Añade un Container
                                                            width: MediaQuery
                                                                    .of(context)
                                                                .size
                                                                .width, // Asegúrate de que el ancho se ajuste a la pantalla
                                                            child:
                                                                SingleChildScrollView(
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: [
                                                                  Text(
                                                                      'Esta reserva está actualmente en proceso.'),
                                                                  SizedBox(
                                                                      height:
                                                                          10),
                                                                  TextField(
                                                                    decoration:
                                                                        InputDecoration(
                                                                      labelText:
                                                                          'Ingrese el monto pagado',
                                                                      hintText:
                                                                          '0.00',
                                                                    ),
                                                                    keyboardType:
                                                                        TextInputType.numberWithOptions(
                                                                            decimal:
                                                                                true),
                                                                    inputFormatters: [
                                                                      FilteringTextInputFormatter
                                                                          .allow(
                                                                        RegExp(
                                                                            r'^\d+\.?\d{0,2}$'),
                                                                      ),
                                                                    ],
                                                                    onChanged:
                                                                        (value) {
                                                                      setState(
                                                                          () {
                                                                        // Añade un setState para actualizar el valor
                                                                        amountPaid =
                                                                            value;
                                                                      });
                                                                    },
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          actions: <Widget>[
                                                            TextButton(
                                                              child: Text(
                                                                'Marcar como completada',
                                                                style: TextStyle(
                                                                    color: HexColor(
                                                                        '#B799FF')),
                                                              ),
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();

                                                                if (amountPaid
                                                                    .isNotEmpty) {
                                                                  double
                                                                      paidAmount =
                                                                      double.parse(
                                                                          amountPaid);
                                                                  // Aquí se realiza el procesamiento con el monto pagado

                                                                  Map<String,
                                                                          dynamic>
                                                                      requestBody =
                                                                      {
                                                                    'bookingCompleted':
                                                                        3,
                                                                    'bookingAmount':
                                                                        paidAmount,
                                                                  };
                                                                  context
                                                                      .read<
                                                                          BookingCubit>()
                                                                      .updateBookingStatus2(
                                                                        'http://10.0.2.2:8080/api/v1/booking/status/',
                                                                        '${booking.bookingId}',
                                                                        requestBody,
                                                                      );
                                                                } else {
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .showSnackBar(
                                                                    SnackBar(
                                                                      content: Text(
                                                                          'Ingrese el monto pagado para poder marcar como terminada la reserva.'),
                                                                      backgroundColor:
                                                                          HexColor(
                                                                              '#ff6b6b'),
                                                                    ),
                                                                  );
                                                                }
                                                              },
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  },
                                                );
                                              }
                                            },
                                          ),
                                        ],
                                      )),
                                );
                              },
                            ),
                          ),
                          SizedBox(height: 0),
                          Container(
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              child: SingleChildScrollView(
                                child: Column(children: [
                                  Text('Informacion',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: HexColor('#20262E'))),
                                  SizedBox(height: 10),
                                  CustomButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => BookingChilds(
                                                  tutorId:
                                                      widget.booking.tutorId,
                                                  userId: widget.userId,
                                                )),
                                      );
                                    },
                                    text: 'Información niños',
                                    icon: Icons.child_care,
                                  ),
                                  SizedBox(height: 8),
                                  CustomButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => BookingRules(
                                                  tutorId:
                                                      widget.booking.tutorId,
                                                  userId: widget.userId,
                                                )),
                                      );
                                    },
                                    text: 'Reglas de la casa',
                                    icon: Icons.medical_information,
                                  ),
                                  SizedBox(height: 8),
                                  CustomButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => BookingPh(
                                                  tutorId:
                                                      widget.booking.tutorId,
                                                  userId: widget.userId,
                                                )),
                                      );
                                    },
                                    text: 'Telefonos de emergencia',
                                    icon: Icons.phone,
                                  ),
                                  SizedBox(height: 8),
                                  CustomButton(
                                    onPressed: () {
                                      /*
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => activForm()),
        );*/
                                    },
                                    text: 'Actividades',
                                    icon: Icons.local_activity,
                                  ),
                                ]),
                              )),
                          SizedBox(
                            height: 0,
                          ),
                        ],
                      ),
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
