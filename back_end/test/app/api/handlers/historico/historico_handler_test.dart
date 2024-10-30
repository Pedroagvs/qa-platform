import 'package:back_end/app/api/api.dart';
import 'package:back_end/app/data/data.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class HistoricoServiceMock extends Mock implements HistoricoService {}

void main() {
  final getHistoricoHandler =
      GetHistoricoHandler(historicoUseCase: HistoricoServiceMock());
  final postHistoricosHandler =
      PostHistoricosHandler(historioUseCase: HistoricoServiceMock());
  final putHistoricoHandler =
      PutHistoricoHandler(historicoUseCase: HistoricoServiceMock());
  final deleteHistoricoHandler =
      DeleteHistoricoHandler(historicoUseCase: HistoricoServiceMock());
  final deleteFileHistoricoHandler =
      DeleteFileHistoricoHandler(historicoUseCase: HistoricoServiceMock());
  final uploadFileHistoricosHandler =
      UploadFileHistoricosHandler(historicoUseCase: HistoricoServiceMock());
  final getDonwloadFileHistoricosHandler =
      GetDownloadFileHistoricoHandler(historicoUseCase: HistoricoServiceMock());
  group('Historico Handler => ', () {
    test('Espero obter os historicos de teste uma aplicacao', () async {
      when(
        () => getHistoricoHandler.call(
          requestParams: RequestParams(body: {'idAplicacao': 1, 'offset': 0}),
        ),
      ).thenAnswer(
        (_) async => ResponseHandler(statusHandler: StatusHandler.ok, body: {}),
      );
      final result = await getHistoricoHandler.call(
        requestParams: RequestParams(body: {'idAplicacao': 1, 'offset': 0}),
      );
      expect(result.statusHandler, equals(StatusHandler.ok));
    });
    test('Espero obter os historicos de teste uma aplicacao', () async {
      when(
        () => postHistoricosHandler.call(
          requestParams: RequestParams(body: {'idAplicacao': 1, 'offset': 0}),
        ),
      ).thenAnswer(
        (_) async => ResponseHandler(statusHandler: StatusHandler.ok, body: {}),
      );
      final result = await postHistoricosHandler.call(
        requestParams: RequestParams(body: {'idAplicacao': 1, 'offset': 0}),
      );
      expect(result.statusHandler, equals(StatusHandler.ok));
    });
    test('Espero obter os historicos de teste uma aplicacao', () async {
      when(
        () => putHistoricoHandler.call(
          requestParams: RequestParams(body: {'idAplicacao': 1, 'offset': 0}),
        ),
      ).thenAnswer(
        (_) async => ResponseHandler(statusHandler: StatusHandler.ok, body: {}),
      );
      final result = await putHistoricoHandler.call(
        requestParams: RequestParams(body: {'idAplicacao': 1, 'offset': 0}),
      );
      expect(result.statusHandler, equals(StatusHandler.ok));
    });
    test('Espero obter os historicos de teste uma aplicacao', () async {
      when(
        () => deleteHistoricoHandler.call(
          requestParams: RequestParams(body: {'idAplicacao': 1, 'offset': 0}),
        ),
      ).thenAnswer(
        (_) async => ResponseHandler(statusHandler: StatusHandler.ok, body: {}),
      );
      final result = await deleteHistoricoHandler.call(
        requestParams: RequestParams(body: {'idAplicacao': 1, 'offset': 0}),
      );
      expect(result.statusHandler, equals(StatusHandler.ok));
    });
    test('Espero obter os historicos de teste uma aplicacao', () async {
      when(
        () => deleteFileHistoricoHandler.call(
          requestParams: RequestParams(body: {'idAplicacao': 1, 'offset': 0}),
        ),
      ).thenAnswer(
        (_) async => ResponseHandler(statusHandler: StatusHandler.ok, body: {}),
      );
      final result = await deleteFileHistoricoHandler.call(
        requestParams: RequestParams(body: {'idAplicacao': 1, 'offset': 0}),
      );
      expect(result.statusHandler, equals(StatusHandler.ok));
    });
    test('Espero obter os historicos de teste uma aplicacao', () async {
      when(
        () => uploadFileHistoricosHandler.call(
          requestParams: RequestParams(body: {'idAplicacao': 1, 'offset': 0}),
        ),
      ).thenAnswer(
        (_) async => ResponseHandler(statusHandler: StatusHandler.ok, body: {}),
      );
      final result = await uploadFileHistoricosHandler.call(
        requestParams: RequestParams(body: {'idAplicacao': 1, 'offset': 0}),
      );
      expect(result.statusHandler, equals(StatusHandler.ok));
    });
    test('Espero obter os historicos de teste uma aplicacao', () async {
      when(
        () => getDonwloadFileHistoricosHandler.call(
          requestParams: RequestParams(body: {'idAplicacao': 1, 'offset': 0}),
        ),
      ).thenAnswer(
        (_) async => ResponseHandler(statusHandler: StatusHandler.ok, body: {}),
      );
      final result = await getDonwloadFileHistoricosHandler.call(
        requestParams: RequestParams(body: {'idAplicacao': 1, 'offset': 0}),
      );
      expect(result.statusHandler, equals(StatusHandler.ok));
    });
  });
}
