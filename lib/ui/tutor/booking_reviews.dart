import 'package:flutter/material.dart';
import 'package:front/cubit/review_cubit.dart';
import 'package:front/models/modelo_babysitter.dart';

import 'package:front/models/modelo_booking.dart';
import 'package:front/ui/babysitter/component/img_topBs.dart';

import '../../component/bottoms.dart';
import '../../component/filds_forms.dart';
import 'component/img_top2.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class reviewsScreenBs extends StatefulWidget {
  final int userId;
  final int babysitterId;
  final Babysitter babysitter;
  const reviewsScreenBs(
      {Key? key,
      required this.userId,
      required this.babysitterId,
      required this.babysitter})
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
      fetchReviewsAndAverage();
    } catch (e) {
      print(e);
    }

    print(widget.userId);
  }

  void fetchReviewsAndAverage() async {
    try {
      await context.read<ReviewCubit>().fetchAverageReview(
          'http://10.0.2.2:8080/api/v1/review/babysitter/',
          widget.babysitterId);
    } catch (e) {
      print(e);
    }

    try {
      await context.read<ReviewCubit>().fetchReview(
          'http://10.0.2.2:8080/api/v1/review/babysitter/',
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
          body: BlocConsumer<ReviewCubit, ReviewState>(
            listener: (context, state) {
              if (state is ReviewAverageLoaded) {
                _reviewController.text = state.averageReview.toString();
              }
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
                  Center(
                    child: Text('Reseñas y calificacion de la niñera:',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: HexColor('#20262E'))),
                  ),
                  SizedBox(height: 10),
                  CircleAvatar(
                    radius: 120,
                    backgroundImage: AssetImage('assets/xddd.png'),
                    /*radius: 100,
                    backgroundImage: AssetImage('assets/user5.png'),*/
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: Text(
                        widget.babysitter.userName +
                            ' ' +
                            widget.babysitter.userLastName,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: HexColor('#20262E'))),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Calificacion de 1 a 5 de la niñera',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: HexColor('#20262E'),
                    ),
                  ),
                  Container(
                    height: 120,
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Image.asset('assets/st2.png'),
                        Text(
                          _reviewController.text,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Reseñas de la niñera',
                    textAlign: TextAlign.center,
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
                  if (state is ReviewLoading)
                    Center(child: CircularProgressIndicator()),
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
