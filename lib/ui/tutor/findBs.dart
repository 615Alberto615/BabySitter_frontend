// Asegúrate de importar todos los paquetes necesarios

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/cubit/LocationLoaded.dart';
import 'package:front/ui/tutor/info_bs.dart';

import '../../cubit/babysitter_cubit.dart';
import '../../cubit/babysitter_state.dart';

class FindBs extends StatefulWidget {
  final int tutorId;
  final int userId;
  final String address;
  final String startTime;
  final String endTime;
  final String fecha;
  const FindBs({
    Key? key,
    required this.tutorId,
    required this.userId,
    required this.address,
    required this.startTime,
    required this.endTime,
    required this.fecha,
  }) : super(key: key);

  _FindBsState createState() => _FindBsState();
}

class _FindBsState extends State<FindBs> with TickerProviderStateMixin {
  // Declaras cualquier cosa que necesites aquí, similar a cómo lo has hecho con 'familyT'
  int locationIdT = -1;
  @override
  void initState() {
    super.initState();
    context.read<BabysitterCubit>().getLocationByTutorId(widget.tutorId);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
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
        body: BlocConsumer<BabysitterCubit, BabysitterState>(
          // Asumiendo que tienes un Cubit para gestionar los babysitters
          listener: (context, state) {
            if (state is LocationLoaded) {
              locationIdT = state.location.id;
              context
                  .read<BabysitterCubit>()
                  .getAllBabysitters('http://10.0.2.2:8080/api/v1/babysitter');
            }
            // Aquí gestionas cualquier estado que pueda resultar de acciones en tus babysitters
          },
          builder: (context, state) {
            return ListView(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              children: <Widget>[
                Center(
                  child: Text('Encuentra una niñera',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: HexColor('#20262E'))),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Text(
                      'Elige una niñera para realizar una reserva',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: HexColor('#20262E'),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                // Aquí puedes poner cualquier otro elemento que necesites
                if (state is BabysitterLoaded)
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: state.babysitters.length,
                    itemBuilder: (context, index) {
                      final babysitter = state.babysitters[index];

                      if (babysitter.seLocationId == locationIdT) {
                        return Card(
                          shadowColor: HexColor('#eaafc8'),
                          margin: EdgeInsets.symmetric(vertical: 5),
                          elevation: 5.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: ListTile(
                            leading:
                                Icon(Icons.person, color: HexColor('#20262E')),
                            title: Text('Tarifa:  40Bs por Hora.'),
                            subtitle: Text(
                                'Nombre: ${babysitter.userName} ${babysitter.userLastName}'),
                            trailing: IconButton(
                              // Agregamos el botón aquí
                              icon: Icon(Icons.next_plan,
                                  color: HexColor('#9695ff')),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => InfoBs(
                                      babysitter:
                                          babysitter, // Pasamos el objeto de babysitter a la nueva página
                                      tutorId: widget.tutorId,
                                      userId: widget.userId,
                                      address: widget.address,
                                      startTime: widget.startTime,
                                      endTime: widget.endTime,
                                      fecha: widget.fecha,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      } else {
                        return Container(); // retornamos un contenedor vacío
                      }
                    },
                  ),

                if (state is BabysitterLoading)
                  Center(child: CircularProgressIndicator()),
                // Continuas con el resto de elementos que necesites
              ],
            );
          },
        ),
      ),
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
