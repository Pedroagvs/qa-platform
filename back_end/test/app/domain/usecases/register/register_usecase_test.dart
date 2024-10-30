import 'package:back_end/app/api/api.dart';
import 'package:back_end/app/data/data.dart';
import 'package:back_end/app/domain/exceptions/register/register_exceptions.dart';
import 'package:back_end/app/domain/usecases/register/register_usecase.dart';
import 'package:back_end/app/infra/infra.dart';
import 'package:test/test.dart';

void main() {
  late final RegisterUseCase registerUseCase;
  late final MySQl mySQl;
  setUpAll(() async {
    mySQl = MySQl();
    await mySQl.initConnection();
    registerUseCase = RegisterService(
      registerGateway: RegisterDAO(connection: mySQl),
      userGateway: UserDAO(connection: mySQl),
    );
  });
  group('Teste do RegisterUseCase => ', () {
    test('Espero criar um novo usuário', () async {
      final result = await registerUseCase.call(
        requestParams: RequestParams(
          body: {
            'senha': 'senha1234',
            'name': 'Teste',
            'email': 'tester@gmail.com',
          },
        ),
      );
      expect(result, equals(true));
    });
    test('Espero receber uma exceção ao tentar criar um e-mail ja existente.',
        () async {
      expect(
        await registerUseCase.call(
          requestParams: RequestParams(
            body: {
              'senha': 'senha1234',
              'name': 'Teste',
              'email': 'tester@gmail.com',
            },
          ),
        ),
        throwsA(isA<EmailAlreadyRegistered>()),
      );
    });
  });
}
