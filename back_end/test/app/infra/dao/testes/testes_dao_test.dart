import 'package:back_end/app/api/api.dart';
import 'package:back_end/app/api/dto/teste_dto.dart';
import 'package:back_end/app/infra/infra.dart';
import 'package:test/test.dart';

import '../../../../common_mock.dart';

void main() {
  late final TesteDAO testeDAO;
  late final MySQl mySQl;
  setUpAll(() async {
    mySQl = MySQLMock();
    testeDAO = TesteDAO(connection: mySQl);
  });
  group('Teste do TesteDAO => ', () {
    test('Espero buscar os tickets de teste de um historico', () async {
      final result = await testeDAO.get(
        requestParams: RequestParams(
          body: {
            'idHistorico': 1,
          },
        ),
      );
      expect(result, isA<List<TesteDto>>());
    });

    test('Espero criar um ticket de teste', () async {
      final result = await testeDAO.create(
        requestParams: RequestParams(
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
        ),
      );
      expect(result, equals(true));
    });
  });
}
