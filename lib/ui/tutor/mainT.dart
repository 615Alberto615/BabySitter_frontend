import 'dart:convert';
import 'package:front/models/modelo_token.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'booking.dart';
import 'component/Bottom_Tutor.dart';
import 'component/ColoresTutor.dart';
import 'component/icons.dart';
import 'family_tutor.dart';
import 'history_tutor.dart';
import 'home_tutor.dart';
import 'opciones_tutor.dart';

int? tutorId;
Widget tabBody = Center(child: CircularProgressIndicator());

class MainScreen extends StatefulWidget {
  final int userId;

  const MainScreen({Key? key, required this.userId}) : super(key: key);
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<TabIconData> tabIconsList = TabIconData.tabIconsList;
  Widget tabBody = Container(color: ColoresTutor.background);
  String? token = ModeloToken.token;

  Future<void> getTutorId() async {
    final response = await http.get(
      Uri.parse('http://10.0.2.2:8080/api/v1/tutor/user/${widget.userId}'),
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      // Si el servidor devuelve una respuesta OK, parseamos el JSON.
      final json = jsonDecode(response.body);
      setState(() {
        tutorId = json['data']['tutorId'];
        // Actualizado para acceder a tutorId correctamente
        print(tutorId);
      });
    } else {
      // Si la respuesta no es OK, lanzamos un error.
      throw Exception('Failed to load tutor id');
    }
  }

  @override
  void initState() {
    tabIconsList.forEach((TabIconData tab) {
      tab.isSelected = false;
    });
    tabIconsList[0].isSelected = true;

    getTutorId().then((_) {
      // Después de obtener el babysitterId, cambia tabBody a HomeLB
      setState(() {
        tabBody = HomeT(
          userId: widget.userId,
          tutorId: tutorId ?? 0,
        );
      });
    });
    getTutorId();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false; // Esto bloquea el botón de retroceso
      },
      child: Container(
        color: ColoresTutor.background,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: <Widget>[
              tabBody,
              bottomBar(),
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomBar() {
    return Column(
      children: <Widget>[
        const Expanded(
          child: SizedBox(),
        ),
        BottomBarView(
          tabIconsList: tabIconsList,
          addClick: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NewBooking(
                        tutorId: tutorId ?? 0,
                        userId: widget.userId,
                      )),
            );
          },
          changeIndex: (int index) {
            if (index == 0) {
              setState(() {
                tabBody = HomeT(
                  tutorId: tutorId ?? 0,
                  userId: widget.userId,
                );
                for (int i = 0; i < tabIconsList.length; i++) {
                  tabIconsList[i].isSelected = i == index;
                }
              });
            } else if (index == 1) {
              setState(() {
                tabBody = familyT(
                  tutorId: tutorId ?? 0,
                  userId: widget.userId,
                );
                for (int i = 0; i < tabIconsList.length; i++) {
                  tabIconsList[i].isSelected = i == index;
                }
              });
            } else if (index == 2) {
              setState(() {
                tabBody = HistoryT(
                  tutorId: tutorId ?? 0,
                  userId: widget.userId,
                );
                for (int i = 0; i < tabIconsList.length; i++) {
                  tabIconsList[i].isSelected = i == index;
                }
              });
            } else if (index == 3) {
              setState(() {
                tabBody = OptionsT(
                  tutorId: tutorId ?? 0,
                  userId: widget.userId,
                );
                for (int i = 0; i < tabIconsList.length; i++) {
                  tabIconsList[i].isSelected = i == index;
                }
              });
            }
          },
        ),
      ],
    );
  }
}
