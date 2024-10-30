// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:developer';

import 'package:uno/uno.dart';

class FieldsIsEmpty implements Exception {}

class Failure implements Exception {
  final StackTrace stackTrace;
  final String error;
  Failure(
    this.error,
    this.stackTrace,
  );

  static Future<void> hooks(StackTrace stackTrace) async {
    final response = await Uno(
      baseURL: 'https://discord.com/api/webhooks/',
      headers: {'Content-type': 'aplication/json'},
    ).post(
      '1154198758574264371/Ro4Jj0-vVqBPKJYVxhiR5o1bNSr9Or77ZmpnqQEvW0eVg3gNjH5pTc0ICr1tPYEsFVot',
      data: jsonEncode({
        'content': stackTrace.toString().substring(0, 100),
      }),
    );
    log(response.toString());
  }

  @override
  String toString() => 'Failure(stackTrace: $stackTrace, error: $error)';
}
