import 'package:quality_assurance_platform/core/common/data/dtos/user_dto.dart';
import 'package:quality_assurance_platform/core/failure/failure.dart';
import 'package:quality_assurance_platform/features/login/domain/repositories/auth_repository.dart';
import 'package:quality_assurance_platform/features/login/domain/usecases/interface/auth_usecase.dart';

class AuthUseCaseImp implements AuthUseCase {
  final AuthRepository _authRepository;
  AuthUseCaseImp(this._authRepository);

  @override
  Future<({Failure? failure, bool? success})> createUserWithEmailAndPassword({
    required String nome,
    required String email,
    required String password,
    required String cargo,
  }) async =>
      _authRepository.createUserWithEmailAndPassword(
        email: email,
        password: password,
        nome: nome,
        cargo: cargo,
      );

  @override
  Future<({Failure? failure, UserDto? userEntity})> signInWithEmailAndPassword({
    required String email,
    required String passWord,
  }) async =>
      _authRepository.signInWithEmailAndPassword(
        email: email,
        passWord: passWord,
      );

  @override
  Future<({Failure? failure, bool? success})> changePassword({
    required String password,
    required String newPassword,
    required int idUser,
  }) async =>
      _authRepository.changePassword(
        password: password,
        newPassword: newPassword,
        idUser: idUser,
      );
}
