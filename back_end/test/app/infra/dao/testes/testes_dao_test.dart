import 'package:back_end/app/api/api.dart';
import 'package:back_end/app/api/dto/test_dto.dart';
import 'package:back_end/app/infra/infra.dart';
import 'package:test/test.dart';

import '../../../../common_mock.dart';

void main() {
  late final TestDAO testeDAO;
  late final MySQl mySQl;

  setUpAll(() async {
    mySQl = MySQLMock();
    testeDAO = TestDAO(connection: mySQl);
  });
  group('Teste do TesteDAO => ', () {
    test('Espero buscar os tickets de teste de um historico', () async {
      final request = RequestParams(
        body: {
          'idHistorico': 1,
        },
      );

      final result = await testeDAO.get(
        requestParams: request,
      );
      expect(result, isA<List<TestDto>>());
    });

    test('Espero criar um ticket de teste', () async {
      final request = RequestParams(
        body: {
          'idHistorico': 1,
          'criador': 'criador',
          'feature': 'feature',
          'tag': 'Crítico',
          'descricao': 'descricao',
          'passos': 'passos',
          'observacoes': 'observacoes',
          'usuario': 'usuario',
          'senha': 'senha',
          'situacao': 'Pendente',
        },
      );

      final result = await testeDAO.create(
        requestParams: request,
      );
      expect(result, equals(true));
    });
  });
}
