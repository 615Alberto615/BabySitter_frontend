import 'package:flutter/material.dart';
import 'package:front/cubit/booking_cubit.dart';
import 'package:front/ui/tutor/component/img_top2.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
            SnackBar(content: Text('Booking created successfully!')),
          );
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
                          print(startTime);
                          print(endTime);
                          print(fecha);
                          print(address);
                          print(tutorId);
                          print(babysitter.babysitterId);
                          print(userId);

                          try {
                            List<int> startTimeParts =
                                startTime.split(':').map(int.parse).toList();
                            List<int> endTimeParts =
                                endTime.split(':').map(int.parse).toList();

                            // Calcular la diferencia de tiempo en horas
                            int startHour = startTimeParts[0];
                            int startMinute = startTimeParts[1];
                            int endHour = endTimeParts[0];
                            int endMinute = endTimeParts[1];

                            int differenceInHours = endHour - startHour;
                            if (endMinute < startMinute) {
                              differenceInHours -= 1;
                            }
                            print(differenceInHours);

                            final inputFormat = DateFormat('HH:mm');
                            final startTimeFormatted =
                                inputFormat.parse(startTime);
                            final outputFormat =
                                DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSX");
                            final formattedDateTime =
                                outputFormat.format(startTimeFormatted);

                            print(formattedDateTime);
                            final inputFormat2 = DateFormat('HH:mm');
                            final startTimeFormatted2 =
                                inputFormat2.parse(endTime);
                            final outputFormat2 =
                                DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSX");
                            final formattedDateTime2 =
                                outputFormat.format(startTimeFormatted2);

                            print(
                                formattedDateTime2); // Ejemplo de salida: 2023-06-10T09:30:00.000Z

                            // Resto del código de cálculo de diferencia de tiempo y creación de reserva
                            // ...
                            BlocProvider.of<BookingCubit>(context)
                                .createBooking(
                              'http://10.0.2.2:8080/api/v1/booking/', // reemplaza por tu URL de la API
                              {
                                'babysitterId': babysitter.babysitterId,
                                'tutorId': tutorId,
                                'bookingChild': address,
                                'bookingEstimatedTime': differenceInHours,
                                'bookingTimeStart': formattedDateTime,
                                'bookingTimeEnd': formattedDateTime2,
                                'bookingDate': fecha,
                                'bookingCompleted': 0,
                                'bookingPaid': false,
                                'bookingAmount': differenceInHours * 40,
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
