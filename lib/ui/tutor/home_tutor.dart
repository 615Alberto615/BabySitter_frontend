import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/ui/tutor/component/Bottom_Tutor.dart' as bottomTutor;
import 'component/ColoresTutor.dart';
import '../../component/bottoms.dart';
import 'component/icons.dart';
import 'family_tutor.dart';
import 'history_tutor.dart';
import 'opciones_tutor.dart';
import 'package:front/cubit/booking_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeT extends StatefulWidget {
  final int userId;
  final int tutorId;
  const HomeT({Key? key, required this.userId, required this.tutorId})
      : super(key: key);
  _HomeTState createState() => _HomeTState();
}

class _HomeTState extends State<HomeT> {
  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  Widget tabBody = Container(
    color: ColoresTutor.background,
  );

  @override
  void initState() {
    print('Tutor ID: ${widget.tutorId}');
    context.read<BookingCubit>().fetchBookings(
        'http://10.0.2.2:8080/api/v1/booking/tutor/', '${widget.tutorId}/');

    super.initState();
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
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
                      SnackBar(content: Text('Error: ${state.message}')),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is BookingLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is BookingsLoaded) {
                    var filteredBookings = state.bookings
                        .where((booking) =>
                            booking.tutorId == widget.tutorId &&
                            booking.bookingCompleted != 3)
                        .toList();
                    return Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 100, bottom: 20),
                          child: Text(
                            'Lista de Reservas',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: bottomTutor.HexColor('#20262E'),
                            ),
                          ),
                        ),
                        //SearchBar(),
                        Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.all(15),
                            itemCount: filteredBookings.length,
                            itemBuilder: (context, index) {
                              final booking = filteredBookings[index];
                              Color
                                  statusColor; // Definición del color del estado
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
                                    color:
                                        statusColor, // Aplicación del color al icono
                                  ),
                                  title: Text(
                                    'Reserva: ${booking.userName} ${booking.userLastName}',
                                    style: TextStyle(
                                      color:
                                          statusColor, // Aplicación del color al título
                                    ),
                                  ),
                                  subtitle: Text(
                                      'Precio ${booking.bookingAmount}\nZona: ${booking.bookingChild}\nFecha: ${booking.bookingTimeEnd}\nEstado: ${getBookingStatus(booking.bookingCompleted)}'),
                                  trailing: IconButton(
                                    icon: Icon(Icons.notifications),
                                    onPressed: () {
                                      if (booking.bookingCompleted == 2) {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text('Reserva en proceso'),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                              ),
                                              content: Text(
                                                  'Esta reserva está actualmente en proceso.'),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: Text(
                                                      'Abrir chat de WhatsApp'),
                                                  onPressed: () {
                                                    /*
                                                    final whatsappUrl =
                                                        'https://wa.me/+591${booking.userPhone}?text=Hola,%20necesito%20más%20información%20sobre%20la%20reserva.';
                                                    _launchURL(whatsappUrl);*/
                                                  },
                                                ),
                                                TextButton(
                                                  child: Text('OK'),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      }
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

class SearchBar extends StatelessWidget {
  final pink = const Color(0xFFFACCCC);
  final grey = const Color(0xFFF2F2F7);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 32,
      child: TextFormField(
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          focusColor: pink,
          focusedBorder: _border(pink),
          border: _border(grey),
          enabledBorder: _border(grey),
          hintText: 'Start brand search',
          contentPadding: const EdgeInsets.symmetric(vertical: 20),
          prefixIcon: const Icon(
            Icons.search,
            color: Colors.grey,
          ),
        ),
        onFieldSubmitted: (value) {},
      ),
    );
  }

  OutlineInputBorder _border(Color color) => OutlineInputBorder(
        borderSide: BorderSide(width: 0.5, color: color),
        borderRadius: BorderRadius.circular(12),
      );
}
