import 'package:back_end/app/api/api.dart';
import 'package:back_end/app/api/dto/user_dto.dart';
import 'package:back_end/app/data/data.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class AuthServiceMock extends Mock implements AuthService {}

class AuthGatewayMock extends Mock implements AuthGateway {}

class UserGatewayMock extends Mock implements UserGateway {}

void main() {
  final mockUserGateWay = UserGatewayMock();
  final mockAuthGateWay = AuthGatewayMock();
  final mockAuthService = AuthServiceMock();
  final authHandler = AuthHandler(
    changePassword: ChangePasswordHandler(authUseCase: mockAuthService),
    login: LoginHandler(authUseCase: mockAuthService),
    createAccount: CreateAccountHandler(authUseCase: mockAuthService),
  );
  group('Auth handler -> ', () {
    test('Deve conter um response handler', () async {
      final responseHandler =
          await authHandler.login(requestParams: RequestParams(body: {}));
      expect(responseHandler, isA<ResponseHandler>());
    });
    test('Deve retornar um Status handler badrequest ', () async {
      final responseHandler =
          await authHandler.login(requestParams: RequestParams(body: {}));
      expect(responseHandler.statusHandler, StatusHandler.badRequest);
    });
    test('Deve retornar um Status handler badrequest ', () async {
      final responseHandler = await authHandler.login(
        requestParams: RequestParams(
          body: {
            'email': '',
            'senha': '',
          },
        ),
      );
      expect(responseHandler.statusHandler, StatusHandler.badRequest);
    });
    test('Deve retornar um UserDto', () async {
      final requestParams = RequestParams(
        body: {
          'email': 'teste@gmail.com',
          'senha': 'senha@123',
        },
      );
      when(
        () => mockAuthGateWay.login(requestParams: requestParams),
      ).thenAnswer((_) async => UserDto(name: 'teste'));
      when(
        () => mockAuthService.login(
          requestParams: requestParams,
        ),
      ).thenAnswer(
        (_) async => UserDto(name: 'teste'),
      );
      final responseHandler = await authHandler.login(
        requestParams: requestParams,
      );
      expect(responseHandler.body, isA<UserDto>());
    });

    test('Deve retornar um status handler bad request', () async {
      final requestParams = RequestParams(
        body: {},
      );
      final responseHandler = await authHandler.changePassword(
        requestParams: requestParams,
      );
      expect(responseHandler.statusHandler, StatusHandler.badRequest);
    });

    test('Deve retornar um status handler bad request', () async {
      final requestParams = RequestParams(
        body: {
          'idUser': '',
          'senha': '',
          'novaSenha': '',
        },
      );
      final responseHandler = await authHandler.changePassword(
        requestParams: requestParams,
      );
      expect(responseHandler.statusHandler, StatusHandler.badRequest);
    });

    test('Deve retornar um status handler bad request', () async {
      final requestParams = RequestParams(
        body: {
          'idUser': '1',
          'senha': '',
          'novaSenha': '',
        },
      );
      final responseHandler = await authHandler.changePassword(
        requestParams: requestParams,
      );
      expect(responseHandler.statusHandler, StatusHandler.badRequest);
    });

    test('Deve retornar um status handler bad request', () async {
      final requestParams = RequestParams(
        body: {
          'idUser': '',
          'senha': '123456',
          'novaSenha': '',
        },
      );
      final responseHandler = await authHandler.changePassword(
        requestParams: requestParams,
      );
      expect(responseHandler.statusHandler, StatusHandler.badRequest);
    });

    test('Deve retornar um status handler bad request', () async {
      final requestParams = RequestParams(
        body: {
          'idUser': '',
          'senha': '',
          'novaSenha': '123456',
        },
      );
      final responseHandler = await authHandler.changePassword(
        requestParams: requestParams,
      );
      expect(responseHandler.statusHandler, StatusHandler.badRequest);
    });

    test('Deve retornar um boolean', () async {
      final requestParams = RequestParams(
        body: {
          'idUser': 'teste@gmail.com',
          'senha': 'senha@123',
          'novaSenha': 'senha123@',
        },
      );
      when(
        () => mockAuthGateWay.changePassword(requestParams: requestParams),
      ).thenAnswer((_) async => true);
      when(
        () => mockAuthService.changePassword(
          requestParams: requestParams,
        ),
      ).thenAnswer(
        (_) async => true,
      );
      final responseHandler = await authHandler.changePassword(
        requestParams: requestParams,
      );
      expect(responseHandler.statusHandler, StatusHandler.ok);
    });
    test(
        'Espero obter um StatusHandler.internalError ao tentar alterar a senha',
        () async {
      final requestParams = RequestParams(
        body: {
          'idUser': 'teste@gmail.com',
          'senha': 'senha@123',
          'novaSenha': 'senha123@',
        },
      );
      when(
        () => mockAuthGateWay.changePassword(requestParams: requestParams),
      ).thenAnswer((_) async => false);
      when(
        () => mockAuthService.changePassword(
          requestParams: requestParams,
        ),
      ).thenAnswer(
        (_) async => false,
      );
      final responseHandler = await authHandler.changePassword(
        requestParams: requestParams,
      );
      expect(responseHandler.statusHandler, StatusHandler.internalError);
    });
    test('Espero criar uma nova conta', () async {
      final requestParams = RequestParams(
        body: {
          'email': 'teste@gmail.com',
          'senha': '123456',
          'nome': 'teste',
          'cargo': 'tester',
        },
      );
      when(
        () => mockUserGateWay.getUserByEmail(requestParams: requestParams),
      ).thenAnswer((_) async => false);
      when(
        () => mockAuthGateWay.createAccount(requestParams: requestParams),
      ).thenAnswer((_) async => true);
      when(
        () => mockAuthService.createAccount(
          requestParams: requestParams,
        ),
      ).thenAnswer(
        (_) async => true,
      );
      final responseHandler = await authHandler.createAccount(
        requestParams: requestParams,
      );
      expect(responseHandler.statusHandler, StatusHandler.ok);
      expect(
        responseHandler.body,
        containsPair('mensagem', 'Usuário criado com sucesso !!'),
      );
    });
    test('Espero receber StatusHandler.badRequest para um e-mail ja cadastrado',
        () async {
      final requestParams = RequestParams(
        body: {
          'email': 'teste@gmail.com',
          'senha': '123456',
          'nome': 'teste',
          'cargo': 'tester',
        },
      );
      when(
        () => mockUserGateWay.getUserByEmail(requestParams: requestParams),
      ).thenAnswer((_) async => true);
      when(
        () => mockAuthGateWay.createAccount(requestParams: requestParams),
      ).thenAnswer((_) async => true);
      when(
        () => mockAuthService.createAccount(
          requestParams: requestParams,
        ),
      ).thenAnswer(
        (_) async => true,
      );
      final responseHandler = await authHandler.createAccount(
        requestParams: requestParams,
      );
      expect(responseHandler.statusHandler, StatusHandler.badRequest);
      expect(
        responseHandler.body,
        containsPair('mensagem', 'E-mail já cadastrado !!.'),
      );
    });
    test('Espero receber StatusHandler.badRequest para um e-mail ja cadastrado',
        () async {
      final requestParams = RequestParams(
        body: {
          'email': '',
          'senha': '',
          'nome': '',
          'cargo': '',
        },
      );
      when(
        () => mockUserGateWay.getUserByEmail(requestParams: requestParams),
      ).thenAnswer((_) async => false);
      when(
        () => mockAuthGateWay.createAccount(requestParams: requestParams),
      ).thenAnswer((_) async => true);
      when(
        () => mockAuthService.createAccount(
          requestParams: requestParams,
        ),
      ).thenAnswer(
        (_) async => true,
      );
      final responseHandler = await authHandler.createAccount(
        requestParams: requestParams,
      );
      expect(responseHandler.statusHandler, StatusHandler.badRequest);
      expect(
        responseHandler.body,
        containsPair('mensagem', 'Todos os campos são obrigatórios.'),
      );
    });
    test('Espero receber StatusHandler.badRequest para um e-mail ja cadastrado',
        () async {
      final requestParams = RequestParams(
        body: {
          'email': 'asdas',
          'senha': '123',
          'nome': 'asd',
          'cargo': 'asd',
        },
      );
      when(
        () => mockUserGateWay.getUserByEmail(requestParams: requestParams),
      ).thenAnswer((_) async => false);
      when(
        () => mockAuthGateWay.createAccount(requestParams: requestParams),
      ).thenAnswer((_) async => true);
      when(
        () => mockAuthService.createAccount(
          requestParams: requestParams,
        ),
      ).thenAnswer(
        (_) async => true,
      );
      final responseHandler = await authHandler.createAccount(
        requestParams: requestParams,
      );
      expect(responseHandler.statusHandler, StatusHandler.badRequest);
      expect(
        responseHandler.body,
        containsPair('mensagem', 'Todos os campos são obrigatórios.'),
      );
    });
  });
}
