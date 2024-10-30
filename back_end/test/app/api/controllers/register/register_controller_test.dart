import 'package:back_end/app/api/api.dart';
import 'package:back_end/app/data/data.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class RegisterServiceMock extends Mock implements RegisterService {}

void main() {
  final controller = RegisterController(
    registerUseCase: RegisterServiceMock(),
  );
  group('Register controller =>', () {
    test('register controller ...', () {
      expect(controller.route, '/register');
    });
    test('register controller ...', () {
      expect(controller.handler['POST'], isA<RegisterHandler>());
    });
  });
}
