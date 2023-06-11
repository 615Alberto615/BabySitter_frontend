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

class HomeT extends StatefulWidget {
  final int userId;
  final int tutorId;
  const HomeT({Key? key, required this.userId, required this.tutorId})
      : super(key: key);
  _HomeTState createState() => _HomeTState();
}

class _HomeTState extends State<HomeT> with TickerProviderStateMixin {
  AnimationController? animationController;

  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  Widget tabBody = Container(
    color: ColoresTutor.background,
  );

  @override
  void initState() {
    context.read<BookingCubit>().fetchBookings(
        'http://10.0.2.2:8080/api/v1/booking/tutor/', '${widget.tutorId}');
    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);

    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
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
                        Expanded(
                          child: ListView.builder(
                            padding: EdgeInsets.all(15),
                            itemCount: state.bookings.length,
                            itemBuilder: (context, index) {
                              final booking = state.bookings[index];
                              return Card(
                                shadowColor: HexColor('#B799FF'),
                                elevation: 5.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: ListTile(
                                  title: Text('Reserva: ${booking.bookingId}'),
                                  subtitle: Text(
                                      'Estado: ${booking.bookingCompleted}\nPrecio ${booking.bookingAmount} \nZona: ${booking.bookingChild}\nFecha: ${booking.bookingTimeEnd}'),
                                  trailing: IconButton(
                                    icon: Icon(Icons.notifications),
                                    onPressed: () {
                                      // Acción que se ejecutará al presionar el botón de campana
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
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
