import 'dart:convert';
import 'dart:typed_data';

import 'package:back_end/app/api/api.dart';
import 'package:back_end/app/api/dto/historic_dto.dart';
import 'package:back_end/app/infra/infra.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockSQL extends Mock implements MySQl {}

class HistoricDAOMock extends Mock implements HistoricDAO {}

void main() {
  late final Connection connection;
  late final HistoricDAO historicoDAO;
  setUpAll(() {
    connection = MockSQL();
    historicoDAO = HistoricDAOMock();
    when(
      () => connection.query(''),
    ).thenAnswer(
      (_) async => [
        {'': null},
      ],
    );
  });
  group('Teste do HistoricoDAO => ', () {
    test('Espero criar uma novo historico', () async {
      final request = RequestParams(
        body: {
          'idAplicacao': 1,
          'fonte': '1.0.0',
          'descricao': 'testesdas',
          'criador': 'pedro',
        },
      );

      when(
        () async => historicoDAO.create(requestParams: request),
      ).thenAnswer((_) async => true);
      final result = await historicoDAO.create(requestParams: request);
      expect(result, equals(true));
    });
    test('Espero criar uma novo historico', () async {
      final result = await historicoDAO.create(
        requestParams: RequestParams(
          body: {
            'formdata': jsonEncode({
              'dados': {
                'idAplicacao': 1,
                'fonte': '1.0.0',
                'descricao': 'testesdas',
                'criador': 'pedro',
              },
              'arquivos': {
                'image.jpg':
                    '[12,31,23,12,3,1,23,12,31,23,23,12,31,23,1,2,3,1,2,31]',
              },
            }),
          },
        ),
      );
      expect(result, equals(true));
    });
    test('Espero criar uma novo historico', () async {
      final result = await historicoDAO.get(
        requestParams: RequestParams(
          body: {
            'idAplicacao': '1',
            'offset': '0',
          },
        ),
      );
      expect(result, isA<List<HistoricDto>>());
    });

    test('Espero atualizar um historico', () async {
      final result = await historicoDAO.update(
        requestParams: RequestParams(
          body: {
            'idHistorico': '1',
            'descricao': 'testeasdsadasdasdasdasdasdasdasd',
          },
        ),
      );
      expect(result, equals(true));
    });
    test('Espero adicionar um arquivo vinculado ao historico', () async {
      final result = await historicoDAO.uploadFile(
        requestParams: RequestParams(
          body: {
            'formdata': jsonEncode({
              'dados': {
                'idHistorico': 1,
              },
              'arquivos': {
                'image.jpg':
                    '[12,31,23,12,3,1,23,12,31,23,23,12,31,23,1,2,3,1,2,31]',
              },
            }),
          },
        ),
      );
      expect(result, equals(true));
    });
    test('Espero baixar um arquivo vinculado ao historico', () async {
      final result = await historicoDAO.downloadFile(
        requestParams: RequestParams(
          body: {
            'idHistorico': 1,
            'idArquivo': 1,
          },
        ),
      );
      expect(result, isA<Uint8List>());
    });

    test('Espero deletar um historico', () async {
      final result = await historicoDAO.delete(
        requestParams: RequestParams(
          body: {
            'idAplicacao': '2',
            'idHistorico': '1',
          },
        ),
      );
      expect(result, equals(true));
    });
  });
}
