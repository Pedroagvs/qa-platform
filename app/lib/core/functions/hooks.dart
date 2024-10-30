import 'dart:convert';
import 'dart:developer';

import 'package:uno/uno.dart';

Future<void> hooks(String error, StackTrace? stackTrace) async {
  try {
    final response = await Uno(
      baseURL: 'https://discord.com/api/webhooks/',
      headers: {
        'Authorization':
            'Bearer Ro4Jj0-vVqBPKJYVxhiR5o1bNSr9Or77ZmpnqQEvW0eVg3gNjH5pTc0ICr1tPYEsFVot',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    ).post(
      '1154198758574264371/Ro4Jj0-vVqBPKJYVxhiR5o1bNSr9Or77ZmpnqQEvW0eVg3gNjH5pTc0ICr1tPYEsFVot',
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
