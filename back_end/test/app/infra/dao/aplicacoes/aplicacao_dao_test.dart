import 'package:back_end/app/api/api.dart';
import 'package:back_end/app/infra/infra.dart';
import 'package:test/test.dart';

import '../../../../common_mock.dart';

void main() {
  late final AplicacaoDAO aplicacaoDAO;
  late final MySQl mySQl;
  setUpAll(() async {
    mySQl = MySQLMock();
    aplicacaoDAO = AplicacaoDAO(connection: mySQl);
  });
  group('Teste do TesteDAO => ', () {
    test('Espero salvar uma aplicação no banco de dados.', () async {
      final result = await aplicacaoDAO.create(
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
      final result = await aplicacaoDAO.update(
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
    final result = await aplicacaoDAO.delete(
      requestParams: RequestParams(
        body: {
          'idAplicacao': 1,
        },
      ),
    );
    expect(result, equals(true));
  });
}
