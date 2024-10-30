import 'package:back_end/app/api/api.dart';
import 'package:back_end/app/data/data.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class HistoricoServiceMock extends Mock implements HistoricoService {}

void main() {
  final controller = HistoricoController(
    historicoUseCase: HistoricoServiceMock(),
  );

  group('Teste do HistoricoController => ', () {
    test('HistoricoController deve conter a rota /historico', () {
      expect(controller.route, '/historico');
    });
    test(
        'HistoricoController deve conter uma key POST para postHistoricosHandler',
        () {
      expect(controller.handler['POST'], isA<PostHistoricosHandler>());
    });
    test('HistoricoController deve conter uma key GET para getHistoricoHandler',
        () {
      expect(
        controller.handler['GET'],
        isA<GetHistoricoHandler>(),
      );
    });
    test(
        'HistoricoController deve conter uma key GET para GetDownloadFileHistoricoHandler',
        () {
      expect(
        controller.handler['GET /downloadFile'],
        isA<GetDownloadFileHistoricoHandler>(),
      );
    });
    test(
        'HistoricoController deve conter uma key POST para PostHistoricosHandler',
        () {
      expect(
        controller.handler['POST'],
        isA<PostHistoricosHandler>(),
      );
    });
    test(
        'HistoricoController deve conter uma key POST para UploadFileHistoricosHandler',
        () {
      expect(
        controller.handler['POST /uploadFile'],
        isA<UploadFileHistoricosHandler>(),
      );
    });
    test('HistoricoController deve conter uma key PUT para PutHistoricoHandler',
        () {
      expect(
        controller.handler['PUT'],
        isA<PutHistoricoHandler>(),
      );
    });
    test(
        'HistoricoController deve conter uma key DELETE para DeleteHistoricoHandler',
        () {
      expect(
        controller.handler['DELETE'],
        isA<DeleteHistoricoHandler>(),
      );
    });
    test(
        'HistoricoController deve conter uma key DELETE para DeleteFileHistoricoHandler',
        () {
      expect(
        controller.handler['DELETE /deleteFile'],
        isA<DeleteFileHistoricoHandler>(),
      );
    });
  });
}
