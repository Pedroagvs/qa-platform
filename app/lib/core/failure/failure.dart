import 'dart:developer';

class Failure implements Exception {
  final String? errorMessage;
  final String? label;
  StackTrace? stackTrace;
  Failure({this.errorMessage, this.label, this.stackTrace}) {
    if (errorMessage != null && stackTrace != null) {
      log(errorMessage!, stackTrace: stackTrace);
    }
  }
}
