import 'package:back_end/app/api/api.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class HistoricControllerMock extends Mock implements HistoricController {}

class GetFileHistoricHandlerMock extends Mock
    implements GetFileHistoricHandler {}

class GetHistoricHandlerMock extends Mock implements GetHistoricHandler {}

class CreateHistoricHandlerMock extends Mock implements CreateHistoricHandler {}

class UpdateHistoricHandlerMock extends Mock implements UpdateHistoricHandler {}

class DeleteHistoricHandlerMock extends Mock implements DeleteHistoricHandler {}

class DeleteFileHistoricHandlerMock extends Mock
    implements DeleteFileHistoricHandler {}

class CreateFileHistoricHandlerMock extends Mock
    implements CreateFileHistoricHandler {}

void main() {
  late final HistoricController controller;

  setUpAll(() {
    controller = HistoricControllerMock();
    when(() => controller.handler).thenReturn({
      'GET': GetHistoricHandlerMock(),
      'GET /downloadFile': GetFileHistoricHandlerMock(),
      'POST': CreateHistoricHandlerMock(),
      'POST /uploadFile': CreateFileHistoricHandlerMock(),
      'PUT': UpdateHistoricHandlerMock(),
      'DELETE': DeleteHistoricHandlerMock(),
      'DELETE /deleteFile': DeleteFileHistoricHandlerMock(),
    });
    when(
      () => controller.route,
    ).thenReturn('/historico');
  });

  group('Teste do HistoricoController => ', () {
    test('HistoricoController deve conter a rota /historico', () {
      expect(controller.route, '/historico');
    });
    test(
        'HistoricoController deve conter uma key POST para postHistoricosHandler',
        () {
      expect(controller.handler['POST'], isA<CreateHistoricHandler>());
    });
    test('HistoricoController deve conter uma key GET para getHistoricoHandler',
        () {
      expect(
        controller.handler['GET'],
        isA<GetHistoricHandler>(),
      );
    });
    test(
        'HistoricoController deve conter uma key GET para GetDownloadFileHistoricoHandler',
        () {
      expect(
        controller.handler['GET /downloadFile'],
        isA<GetFileHistoricHandlerMock>(),
      );
    });
    test(
        'HistoricoController deve conter uma key POST para PostHistoricosHandler',
        () {
      expect(
        controller.handler['POST'],
        isA<CreateHistoricHandler>(),
      );
    });
    test(
        'HistoricoController deve conter uma key POST para UploadFileHistoricosHandler',
        () {
      expect(
        controller.handler['POST /uploadFile'],
        isA<CreateFileHistoricHandler>(),
      );
    });
    test('HistoricoController deve conter uma key PUT para PutHistoricoHandler',
        () {
      expect(
        controller.handler['PUT'],
        isA<UpdateHistoricHandler>(),
      );
    });
    test(
        'HistoricoController deve conter uma key DELETE para DeleteHistoricoHandler',
        () {
      expect(
        controller.handler['DELETE'],
        isA<DeleteHistoricHandler>(),
      );
    });
    test(
        'HistoricoController deve conter uma key DELETE para DeleteFileHistoricoHandler',
        () {
      expect(
        controller.handler['DELETE /deleteFile'],
        isA<DeleteFileHistoricHandler>(),
      );
    });
  });
}
