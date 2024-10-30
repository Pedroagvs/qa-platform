import 'package:back_end/app/api/api.dart';
import 'package:back_end/app/data/data.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class AuthServiceMock extends Mock implements AuthService {}

void main() {
  final controller = AuthController(
    authUseCase: AuthServiceMock(),
  );

  group('Autenticacao ->', () {
    test('AuthController deve conter /auth', () {
      expect(controller.route, '/auth');
    });
    test('AuthController deve conter uma key POST para loginHandler', () {
      expect(controller.handler['POST'], isA<AuthHandler>());
    });
    test('AuthController deve conter uma key PUT para loginHandler', () {
      expect(
        controller.handler['PUT /changePassword'],
        isA<ChangePasswordHandler>(),
      );
    });
  });
}
