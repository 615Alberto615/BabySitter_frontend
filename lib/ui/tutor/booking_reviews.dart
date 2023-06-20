import 'package:flutter/material.dart';
import 'package:front/cubit/review_cubit.dart';

import 'package:front/models/modelo_booking.dart';
import 'package:front/ui/babysitter/component/img_topBs.dart';

import '../../component/bottoms.dart';
import '../../component/filds_forms.dart';
import 'component/img_top2.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class reviewsScreenBs extends StatefulWidget {
  final int userId;
  final int babysitterId;
  const reviewsScreenBs(
      {Key? key, required this.userId, required this.babysitterId})
      : super(key: key);
  @override
  _PerfilScreenState createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<reviewsScreenBs> {
  final TextEditingController _reviewController = TextEditingController();
  final TextEditingController _calificaciontelController =
      TextEditingController();
  void initState() {
    super.initState();

    try {
      context.read<ReviewCubit>().fetchReview(
          'http://10.0.2.2:8080/api/v1/review/babysitter/',
          widget.babysitterId.toString());
    } catch (e) {
      print(e);
    }

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
          body: BlocConsumer<ReviewCubit, ReviewState>(
            listener: (context, state) {
              if (state is ReviewError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: ${state.message}')),
                );
              } else if (state is ReviewCreated) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Registro creado correctamente')),
                );
                _reviewController.clear();
                _calificaciontelController.clear();
                context.read<ReviewCubit>().fetchReview(
                    'http://10.0.2.2:8080/api/v1/review/babysitter/',
                    widget.babysitterId.toString());
              }
            },
            builder: (context, state) {
              return ListView(
                padding: EdgeInsets.all(20),
                children: [
                  re2(),
                  Center(
                    child: Text('Reseñas de la niñera',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: HexColor('#20262E'))),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Reseñas y un calificacion de la niñera',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: HexColor('#20262E'),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    height:
                        300, // Ajusta el tamaño del contenedor según sea necesario
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Image.asset('assets/stars.png'),
                        TextField(
                          controller: _reviewController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Escribe aquí',
                            labelStyle: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  if (state is ReviewLoaded)
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: state.review.length,
                      itemBuilder: (context, index) {
                        final rev = state.review[index];
                        return Card(
                          elevation: 5.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: ListTile(
                            leading: Icon(Icons.reviews_outlined,
                                color: HexColor('#20262E')),
                            title: Text(rev.review,
                                style: TextStyle(
                                    fontSize: 15, color: HexColor('#20262E'))),
                            subtitle: Text(
                                'Calificacion: ' + rev.stars.toString(),
                                style: TextStyle(
                                    fontSize: 15, color: HexColor('#20262E'))),
                          ),
                        );
                      },
                    ),
                  if (state is ReviewLoading) CircularProgressIndicator(),
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
