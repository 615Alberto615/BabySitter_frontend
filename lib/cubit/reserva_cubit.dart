import '../models/modelo_reserva.dart';
import 'package:bloc/bloc.dart';

class ReservaCubit extends Cubit<ReservaState> {
  ReservaCubit() : super(ReservaState(reservas: []));

  void deleteReserva(Reserva reserva) {
    state.reservas.remove(reserva);
    emit(ReservaState(reservas: List.from(state.reservas)));
  }
}

class ReservaState {
  final List<Reserva> reservas;

  ReservaState({required this.reservas});
}
