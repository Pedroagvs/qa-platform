import 'package:back_end/app/api/api.dart';
import 'package:back_end/app/api/dto/aplication_dto.dart';
import 'package:back_end/app/data/data.dart';
import 'package:back_end/app/domain/domain.dart';
import 'package:back_end/app/domain/exceptions/aplicacao/aplicacao_exeception.dart';
import 'package:back_end/app/infra/infra.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MySQlMock extends Mock implements MySQl {}

void main() {
  late final Connection connection;
  late final AplicationUseCase aplicationUseCase;
  late final AplicationDAO aplicationDAO;
  setUpAll(() async {
    connection = MySQlMock();
    aplicationDAO = AplicationDAO(connection: connection);
    aplicationUseCase = AplicationService(
      aplicationGateway: aplicationDAO,
    );

    when(
      () => connection.query(''),
    ).thenAnswer(
      (_) async => [
        {'': ''},
      ],
    );
  });
  group('Testes de AplicaçãoUseCase => ', () {
    test('Espero receber uma lista de Aplicações', () async {
      // when(
      //   () => aplicationDAO.get(),
      // ).thenAnswer((_) async => <AplicationDto>[]);
      // when(
      //   () => aplicationUseCase.get(),
      // ).thenAnswer((_) async => <AplicationDto>[]);

      final result = await aplicationUseCase.get();
      expect(result, isA<List<AplicationDto>>());
    });

    test('Espero criar uma nova aplicação', () async {
      final request = RequestParams(
        body: {
          'titulo': 'Teste',
          'plataforma': 'mobile',
        },
      );
      when(
        () => aplicationUseCase.create(requestParams: request),
      ).thenAnswer((_) async => true);
      final result = await aplicationUseCase.create(
        requestParams: request,
      );
      expect(result, equals(true));
    });

    test('Espero deletar uma aplicação existente', () async {
      final result = await aplicationUseCase.delete(
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
        await aplicationUseCase.delete(
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
    final result = await aplicationUseCase.update(
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
