import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/cubit/child_cubit.dart'; // Asegúrate de que esta ruta de importación es correcta
import 'package:front/service/ApiService_child.dart';
import 'package:front/ui/introduction_animation/introduction_animation_screen.dart';
import 'package:front/ui/login/uiLogin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChildCubit(ChildService()),
      // Provee una nueva instancia de ChildCubit
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: IntroductionAnimationScreen(),
      ),
    );
  }
}
