import 'package:back_end/app/api/api.dart';
import 'package:back_end/app/domain/exceptions/common/common_exceptions.dart';
import 'package:back_end/app/infra/infra.dart';
import 'package:test/test.dart';

import '../../../../common_mock.dart';

void main() {
  late final RegisterDAO registerDAO;
  late final MySQl mySQl;
  setUpAll(() async {
    mySQl = MySQLMock();
    registerDAO = RegisterDAO(connection: mySQl);
  });
  group('Teste do RegisterDAO => ', () {
    test('Espero criar uma novo usuário', () async {
      final result = await registerDAO.call(
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
        () async => registerDAO.call(
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
  });
}
