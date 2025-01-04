import 'package:quality_assurance_platform/core/client/client.dart';
import 'package:quality_assurance_platform/core/common/data/dtos/user_dto.dart';
import 'package:quality_assurance_platform/core/failure/failure.dart';
import 'package:quality_assurance_platform/features/login/data/datasources/remote/interface/auth_datasource.dart';

class AuthDataSourceImp implements AuthDataSource {
  final Client unoClient;
  AuthDataSourceImp({required this.unoClient});
  @override
  Future<bool> createUserWithEmailAndPassword({
    required String nome,
    required String email,
    required String cargo,
    required String password,
  }) async {
    try {
      final response = await unoClient.post(
        path: '/register',
        headers: {},
        data: {
          'nome': nome,
          'email': email,
          'cargo': cargo,
          'senha': password,
        },
      );
      return response.data != null;
    } on Failure {
      rethrow;
    } catch (e, s) {
      throw Failure(errorMessage: e.toString(), stackTrace: s);
    }
  }

  @override
  Future<UserDto> signInWithEmailAndPassword({
    required String email,
    required String passWord,
  }) async {
    try {
      final response = await unoClient.post(
        path: '/auth',
        data: {
          'email': email,
          'senha': passWord,
        },
      );
      if (response.data != null) {
        return UserDto.fromJson(response.data);
      }
      throw Failure(errorMessage: 'Falha ao realizar o login !');
    } on Failure {
      rethrow;
    } catch (e, s) {
      throw Failure(errorMessage: e.toString(), stackTrace: s);
    }
  }

  @override
  Future<bool> changePassword({
    required String password,
    required String newPassword,
    required int idUser,
  }) async {
    try {
      final response = await unoClient.put(
        path: '/auth/changePassword',
        data: {
          'idUser': idUser,
          'senha': password,
          'novaSenha': newPassword,
        },
      );
      if (response.data != null) {
        return response.data['mensagem'].toString().contains('Sucesso');
      }
      throw Failure(errorMessage: 'Falha ao realizar o login !');
    } on Failure {
      rethrow;
    } catch (e, s) {
      throw Failure(errorMessage: e.toString(), stackTrace: s);
    }
  }
}
