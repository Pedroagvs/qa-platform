import 'package:back_end/app/api/api.dart';
import 'package:back_end/app/infra/infra.dart';
import 'package:test/test.dart';

import '../../../../common_mock.dart';

void main() {
  late final AplicationDAO aplicationDAO;
  late final MySQl mySQl;
  setUpAll(() async {
    mySQl = MySQLMock();
    aplicationDAO = AplicationDAO(connection: mySQl);
  });
  group('Teste do TesteDAO => ', () {
    test('Espero salvar uma aplicação no banco de dados.', () async {
      final result = await aplicationDAO.create(
        requestParams: RequestParams(
          body: {
            'titulo': 'teste2',
            'plataforma': 'mobile',
          },
        ),
      );
      expect(result, equals(true));
    });
    test('Espero editar uma aplicação no banco de dados.', () async {
      final result = await aplicationDAO.update(
        requestParams: RequestParams(
          body: {
            'idAplicacao': 1,
            'titulo': 'teste2',
            'plataforma': 'mobile',
          },
        ),
      );
      expect(result, equals(true));
    });
  });
  test('Espero deletar uma aplicação ja existente', () async {
    final result = await aplicationDAO.delete(
      requestParams: RequestParams(
        body: {
          'idAplicacao': 1,
        },
      ),
    );
    expect(result, equals(true));
  });
}
