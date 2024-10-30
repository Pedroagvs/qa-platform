import 'package:back_end/app/api/api.dart';
import 'package:back_end/app/data/data.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class RegisterUserMock extends Mock implements RegisterService {}

void main() {
  late final RegisterHandler handler;
  setUpAll(
    () {
      handler = RegisterHandler(registerUseCase: RegisterUserMock());
    },
  );
  group('Register hanlder ->', () {
    test('register handler ...', () {
      handler.call(requestParams: RequestParams(body: {}));
    });
  });
}
