import 'package:back_end/app/api/api.dart';
import 'package:back_end/app/data/data.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class TesteServiceMock extends Mock implements TesteService {}

void main() {
  final controller = TesteController(
    testeUseCase: TesteServiceMock(),
  );
  group('Teste controller => ', () {
    test('Espero que a rota inicial seja /teste ...', () {
      expect(controller.route, '/teste');
    });
    test('Espero que a handler POST seja PostTesteHandler  ...', () {
      expect(controller.handler['POST'], isA<PostTesteHandler>());
    });
    test('Espero que a handler POST seja PostEnviarArquivoTesteHandler  ...',
        () {
      expect(
        controller.handler['POST /arquivos'],
        isA<PostEnviarArquivoTesteHandler>(),
      );
    });
    test('Espero que a handler PUT seja PutTesteHandler  ...', () {
      expect(controller.handler['PUT'], isA<PutTesteHandler>());
    });
    test('Espero que a handler GET seja GetTesteHandler  ...', () {
      expect(controller.handler['GET'], isA<GetTesteHandler>());
    });
    test('Espero que a handler DELETE seja DeleteTesteHandler  ...', () {
      expect(controller.handler['DELETE'], isA<DeleteTesteHandler>());
    });
    test(
        'Espero que a handler DELETE /arquivos seja DeleteArquivoTesteHandler  ...',
        () {
      expect(
        controller.handler['DELETE /arquivos'],
        isA<DeleteArquivoTesteHandler>(),
      );
    });
  });
}
