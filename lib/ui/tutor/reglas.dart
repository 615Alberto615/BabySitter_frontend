import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/cubit/reglas_cubit.dart';
import 'package:front/service/ApiService_reglas.dart';
import 'package:front/ui/tutor/perfil.dart';

import '../../component/filds_forms.dart';
import 'component/img_top2.dart';

class ReglasScreen extends StatefulWidget {
  final int tutorId;
  final int userId;
  const ReglasScreen({Key? key, required this.tutorId, required this.userId})
      : super(key: key);
  @override
  _ReglasScreenState createState() => _ReglasScreenState();
}

class _ReglasScreenState extends State<ReglasScreen> {
  final TextEditingController ruleController = TextEditingController();
  late ReglasCubit reglasCubit;
  @override
  void initState() {
    super.initState();
    reglasCubit = ReglasCubit(ReglasService());
    reglasCubit.fetchReglas(widget.tutorId);
  }

  @override
  void dispose() {
    reglasCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ReglasCubit>.value(
      value: reglasCubit,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: BlocConsumer<ReglasCubit, ReglasState>(
          listener: (context, state) {
            if (state is ReglasError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error: ${state.message}')),
              );
            }
          },
          builder: (context, state) {
            return ListView(
              padding: EdgeInsets.all(20),
              children: [
                myfam3(),
                SizedBox(height: 10),
                Center(
                  child: Text('Reglas de la Casa',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: HexColor('#20262E'))),
                ),
                SizedBox(height: 30),
                fildform(
                  controller: ruleController,
                  hint: 'Introduce la regla',
                  label: 'Regla',
                  icon: Icons.rule,
                ),
                SizedBox(height: 20),
                PerfilButton(
                  text: 'Guardar Regla',
                  onPressed: () {
                    context.read<ReglasCubit>().addRegla(ruleController.text);
                    ruleController.clear();
                  },
                ),
                SizedBox(height: 20),
                if (state is ReglasLoaded)
                  for (var regla in state.reglas)
                    ListTile(
                      title: Text(regla.regla),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          /*
                            context.read<ReglasCubit>().deleteRegla(regla.id);*/
                        },
                      ),
                    ),
                if (state is ReglasLoading) CircularProgressIndicator(),
                SizedBox(height: 10),
              ],
            );
          },
        ),
      ),
    );
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
