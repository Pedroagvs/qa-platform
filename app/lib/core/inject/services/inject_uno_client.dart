// ignore_for_file: avoid_redundant_argument_values

import 'package:get_it/get_it.dart';
import 'package:quality_assurance_platform/core/client/client.dart';
import 'package:quality_assurance_platform/core/client/uno_client_imp.dart';
import 'package:quality_assurance_platform/core/config/const_server.dart';
import 'package:uno/uno.dart';

void injectClient(GetIt getIt) {
  getIt.registerLazySingleton<Client>(
    () => ClientImp(
      uno: Uno(
        timeout: const Duration(seconds: 180),
        baseURL: DATA_BASE_URL,
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    ),
  );
}
