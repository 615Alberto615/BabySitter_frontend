import 'package:flutter/material.dart';

import '../../component/filds_forms.dart';

import 'package:flutter/material.dart';

import '../../component/filds_forms.dart';

class NewBooking extends StatelessWidget {
  final TextEditingController addressController = TextEditingController();
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 335,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 10,
                    height: 235,
                    width: width,
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/intro/3b.png'),
                              fit: BoxFit.fill)),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      child: Text(
                    "Información para el servicio",
                    style: TextStyle(
                        color: Color.fromRGBO(49, 39, 79, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  )),
                  SizedBox(
                    height: 30,
                  ),
                  fildform(
                      controller: addressController,
                      hint: 'Dirección',
                      label: 'Dirección',
                      icon: Icons.home),
                  SizedBox(
                    height: 20,
                  ),
                  fildform(
                      controller: startTimeController,
                      hint: 'Hora de inicio',
                      label: 'Hora de inicio',
                      icon: Icons.timer),
                  SizedBox(
                    height: 20,
                  ),
                  fildform(
                      controller: endTimeController,
                      hint: 'Hora de fin',
                      label: 'Hora de fin',
                      icon: Icons.timer_off),
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      /*
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FindBs()),
                      );*/
                    },
                    child: Container(
                      height: 50,
                      margin: EdgeInsets.symmetric(horizontal: 60),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: HexColor("#9695ff"),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(196, 135, 198, .3),
                            blurRadius: 20,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          "Buscar niñera",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
