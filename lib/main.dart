import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/cubit/babysitter_cubit.dart';
import 'package:front/service/ApiService_babysitter.dart';
import 'package:front/service/LoginService.dart';
import 'package:front/service/ApiService_child.dart';
import 'package:front/ui/introduction_animation/introduction_animation_screen.dart';
import 'package:front/ui/login/uiLogin.dart';
import 'package:front/cubit/login_cubit.dart';
import 'package:front/cubit/child_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubit>(
          create: (context) => LoginCubit(LoginService()),
        ),
        BlocProvider<ChildCubit>(
          create: (context) => ChildCubit(ChildService()),
        ),
        BlocProvider<BabysitterCubit>(
          create: (context) => BabysitterCubit(BabysitterService()),
        ), // Aquí agregamos el proveedor para BabysitterCubit
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: IntroductionAnimationScreen(),
      ),
    );
  }
}
