import 'package:flutter/material.dart';
import 'package:front/cubit/booking_cubit.dart';
import 'package:front/ui/tutor/component/img_top2.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/ui/tutor/mainT.dart';
import '../../models/modelo_babysitter.dart';
import '../babysitter/perfil_bs.dart';
import 'package:intl/intl.dart';

class InfoBs extends StatelessWidget {
  final Babysitter babysitter;
  final int tutorId;
  final int userId;
  final String address;
  final String startTime;
  final String endTime;
  final String fecha;

  const InfoBs({
    Key? key,
    required this.babysitter,
    required this.tutorId,
    required this.userId,
    required this.address,
    required this.startTime,
    required this.endTime,
    required this.fecha,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookingCubit, BookingState>(
      listener: (context, state) {
        if (state is BookingCreated) {
          // Aquí puedes mostrar un snackbar o dialog para confirmar la creación
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Reserva creada con exito!')),
          );

          // Navegamos hacia la MainScreen cuando se completa la reserva con éxito
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (_) => MainScreen(
                    userId: userId,
                  )));
        } else if (state is BookingError) {
          // Aquí puedes mostrar un snackbar o dialog para mostrar el error
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error creating booking: ${state.message}')),
          );
        }
      },
      builder: (context, state) {
        if (state is BookingLoading) {
          return Center(child: CircularProgressIndicator());
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Información de Niñer@',
              style: TextStyle(
                  color: Colors.white, fontFamily: 'Roboto', fontSize: 20.0),
            ),
            backgroundColor: HexColor("#9695ff"),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  myfam4(),
                  Card(
                    shadowColor: HexColor('#B799FF'),
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Nombre:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text('                  ${babysitter.userName}' +
                              ' ${babysitter.userLastName}'),
                          SizedBox(height: 16.0),
                          Text(
                            'Direccion:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text('                  ${babysitter.userAddres}'),
                          SizedBox(height: 16.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [],
                          ),
                          Text(
                            'Tarifa en horario diurno:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text('                  40Bs/hora'),
                          SizedBox(height: 16.0),
                          Text(
                            'Tarifa en horario nocturno:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text('                  60Bs/hora'),
                          SizedBox(height: 16.0),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    shadowColor: HexColor('#B799FF'),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 5.0,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 16.0),
                          Text(
                            'Descripción:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text('${babysitter.babysitterDescription}'),
                          SizedBox(height: 16.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  // Acción del botón de estrella
                                },
                                icon: Icon(Icons.reviews),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PerfilButton(
                        text: '    Solicitar Servicio   ',
                        onPressed: () {
                          try {
                            // Primero, crea DateTime a partir de la fecha, el tiempo de inicio y el tiempo de fin
                            List<int> startDateParts =
                                fecha.split('-').map(int.parse).toList();
                            List<int> startTimeParts =
                                startTime.split(':').map(int.parse).toList();
                            List<int> endTimeParts =
                                endTime.split(':').map(int.parse).toList();

                            // Asegúrate de que los datos están en el formato correcto
                            if (startDateParts.length != 3 ||
                                startTimeParts.length != 2 ||
                                endTimeParts.length != 2) {
                              throw FormatException(
                                  'Formato de fecha y hora no válido');
                            }

                            DateTime startDate = DateTime(
                                startDateParts[0],
                                startDateParts[1],
                                startDateParts[2],
                                startTimeParts[0],
                                startTimeParts[1]);
                            DateTime endDate = DateTime(
                                startDateParts[0],
                                startDateParts[1],
                                startDateParts[2],
                                endTimeParts[0],
                                endTimeParts[1]);

                            // Luego, formatea las fechas a la cadena de texto con el formato que necesitas
                            final outputFormat = DateFormat(
                                "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"); // Usamos Z para representar la hora UTC
                            String formattedStartDate = outputFormat.format(
                                startDate.toUtc()); // Convirtiendo a UTC
                            String formattedEndDate =
                                outputFormat.format(endDate.toUtc());

                            int differenceInHours =
                                endDate.difference(startDate).inHours;

                            print('startTime: $startTime');
                            print('endTime: $endTime');
                            print('fecha: $fecha');
                            print('startDate: $formattedStartDate');
                            print('endDate: $formattedEndDate');

                            BlocProvider.of<BookingCubit>(context)
                                .createBooking(
                              'http://10.0.2.2:8080/api/v1/booking/', // reemplaza por tu URL de la API
                              {
                                'babysitterId': babysitter.babysitterId,
                                'tutorId': tutorId,
                                'bookingChild': address,
                                'bookingEstimatedTime': differenceInHours,
                                'bookingTimeStart': formattedStartDate,
                                'bookingTimeEnd': formattedEndDate,
                                'bookingDate': fecha,
                                'bookingCompleted': 0,
                                'bookingPaid': false,
                                'bookingAmount': differenceInHours * 40,
                                'bookingStatus': 1,
                              },
                            );
                          } catch (e) {
                            // Manejo de error de formato inválido
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                    Text('Error: Formato de tiempo inválido'),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
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
