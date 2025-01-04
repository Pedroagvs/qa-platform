import 'package:back_end/app/api/api.dart';
import 'package:back_end/app/api/dto/user_dto.dart';
import 'package:back_end/app/domain/exceptions/common/common_exceptions.dart';
import 'package:back_end/app/infra/infra.dart';
import 'package:test/test.dart';

import '../../../../common_mock.dart';

void main() {
  late final AuthDAO authDAO;
  late final MySQl mySQl;
  setUpAll(() async {
    mySQl = MySQLMock();
    authDAO = AuthDAO(connection: mySQl);
  });
  group('Teste do AuhDAO', () {
    test('Espero obter as informações do usuário.', () async {
      final result = await authDAO.login(
        requestParams: RequestParams(
          body: {
            'email': 'teste@gmail.com',
            'senha': '123456',
          },
        ),
      );
      expect(result, isA<UserDto>());
    });
  });

  test('Espero criar uma novo usuário', () async {
    final result = await authDAO.createAccount(
      requestParams: RequestParams(
        body: {
          'email': 'teste@gmail.com',
          'senha': '123456',
          'nome': 'teste',
          'cargo': 'tester',
        },
      ),
    );
    expect(result, equals(true));
  });
  test('Espero receber uma exceção com e-mail inválido', () async {
    expect(
      () async => authDAO.createAccount(
        requestParams: RequestParams(
          body: {
            'senha': '123456',
            'nome': 'teste',
          },
        ),
      ),
      throwsA(isA<FieldsIsEmpty>),
    );
  });
}
