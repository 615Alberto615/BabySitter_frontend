import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/models/modelo_regla.dart';
import 'package:front/models/modelo_report.dart';
import 'package:front/models/modelo_review.dart';
import 'package:front/service/ApiService_reglas.dart';
import 'package:equatable/equatable.dart';
import 'package:front/service/ApiService_report.dart';
import 'package:front/service/ApiService_review.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
part 'report_state.dart';

class ReportCubit extends Cubit<ReportState> {
  final ReportService _reviewservice;

  ReportCubit(this._reviewservice) : super(ReportInitial());

  Future<void> fetchReport(String apiUrl, String parentId) async {
    emit(ReportLoading());
    try {
      List<Report> Reports = await _reviewservice.fetchReport(apiUrl, parentId);
      emit(ReportLoaded(Reports));
    } catch (e) {
      emit(ReportError('Error loading children: $e'));
    }
  }

  Future<bool> createReport(
      String apiUrl, Map<String, dynamic> requestBody) async {
    emit(ReportLoading());
    try {
      var body = json.encode(requestBody);
      var response = await _reviewservice.createReport(apiUrl, requestBody);

      if (response.statusCode == 200) {
        emit(ReportCreated());
        return true;
      } else {
        emit(ReportError('Error al crear la report'));
        return false;
      }
    } catch (_) {
      emit(ReportError('Error al crear la report'));
      return false;
    }
  }
}
