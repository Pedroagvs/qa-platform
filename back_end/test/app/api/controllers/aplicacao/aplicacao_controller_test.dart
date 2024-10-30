import 'package:back_end/app/api/api.dart';
import 'package:back_end/app/data/data.dart';
import 'package:back_end/app/infra/infra.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class AplicacaoServiceMock extends Mock implements AplicacaoService {}

void main() {
  final controller = AplicacaoController(
    aplicacaoUseCase: AplicacaoServiceMock(),
  );

  group('Test do AplicacaoController => ', () {
    test('AplicacaoController deve conter a rota /aplicacao', () {
      expect(controller.route, equals('/aplicacao'));
    });
    test('AplicacaoController deve conter um metodo PostAplicacaoHandler', () {
      expect(
        controller.handler['POST'],
        isA<PostAplicacaoHandler>(),
      );
    });
    test('AplicacaoController deve conter um metodo GetAplicacoesHandler', () {
      expect(
        controller.handler['GET'],
        isA<GetAplicacoesHandler>(),
      );
    });
    test('AplicacaoController deve conter um metodo DeleteAplicacoesHandler',
        () {
      expect(
        controller.handler['DELETE'],
        isA<DeleteAplicacoesHandler>(),
      );
    });
    test('AplicacaoController deve conter um metodo PutAplicacaoHandler', () {
      expect(
        controller.handler['PUT'],
        isA<PutAplicacaoHandler>(),
      );
    });
  });
}
