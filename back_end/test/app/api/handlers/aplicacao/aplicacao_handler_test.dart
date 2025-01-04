import 'package:back_end/app/api/api.dart';
import 'package:back_end/app/api/dto/aplicacao_dto.dart';
import 'package:back_end/app/data/data.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class AplicacaoServiceMock extends Mock implements AplicacaoService {}

class AplicacaoGatewayMock extends Mock implements AplicacaoGateway {}

void main() {
  final mockAplicacaoService = AplicacaoServiceMock();
  final mockAplicacaoGateway = AplicacaoGatewayMock();
  final aplicacaoHandler = AplicacaoHandler(
    create: PostAplicacaoHandler(aplicacaoUseCase: mockAplicacaoService),
    delete: DeleteAplicacoesHandler(aplicacaoUseCase: mockAplicacaoService),
    read: GetAplicacoesHandler(aplicacaoUseCase: mockAplicacaoService),
    update: PutAplicacaoHandler(aplicacaoUseCase: mockAplicacaoService),
  );
  group('Teste do AplicacaoHandler', () {
    final requestParams = RequestParams(body: {'titulo': '', 'plataforma': ''});
    test('Espero criar uma Aplicação', () async {
      final responseHandler = await aplicacaoHandler.create(
        requestParams: requestParams,
      );
      expect(responseHandler.statusHandler, StatusHandler.badRequest);
    });
    test('Espero obter as aplicações existentes', () async {
      final requestParams = RequestParams(body: null);

      when(() => mockAplicacaoGateway.get())
          .thenAnswer((_) async => <AplicacaoDto>[]);
      when(() => mockAplicacaoService.get())
          .thenAnswer((_) async => <AplicacaoDto>[]);

      final responseHandler = await aplicacaoHandler.read(
        requestParams: requestParams,
      );
      expect(responseHandler.statusHandler, StatusHandler.ok);
      expect(responseHandler.body, isA<List<AplicacaoDto>>());
    });
    test('Espero atualizar uma Aplicação', () async {
      final requestParams = RequestParams(
        body: {
          'idAplicacao': '1',
          'titulo': 'Teste',
          'plataforma': 'teste2',
        },
      );
      when(() => mockAplicacaoGateway.update(requestParams: requestParams))
          .thenAnswer((_) async => true);
      when(() => mockAplicacaoService.update(requestParams: requestParams))
          .thenAnswer((_) async => true);
      final responseHandler = await aplicacaoHandler.update(
        requestParams: requestParams,
      );
      expect(responseHandler.statusHandler, StatusHandler.ok);
      expect(
        responseHandler.body,
        containsPair('mensagem', 'Aplicação editada com sucesso !!'),
      );
    });
    test('Espero status handler badRequest com id vazio', () async {
      final requestParams = RequestParams(body: {'idAplicacao': ''});
      when(() => mockAplicacaoGateway.update(requestParams: requestParams))
          .thenAnswer((_) async => true);
      when(() => mockAplicacaoService.update(requestParams: requestParams))
          .thenAnswer((_) async => true);
      final responseHandler = await aplicacaoHandler.update(
        requestParams: requestParams,
      );
      expect(responseHandler.statusHandler, StatusHandler.badRequest);
      expect(
        responseHandler.body,
        containsPair('mensagem', 'O id da aplicação é obrigatório.'),
      );
    });
    test('Espero status handler badRequest com body vazio', () async {
      final requestParams = RequestParams(body: {});
      when(() => mockAplicacaoGateway.update(requestParams: requestParams))
          .thenAnswer((_) async => true);
      when(() => mockAplicacaoService.update(requestParams: requestParams))
          .thenAnswer((_) async => true);
      final responseHandler = await aplicacaoHandler.update(
        requestParams: requestParams,
      );
      expect(responseHandler.statusHandler, StatusHandler.badRequest);
      expect(
        responseHandler.body,
        containsPair('mensagem', 'O id da aplicação é obrigatório.'),
      );
    });
    test('Espero status handler badRequest ao tentar atulizar a aplicação',
        () async {
      final requestParams = RequestParams(
        body: {
          'idAplicacao': '1',
          'titulo': 'Teste',
          'plataforma': 'teste2',
        },
      );
      when(() => mockAplicacaoGateway.update(requestParams: requestParams))
          .thenAnswer((_) async => false);
      when(() => mockAplicacaoService.update(requestParams: requestParams))
          .thenAnswer((_) async => false);
      final responseHandler = await aplicacaoHandler.update(
        requestParams: requestParams,
      );
      expect(responseHandler.statusHandler, StatusHandler.internalError);
      expect(
        responseHandler.body,
        containsPair('mensagem', 'Falha ao editar a Aplicação.'),
      );
    });
    test('Espero deletar uma Aplicação', () async {
      final requestParams = RequestParams(body: {'idAplicacao': '1'});
      when(() => mockAplicacaoGateway.delete(requestParams: requestParams))
          .thenAnswer((_) async => true);
      when(() => mockAplicacaoService.delete(requestParams: requestParams))
          .thenAnswer((_) async => true);
      final responseHandler = await aplicacaoHandler.delete(
        requestParams: requestParams,
      );
      expect(responseHandler.statusHandler, StatusHandler.ok);
      expect(
        responseHandler.body,
        containsPair('mensagem', 'Aplicação deletada com sucesso !!'),
      );
    });
    test('Espero statushandler internalerror ao tentar deletar uma aplicação',
        () async {
      final requestParams = RequestParams(body: {'idAplicacao': '1'});
      when(() => mockAplicacaoGateway.delete(requestParams: requestParams))
          .thenAnswer((_) async => false);
      when(() => mockAplicacaoService.delete(requestParams: requestParams))
          .thenAnswer((_) async => false);
      final responseHandler = await aplicacaoHandler.delete(
        requestParams: requestParams,
      );
      expect(responseHandler.statusHandler, StatusHandler.internalError);
      expect(
        responseHandler.body,
        containsPair('mensagem', 'Falha ao deletar a aplicação.'),
      );
    });
    test('Espero deletar uma Aplicação', () async {
      final requestParams = RequestParams(body: {'idAplicacao': '1'});
      when(() => mockAplicacaoGateway.delete(requestParams: requestParams))
          .thenAnswer((_) async => true);
      when(() => mockAplicacaoService.delete(requestParams: requestParams))
          .thenAnswer((_) async => true);
      final responseHandler = await aplicacaoHandler.delete(
        requestParams: requestParams,
      );
      expect(responseHandler.statusHandler, StatusHandler.ok);
      expect(
        responseHandler.body,
        containsPair('mensagem', 'Aplicação deletada com sucesso !!'),
      );
    });
  });
}
