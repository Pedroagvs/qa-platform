import 'package:get_it/get_it.dart';
import 'package:quality_assurance_platform/core/client/uno_client.dart';
import 'package:quality_assurance_platform/core/client/uno_client_imp.dart';
import 'package:quality_assurance_platform/core/config/const_server.dart';
import 'package:uno/uno.dart';

void injectUnoClient(GetIt getIt) {
  getIt.registerLazySingleton<UnoClient>(
    () => UnoClientImp(
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
