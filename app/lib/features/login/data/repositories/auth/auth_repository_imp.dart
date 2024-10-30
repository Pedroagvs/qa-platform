import 'package:quality_assurance_platform/core/common/data/dtos/user_dto.dart';
import 'package:quality_assurance_platform/core/failure/failure.dart';
import 'package:quality_assurance_platform/features/login/data/datasources/remote/interface/auth_datasource.dart';
import 'package:quality_assurance_platform/features/login/domain/repositories/auth_repository.dart';

class AuthRepositoryImp implements AuthRepository {
  final AuthDataSource _authDataSource;
  AuthRepositoryImp(this._authDataSource);
  @override
  Future<({Failure? failure, bool? success})> createUserWithEmailAndPassword({
    required String nome,
    required String email,
    required String password,
    required String cargo,
  }) async {
    try {
      return (
        failure: null,
        success: await _authDataSource.createUserWithEmailAndPassword(
          email: email,
          password: password,
          cargo: cargo,
          nome: nome,
        )
      );
    } on Failure catch (e) {
      return (failure: e, success: null);
    }
  }

  @override
  Future<({Failure? failure, UserDto? userEntity})> signInWithEmailAndPassword({
    required String email,
    required String passWord,
  }) async {
    try {
      return (
        failure: null,
        userEntity: await _authDataSource.signInWithEmailAndPassword(
          email: email,
          passWord: passWord,
        )
      );
    } on Failure catch (e) {
      return (failure: e, userEntity: null);
    }
  }

  @override
  Future<({Failure? failure, bool? success})> changePassword({
    required String password,
    required String newPassword,
    required int idUser,
  }) async {
    try {
      return (
        failure: null,
        success: await _authDataSource.changePassword(
          password: password,
          newPassword: newPassword,
          idUser: idUser,
        )
      );
    } on Failure catch (e) {
      return (failure: e, success: null);
    }
  }
}
