import 'package:back_end/app/api/api.dart';
import 'package:back_end/app/data/data.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class AuthServiceMock extends Mock implements AuthService {}

class AuthHandlerMock extends Mock implements AuthHandler {}

class LoginHandlerMock extends Mock implements LoginHandler {}

class ChangePasswordHandlerMock extends Mock implements ChangePasswordHandler {}

class AuthControllerMock extends Mock implements AuthController {}

void main() {
  late final AuthController controller;
  setUpAll(() {
    controller = AuthControllerMock();
    when(
      () => controller.handler,
    ).thenReturn({
      'POST': LoginHandlerMock(),
      'PUT /changePassword': ChangePasswordHandlerMock(),
    });
    when(
      () => controller.route,
    ).thenReturn('/auth');
  });

  group('Autenticacao ->', () {
    test('AuthController deve conter /auth', () {
      expect(controller.route, '/auth');
    });
    test('AuthController deve conter uma key POST para loginHandler', () {
      expect(controller.handler['POST'], isA<LoginHandler>());
    });
    test('AuthController deve conter uma key PUT para loginHandler', () {
      expect(
        controller.handler['PUT /changePassword'],
        isA<ChangePasswordHandler>(),
      );
    });
  });
}
