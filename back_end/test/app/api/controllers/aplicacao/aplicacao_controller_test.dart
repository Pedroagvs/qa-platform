import 'package:back_end/app/api/api.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class AplicationHandlerMock extends Mock implements AplicationHandler {}

class AplicationControllerMock extends Mock implements AplicationController {}

class CreateAplicationHandlerMock extends Mock
    implements CreateAplicationHandler {}

class GetApplicationsHandlerMock extends Mock
    implements GetApplicationsHandler {}

class UpdateAplicationHandlerMock extends Mock
    implements UpdateAplicationHandler {}

class DeleteAplicationHandlerMock extends Mock
    implements DeleteAplicationHandler {}

void main() {
  late final AplicationController controller;
  setUpAll(() {
    controller = AplicationControllerMock();
    when(
      () => controller.handler,
    ).thenReturn({
      'POST': CreateAplicationHandlerMock(),
      'GET': GetApplicationsHandlerMock(),
      'PUT': UpdateAplicationHandlerMock(),
      'DELETE': DeleteAplicationHandlerMock(),
    });
    when(
      () => controller.route,
    ).thenReturn('/aplicacao');
  });

  group('Test do AplicacaoController => ', () {
    test('AplicacaoController deve conter a rota /aplicacao', () {
      expect(controller.route, equals('/aplicacao'));
    });
    test('AplicacaoController deve conter o map de strings e handlers', () {
      expect(controller.handler, isA<Map<String, Handler>>());
    });
    test('AplicacaoController deve conter um metodo PostAplicacaoHandler', () {
      expect(
        controller.handler['POST'],
        isA<CreateAplicationHandler>(),
      );
    });
    test('AplicacaoController deve conter um metodo GetAplicacoesHandler', () {
      expect(
        controller.handler['GET'],
        isA<GetApplicationsHandler>(),
      );
    });
    test('AplicacaoController deve conter um metodo DeleteAplicacoesHandler',
        () {
      expect(
        controller.handler['DELETE'],
        isA<DeleteAplicationHandler>(),
      );
    });
    test('AplicacaoController deve conter um metodo PutAplicacaoHandler', () {
      expect(
        controller.handler['PUT'],
        isA<UpdateAplicationHandler>(),
      );
    });
  });
}
