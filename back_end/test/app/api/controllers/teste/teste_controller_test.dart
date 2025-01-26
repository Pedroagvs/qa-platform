import 'package:back_end/app/api/api.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class TesteControllerMock extends Mock implements TesteController {}

class CreateTestHandlerMock extends Mock implements CreateTestHandler {}

class GetTesteHandlerMock extends Mock implements GetTestHandler {}

class UpdateTestHandlerMock extends Mock implements UpdateTestHandler {}

class UploadFilesTestHandlerMock extends Mock
    implements UploadFileTestHandler {}

class GetFilesTestHandlerMock extends Mock implements GetFilesTestHandler {}

class DeleteFileTestHandlerMock extends Mock implements DeleteFileTestHandler {}

class DeleteTesteHandlerMock extends Mock implements DeleteTestHandler {}

void main() {
  late final TesteController controller;
  setUpAll(() {
    controller = TesteControllerMock();
    when(
      () => controller.handler,
    ).thenReturn({
      'POST': CreateTestHandlerMock(),
      'POST /arquivos': UploadFilesTestHandlerMock(),
      'PUT': UpdateTestHandlerMock(),
      'GET': GetTesteHandlerMock(),
      'GET /arquivos': GetFilesTestHandlerMock(),
      'DELETE': DeleteTesteHandlerMock(),
      'DELETE /arquivos': DeleteFileTestHandlerMock(),
    });
    when(
      () => controller.route,
    ).thenReturn('/teste');
  });

  group('Teste controller => ', () {
    test('Espero que a rota inicial seja /teste ...', () {
      expect(controller.route, '/teste');
    });
    test('Espero que a handler POST seja PostTesteHandler  ...', () {
      expect(controller.handler['POST'], isA<CreateTestHandler>());
    });
    test('Espero que a handler POST seja PostEnviarArquivoTesteHandler  ...',
        () {
      expect(
        controller.handler['POST /arquivos'],
        isA<UploadFileTestHandler>(),
      );
    });
    test('Espero que a handler PUT seja PutTesteHandler  ...', () {
      expect(controller.handler['PUT'], isA<UpdateTestHandler>());
    });
    test('Espero que a handler GET seja GetTesteHandler  ...', () {
      expect(controller.handler['GET'], isA<GetTestHandler>());
    });
    test('Espero que a handler DELETE seja DeleteTesteHandler  ...', () {
      expect(controller.handler['DELETE'], isA<DeleteTestHandler>());
    });
    test(
        'Espero que a handler DELETE /arquivos seja DeleteArquivoTesteHandler  ...',
        () {
      expect(
        controller.handler['DELETE /arquivos'],
        isA<DeleteFileTestHandler>(),
      );
    });
  });
  tearDownAll(
    () => reset(controller),
  );
}
