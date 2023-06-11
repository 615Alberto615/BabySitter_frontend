import 'package:flutter/material.dart';

class ModeloToken {
  static String? _token;

  static String? get token => _token;

  static set token(String? value) {
    _token = value;
  }
}
