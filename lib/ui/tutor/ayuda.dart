import 'package:flutter/material.dart';
import 'package:front/ui/tutor/component/img_top2.dart';

class AyudaScreen extends StatelessWidget {
  const AyudaScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Container(
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 10,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                myfam7(),
                Center(
                  child: Text(
                    'AYUDA',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'ASAP Sitter',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'ASAP Sitter es una aplicación que te permite encontrar y ponerte en contacto con niñeras en tu ciudad para el cuidado de tus hijos.',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 20),
                Text(
                  'Términos y Condiciones',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Al utilizar esta aplicación, aceptas los siguientes términos y condiciones:',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 10),
                Text('1. Uso de la aplicación:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.justify),
                SizedBox(height: 10),
                Text(
                  '- Debes tener al menos 18 años de edad para utilizar la aplicación o contar con el consentimiento de un adulto responsable.\n'
                  '- Debes proporcionar información precisa y actualizada al registrarte en la aplicación. Te comprometes a utilizar la aplicación de manera responsable y cumplir con todas las leyes y regulaciones aplicables.',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 20),
                Text('2. Responsabilidad del usuario:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.justify),
                SizedBox(height: 10),
                Text(
                  'Como usuario de ASAP Sitter, tienes ciertas responsabilidades y obligaciones al utilizar la aplicación:\n\n'
                  '- Debes garantizar que la información proporcionada sobre tus hijos, como sus nombres y edades, sea precisa y esté actualizada.\n\n'
                  '- Eres responsable de evaluar y seleccionar a las niñeras que utilices a través de la aplicación. Te recomendamos realizar una entrevista previa y verificar las referencias y experiencia de las niñeras antes de contratar sus servicios.\n\n'
                  '- Debes mantener la confidencialidad de tu cuenta y no compartir tus credenciales de inicio de sesión con terceros. Eres responsable de todas las actividades realizadas con tu cuenta.',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 20),
                Text(
                  'Si tienes alguna pregunta o necesitas ayuda adicional, por favor contáctanos en nuestras redes sociales.',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ));
  }
}
