import 'package:back_end/app/api/api.dart';
import 'package:back_end/app/api/dto/aplicacao_dto.dart';
import 'package:back_end/app/data/data.dart';
import 'package:back_end/app/domain/domain.dart';
import 'package:back_end/app/domain/exceptions/aplicacao/aplicacao_exeception.dart';
import 'package:back_end/app/infra/infra.dart';
import 'package:test/test.dart';

void main() {
  late final MySQl mySQl;
  late final AplicacaoUseCase aplicacaoUseCase;
  setUpAll(() async {
    mySQl = MySQl();
    await mySQl.initConnection();
    aplicacaoUseCase = AplicacaoService(
      aplicacaoGateway: AplicacaoDAO(connection: mySQl),
    );
  });
  group('Testes de AplicaçãoUseCase => ', () {
    test('Espero receber uma lista de Aplicações', () async {
      final result = await aplicacaoUseCase.get();
      expect(result, isA<List<AplicacaoDto>>());
    });

    test('Espero criar uma nova aplicação', () async {
      final result = await aplicacaoUseCase.create(
        requestParams: RequestParams(
          body: {
            'titulo': 'Teste',
            'plataforma': 'mobile',
          },
        ),
      );
      expect(result, equals(true));
    });

    test('Espero deletar uma aplicação existente', () async {
      final result = await aplicacaoUseCase.delete(
        requestParams: RequestParams(
          body: {
            'idAplicacao': 1,
          },
        ),
      );
      expect(result, equals(true));
    });
    test('Espero receber um exceção deletar uma aplicação não existente',
        () async {
      expect(
        await aplicacaoUseCase.delete(
          requestParams: RequestParams(
            body: {
              'idAplicacao': 9999999,
            },
          ),
        ),
        throwsA(isA<ApplicationNotExists>()),
      );
    });
  });

  test('Espero editar o título da aplicação cadastrada', () async {
    final result = await aplicacaoUseCase.update(
      requestParams: RequestParams(
        body: {
          'idAplicacao': 1,
          'titulo': 'testedaedicao',
        },
      ),
    );
    expect(
      result,
      equals(true),
    );
  });
}
