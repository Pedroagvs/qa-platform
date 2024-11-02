import 'dart:convert';
import 'dart:developer';

import 'package:uno/uno.dart';

Future<void> hooks(String error, StackTrace? stackTrace) async {
  try {
    final response = await Uno(
      headers: {},
    ).post(
      '',
      data: {
        'content': jsonEncode(
          (error + stackTrace.toString()).length > 1000
              ? (error + stackTrace.toString()).substring(0, 998)
              : error,
        ),
      },
    );

    log(response.data.toString());
  } catch (e, s) {
    log(name: 'Error hooks', e.toString(), stackTrace: s);
    log(name: 'Error não enviado', error, stackTrace: stackTrace);
  }
}
