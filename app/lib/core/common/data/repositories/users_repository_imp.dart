import 'dart:typed_data';

import 'package:quality_assurance_platform/core/common/data/datasource/interface/users_datasource.dart';
import 'package:quality_assurance_platform/core/common/data/dtos/user_dto.dart';
import 'package:quality_assurance_platform/core/common/domain/repositories/users_repository.dart';
import 'package:quality_assurance_platform/core/failure/failure.dart';

class UsersRepositoryImp implements UsersRepository {
  final UsersDataSource usersDataSource;
  UsersRepositoryImp(this.usersDataSource);
  @override
  Future<({Failure? failure, List<UserDto>? users})> getUsers() async {
    try {
      return (failure: null, users: await usersDataSource.getUsers());
    } on Failure catch (e) {
      return (failure: e, users: null);
    }
  }

  @override
  Future<({Failure? failure, bool? success})> setThumbnail({
    required Uint8List bytes,
    required int idUser,
  }) async {
    try {
      return (
        failure: null,
        success:
            await usersDataSource.setThumbnail(bytes: bytes, idUser: idUser)
      );
    } on Failure catch (e) {
      return (failure: e, success: null);
    }
  }
}
