import 'package:quality_assurance_platform/core/common/data/dtos/user_dto.dart';
import 'package:quality_assurance_platform/core/failure/failure.dart';

abstract class AuthUseCase {
  Future<({Failure? failure, bool? success})> createUserWithEmailAndPassword({
    required String nome,
    required String email,
    required String password,
    required String cargo,
  });
  Future<({Failure? failure, UserDto? userEntity})> signInWithEmailAndPassword({
    required String email,
    required String passWord,
  });
  Future<({Failure? failure, bool? success})> changePassword({
    required String password,
    required String newPassword,
    required int idUser,
  });
}
