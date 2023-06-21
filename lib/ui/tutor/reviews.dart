import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:front/cubit/review_cubit.dart';

import 'package:front/models/modelo_booking.dart';
import 'package:front/ui/babysitter/component/img_topBs.dart';

import '../../component/bottoms.dart';
import '../../component/filds_forms.dart';
import 'component/img_top2.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class reviewsScreen extends StatefulWidget {
  final int tutorId;
  final int userId;
  final Booking booking;
  final int babysitterId;
  const reviewsScreen(
      {Key? key,
      required this.tutorId,
      required this.userId,
      required this.booking,
      required this.babysitterId})
      : super(key: key);
  @override
  _PerfilScreenState createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<reviewsScreen> {
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
                    child: Text('Reseña del servicio',
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: HexColor('#20262E'))),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Ingresa una reseña y un calificacion para la niñera que te atendió',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: HexColor('#20262E'),
                    ),
                  ),
                  SizedBox(height: 30),
                  fildform(
                    controller: _reviewController,
                    hint: 'Ingresa tu reseña',
                    label: 'Reseña',
                    icon: Icons.reviews,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'calificacion para la niñera',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: HexColor('#20262E'),
                    ),
                  ),
                  Center(
                    child: RatingBar.builder(
                      initialRating: 3,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                        _calificaciontelController.text =
                            rating.toInt().toString();
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  CustomButton(
                    onPressed: () {
                      if (_reviewController.text.isNotEmpty &&
                          _calificaciontelController.text.isNotEmpty) {
                        int? calificacion =
                            int.tryParse(_calificaciontelController.text);
                        if (calificacion != null &&
                            calificacion >= 1 &&
                            calificacion <= 5) {
                          final telefonoCubit = context.read<ReviewCubit>();
                          var result = telefonoCubit.createReview(
                            'http://10.0.2.2:8080/api/v1/review',
                            {
                              'bookingId': widget.booking.bookingId,
                              'review': _reviewController.text,
                              'stars': _calificaciontelController.text,
                            },
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'Por favor, introduce una calificación válida del 1 al 5.'),
                            ),
                          );
                        }
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
                  Text(
                    'Reseñas de la niñera',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: HexColor('#20262E'),
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
                          color: index % 2 == 0
                              ? Colors.grey[200]
                              : Colors
                                  .white, // Alternando los colores de las tarjetas
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: ListTile(
                            leading: Icon(Icons.reviews_outlined,
                                color: HexColor('#20262E')),
                            title: Text(rev.review,
                                style: TextStyle(
                                    fontSize: 15, color: HexColor('#20262E'))),
                            subtitle: RatingBarIndicator(
                              rating: rev.stars.toDouble(),
                              itemBuilder: (context, index) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              itemCount: 5,
                              itemSize: 20.0,
                              direction: Axis.horizontal,
                            ),
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
