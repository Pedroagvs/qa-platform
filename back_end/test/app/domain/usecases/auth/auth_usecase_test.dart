import 'package:back_end/app/api/api.dart';
import 'package:back_end/app/api/dto/user_dto.dart';
import 'package:back_end/app/data/data.dart';
import 'package:back_end/app/domain/domain.dart';
import 'package:back_end/app/domain/exceptions/auth/auth_exceptions.dart';
import 'package:back_end/app/infra/infra.dart';
import 'package:test/test.dart';

void main() {
  late final AuthUseCase authUseCase;
  late final MySQl mySQl;
  setUpAll(() async {
    mySQl = MySQl();
    await mySQl.initConnection();
    authUseCase = AuthService(
      authGateway: AuthDAO(connection: mySQl),
      userGateway: UserDAO(connection: mySQl),
    );
  });
  group('Teste do AuthUseCase => ', () {
    test('Espero obter as informações do usuário', () async {
      final result = await authUseCase.login(
        requestParams: RequestParams(
          body: {
            'email': 'tester@gmail.com',
            'senha': 'senha1234',
          },
        ),
      );
      expect(result, isA<UserDto>());
    });
    test('Espero receber um exceção para usuário não cadastrado', () async {
      expect(
        await authUseCase.login(
          requestParams: RequestParams(
            body: {
              'email': 'teste@gmail.com',
              'senha': 'senha123',
            },
          ),
        ),
        throwsA(isA<NotExistsThisUser>()),
      );
    });
  });
}
