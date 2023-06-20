import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/models/modelo_regla.dart';
import 'package:front/models/modelo_review.dart';
import 'package:front/service/ApiService_reglas.dart';
import 'package:equatable/equatable.dart';
import 'package:front/service/ApiService_review.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
part 'review_state.dart';

class ReviewCubit extends Cubit<ReviewState> {
  final ReviewService _reviewservice;

  ReviewCubit(this._reviewservice) : super(ReviewInitial());

  Future<void> fetchReview(String apiUrl, String parentId) async {
    emit(ReviewLoading());
    try {
      List<Review> Reviews = await _reviewservice.fetchReview(apiUrl, parentId);
      emit(ReviewLoaded(Reviews));
    } catch (e) {
      emit(ReviewError('Error loading children: $e'));
    }
  }

  Future<bool> createReview(
      String apiUrl, Map<String, dynamic> requestBody) async {
    emit(ReviewLoading());
    try {
      var body = json.encode(requestBody);
      var response = await _reviewservice.createReview(apiUrl, requestBody);

      if (response.statusCode == 200) {
        emit(ReviewCreated());
        return true;
      } else {
        emit(ReviewError('Error al crear la review'));
        return false;
      }
    } catch (_) {
      emit(ReviewError('Error al crear la review'));
      return false;
    }
  }
}
