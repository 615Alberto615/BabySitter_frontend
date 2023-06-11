import 'package:flutter/material.dart';
import 'package:front/ui/babysitter/options_bs.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../tutor/component/ColoresTutor.dart';
import '../tutor/component/icons.dart';
import 'component/Bottom_bs.dart';
import 'list_bs.dart';

int? babysitterId;

class MainScreenBs extends StatefulWidget {
  final int userId;
  const MainScreenBs({Key? key, required this.userId}) : super(key: key);
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreenBs>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  List<TabIconData> tabIconsList = TabIconData.tabIconsList;
  Widget tabBody = Container(color: ColoresTutor.background);

  Future<void> getBabysitterId() async {
    final response = await http.get(Uri.parse(
        'http://10.0.2.2:8080/api/v1/babysitter/user/${widget.userId}'));

    if (response.statusCode == 200) {
      // Si el servidor devuelve una respuesta OK, parseamos el JSON.
      final json = jsonDecode(response.body);
      setState(() {
        babysitterId = json['data']['babysitterId'];
        // Actualizado para acceder a tutorId correctamente
        print(babysitterId);
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
    return WillPopScope(
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
      onWillPop: () async {
        return false;
      },
    );
  }

  Widget bottomBar() {
    return Column(
      children: <Widget>[
        const Expanded(
          child: SizedBox(),
        ),
        BottomBarViewV2(
          tabIconsList: tabIconsList,
          changeIndex: (int index) {
            if (index == 0) {
              setState(() {
                tabBody = HomeLB(
                  userId: widget.userId,
                  babysitterId: babysitterId ?? 0,
                );

                for (int i = 0; i < tabIconsList.length; i++) {
                  tabIconsList[i].isSelected = i == index;
                }
              });
            } else if (index == 3) {
              setState(() {
                tabBody = OptionsBs();
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
