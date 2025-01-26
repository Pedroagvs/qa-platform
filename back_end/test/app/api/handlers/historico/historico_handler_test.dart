import 'dart:typed_data';

import 'package:back_end/app/api/api.dart';
import 'package:back_end/app/api/dto/historic_dto.dart';
import 'package:back_end/app/data/data.dart';
import 'package:back_end/app/domain/domain.dart';
import 'package:back_end/app/infra/infra.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class HistoricHandlerMock extends Mock implements HistoricHandler {}

class HistoricoServiceMock extends Mock implements HistoricService {}

class GetHistoricHandlerMock extends Mock implements GetHistoricHandler {}

class CreateHistoricHandlerMock extends Mock implements CreateHistoricHandler {}

class UpdateHistoricHandlerMock extends Mock implements UpdateHistoricHandler {}

class DeleteHistoricHandlerMock extends Mock implements DeleteHistoricHandler {}

class DeleteFileHistoricHandlerMock extends Mock
    implements DeleteFileHistoricHandler {}

class CreateFileHistoricHandlerMock extends Mock
    implements CreateFileHistoricHandler {}

class GetFileHistoricHandlerMock extends Mock
    implements GetFileHistoricHandler {}

class HistoricDAOMock extends Mock implements HistoricDAO {}

void main() {
  late final HistoricHandler historicHandler;
  late final HistoricUseCase historicUseCase;
  late final HistoricDAO historicDAO;
  setUpAll(() {
    historicUseCase = HistoricoServiceMock();
    historicDAO = HistoricDAOMock();
    historicHandler = HistoricHandler(
      create: CreateHistoricHandler(historicUseCase: historicUseCase),
      read: GetHistoricHandler(historicUseCase: historicUseCase),
      update: UpdateHistoricHandler(historicUseCase: historicUseCase),
      delete: DeleteHistoricHandler(historicUseCase: historicUseCase),
      getFile: GetFileHistoricHandler(historicUseCase: historicUseCase),
      createFile: CreateFileHistoricHandler(historicUseCase: historicUseCase),
      deleteFile: DeleteFileHistoricHandler(historicUseCase: historicUseCase),
    );
  });

  group('Historico Handler => ', () {
    test('Espero obter os historicos de teste uma aplicacao', () async {
      final request = RequestParams(body: {'idAplicacao': 1, 'offset': 0});
      when(
        () => historicDAO.get(requestParams: request),
      ).thenAnswer((_) async => <HistoricDto>[]);
      when(
        () => historicHandler.read(requestParams: request),
      ).thenAnswer(
        (_) async => ResponseHandler(
          statusHandler: StatusHandler.ok,
          body: <HistoricDto>[],
        ),
      );
      when(
        () => historicUseCase.get(requestParams: request),
      ).thenAnswer(
        (_) async => <HistoricDto>[],
      );
      final result = await historicHandler.read(requestParams: request);
      expect(result.statusHandler, equals(StatusHandler.ok));
    });

    test('Espero obter bad request para request com campos nullos ou vazios',
        () async {
      final request = RequestParams(body: {});
      final result = await historicHandler.create(
        requestParams: request,
      );
      expect(result.statusHandler, equals(StatusHandler.badRequest));
      expect(
        result.body,
        containsPair('mensagem', 'Os campos são obrigatórios.'),
      );
    });
    test('Espero obter bad request para request com campos null ou vazios',
        () async {
      final request = RequestParams(body: null);
      final result = await historicHandler.create(
        requestParams: request,
      );
      expect(result.statusHandler, equals(StatusHandler.badRequest));
      expect(
        result.body,
        containsPair('mensagem', 'Os campos são obrigatórios.'),
      );
    });
    test('Espero obter bad request para request com campos null ou vazios',
        () async {
      final request = RequestParams(body: {'idAplicacao': null, 'offset': 0});
      final result = await historicHandler.create(
        requestParams: request,
      );
      expect(result.statusHandler, equals(StatusHandler.badRequest));
      expect(
        result.body,
        containsPair('mensagem', 'Os campos são obrigatórios.'),
      );
    });
    test('Espero obter bad request para request com campos null ou vazios',
        () async {
      final request = RequestParams(body: {'idAplicacao': 1, 'offset': null});
      final result = await historicHandler.create(
        requestParams: request,
      );
      expect(result.statusHandler, equals(StatusHandler.badRequest));
      expect(
        result.body,
        containsPair('mensagem', 'Os campos são obrigatórios.'),
      );
    });
    test('Espero obter bad request para request com campos null ou vazios',
        () async {
      final request =
          RequestParams(body: {'idAplicacao': null, 'offset': null});
      final result = await historicHandler.create(
        requestParams: request,
      );
      expect(result.statusHandler, equals(StatusHandler.badRequest));
      expect(
        result.body,
        containsPair('mensagem', 'Os campos são obrigatórios.'),
      );
    });
    test(
        'Espero receber bad request ao tentar criar historico com paramentros vazios ou nulos',
        () async {
      final request = RequestParams(
        body: {
          'idAplicacao': 1,
          'fonte': '',
          'descricao': '',
          'formdata': null,
        },
      );
      final result = await historicHandler.create(requestParams: request);
      expect(result.statusHandler, equals(StatusHandler.badRequest));
      expect(
        result.body,
        containsPair('mensagem', 'Os campos são obrigatórios.'),
      );
    });
    test(
        'Espero receber bad request ao tentar criar historico com paramentros vazios ou nulos',
        () async {
      final request = RequestParams(
        body: {
          'idAplicacao': 1,
          'fonte': '123',
          'descricao': '',
          'formdata': null,
        },
      );
      final result = await historicHandler.create(requestParams: request);
      expect(result.statusHandler, equals(StatusHandler.badRequest));
      expect(
        result.body,
        containsPair('mensagem', 'Os campos são obrigatórios.'),
      );
    });
    test(
        'Espero receber bad request ao tentar criar historico com paramentros vazios ou nulos',
        () async {
      final request = RequestParams(
        body: {
          'idAplicacao': null,
          'fonte': '123',
          'descricao': 'asd',
          'formdata': null,
        },
      );
      final result = await historicHandler.create(requestParams: request);
      expect(result.statusHandler, equals(StatusHandler.badRequest));
      expect(
        result.body,
        containsPair('mensagem', 'Os campos são obrigatórios.'),
      );
    });
    test('Espero receber statushandler ok ao tentar criar um historico',
        () async {
      final request = RequestParams(
        body: {
          'idAplicacao': 1,
          'fonte': '123',
          'descricao': 'asd',
          'formdata': null,
        },
      );
      when(
        () => historicUseCase.create(requestParams: request),
      ).thenAnswer((_) async => true);
      when(
        () => historicDAO.create(requestParams: request),
      ).thenAnswer((_) async => true);

      final result = await historicHandler.create(requestParams: request);
      expect(result.statusHandler, equals(StatusHandler.ok));
    });

    test('Espero obter os historicos de teste uma aplicacao', () async {
      final request = RequestParams(body: {'idAplicacao': 1, 'offset': 0});
      when(
        () => historicHandler.delete(
          requestParams: request,
        ),
      ).thenAnswer(
        (_) async => ResponseHandler(statusHandler: StatusHandler.ok, body: {}),
      );
      when(
        () => historicUseCase.delete(requestParams: request),
      ).thenAnswer((_) async => true);
      final result = await historicHandler.delete(
        requestParams: request,
      );
      expect(result.statusHandler, equals(StatusHandler.ok));
      expect(
        result.body,
        containsPair('mensagem', 'Historico deletado com sucesso !!'),
      );
    });

    test('Espero obter os historicos de teste uma aplicacao', () async {
      final request = RequestParams(
        body: {
          'formaData': {'dados': {}, 'arquivos': {}},
        },
      );
      when(() => historicDAO.uploadFile(requestParams: request))
          .thenAnswer((_) async => true);
      when(() => historicUseCase.uploadFile(requestParams: request))
          .thenAnswer((_) async => true);

      final result = await historicHandler.createFile(requestParams: request);
      expect(result.statusHandler, equals(StatusHandler.ok));
    });
    test('Espero obter os historicos de teste uma aplicacao', () async {
      final request = RequestParams(body: {'idHistorico': 1, 'idArquivo': 1});
      when(() => historicDAO.downloadFile(requestParams: request))
          .thenAnswer((_) async => Uint8List.fromList([]));
      when(() => historicUseCase.downloadFile(requestParams: request))
          .thenAnswer((_) async => Uint8List.fromList([]));
      final result = await historicHandler.getFile(
        requestParams: request,
      );
      expect(result.statusHandler, equals(StatusHandler.ok));
    });
  });
}
