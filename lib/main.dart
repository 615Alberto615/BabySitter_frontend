import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/cubit/activity_cubit.dart';
import 'package:front/cubit/babysitter_cubit.dart';
import 'package:front/cubit/booking_cubit.dart';
import 'package:front/cubit/hability_cubit.dart';
import 'package:front/cubit/med_cubit.dart';
import 'package:front/cubit/review_cubit.dart';
import 'package:front/cubit/telefonos_cubit.dart';
import 'package:front/cubit/user_cubit.dart';
import 'package:front/service/ApiSerice_booking.dart';
import 'package:front/service/ApiService_User.dart';
import 'package:front/service/ApiService_activity.dart';
import 'package:front/service/ApiService_babysitter.dart';
import 'package:front/service/ApiService_hability.dart';
import 'package:front/service/ApiService_med.dart';
import 'package:front/service/ApiService_review.dart';
import 'package:front/service/ApiService_telefonos.dart';
import 'package:front/service/LoginService.dart';
import 'package:front/service/ApiService_child.dart';
import 'package:front/ui/introduction_animation/introduction_animation_screen.dart';
import 'package:front/ui/login/uiLogin.dart';
import 'package:front/cubit/login_cubit.dart';
import 'package:front/cubit/child_cubit.dart';

import 'package:front/cubit/reglas_cubit.dart';
import 'package:front/service/ApiService_reglas.dart';

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
        BlocProvider<BookingCubit>(
          create: (context) => BookingCubit(BookingService()),
        ),
        BlocProvider<ReglasCubit>(
          create: (context) => ReglasCubit(ReglasService()),
        ),
        BlocProvider<TelefonoCubit>(
          create: (context) => TelefonoCubit(TelefonoService()),
        ),
        BlocProvider<UsuarioCubit>(
          create: (context) => UsuarioCubit(UsuarioService()),
        ),
        BlocProvider<ActivityCubit>(
          create: (context) => ActivityCubit(ActivityService()),
        ),
        BlocProvider<ReviewCubit>(
          create: (context) => ReviewCubit(ReviewService()),
        ),
        BlocProvider<MedCubit>(
          create: (context) => MedCubit(MedService()),
        ),
        BlocProvider<HabilityCubit>(
          create: (context) => HabilityCubit(HabilityService()),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: IntroductionAnimationScreen(),
      ),
    );
  }
}
