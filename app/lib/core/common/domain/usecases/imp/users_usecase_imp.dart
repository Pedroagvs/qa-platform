import 'dart:typed_data';

import 'package:quality_assurance_platform/core/common/data/dtos/user_dto.dart';
import 'package:quality_assurance_platform/core/common/domain/repositories/users_repository.dart';
import 'package:quality_assurance_platform/core/common/domain/usecases/interface/users_usecase.dart';
import 'package:quality_assurance_platform/core/failure/failure.dart';

class UsersUseCaseImp implements UsersUseCase {
  final UsersRepository _usersRepository;
  UsersUseCaseImp(this._usersRepository);
  @override
  Future<({Failure? failure, List<UserDto>? users})> getUsers() async =>
      _usersRepository.getUsers();

  @override
  Future<({Failure? failure, bool? success})> setThumbnail({
    required Uint8List bytes,
    required int idUser,
  }) async =>
      _usersRepository.setThumbnail(idUser: idUser, bytes: bytes);
}
