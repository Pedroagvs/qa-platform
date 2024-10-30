import 'dart:convert';

import 'package:back_end/app/api/api.dart';
import 'package:back_end/app/data/data.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class AuthServiceMock extends Mock implements AuthService {}

void main() {
  final authHandler = AuthHandler(
    authUseCase: AuthServiceMock(),
  );
  group('Auth handler -> ', () {
    test('Deve conter um response handler', () async {
      final result =
          await authHandler.call(requestParams: RequestParams(body: {}));
      expect(result, isA<ResponseHandler>());
    });
    test('Deve retornar um Status handler ok ', () async {
      final result =
          await authHandler.call(requestParams: RequestParams(body: {}));
      expect(result.statusHandler, StatusHandler.ok);
    });
    test('Deve retornar um json', () async {
      final result =
          await authHandler.call(requestParams: RequestParams(body: {}));
      expect(jsonDecode(result.body.toString()), isA<Map<String, dynamic>>());
    });
  });
}
