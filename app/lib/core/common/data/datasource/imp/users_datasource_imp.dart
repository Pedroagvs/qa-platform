// ignore_for_file: unnecessary_lambdas

import 'dart:convert';
import 'dart:typed_data';

import 'package:quality_assurance_platform/core/client/client.dart';
import 'package:quality_assurance_platform/core/common/data/datasource/interface/users_datasource.dart';
import 'package:quality_assurance_platform/core/common/data/dtos/user_dto.dart';
import 'package:quality_assurance_platform/core/failure/failure.dart';
import 'package:uno/uno.dart';

class UsersDataSourceImp implements UsersDataSource {
  final Client unoClient;
  UsersDataSourceImp(this.unoClient);
  @override
  Future<List<UserDto>> getUsers() async {
    try {
      final response = await unoClient.get(
        path: '/user',
      );
      if (response.data != null) {
        return (response.data as List<dynamic>)
            .map((e) => UserDto.fromJson(e))
            .toList();
      }
      throw Failure(errorMessage: 'Falha criar o grupo !');
    } on Failure {
      rethrow;
    } catch (e, s) {
      throw Failure(errorMessage: e.toString(), stackTrace: s);
    }
  }

  @override
  Future<bool> setThumbnail({
    required Uint8List bytes,
    required int idUser,
  }) async {
    try {
      final formData = FormData()
        ..addBytes(
          'arquivo',
          bytes,
          filename: 'thumbnail',
          contentType: 'application/octet-stream',
        )
        ..add('dados', jsonEncode({'idUser': idUser}));
      final response = await unoClient.put(
        path: '/user/thumbnail',
        data: formData,
      );

      if (response.data != null) {
        return response.data['mensagem'].toString().contains('Sucesso');
      }
      throw Failure(errorMessage: 'Falha criar o grupo !');
    } on Failure {
      rethrow;
    } catch (e, s) {
      throw Failure(errorMessage: e.toString(), stackTrace: s);
    }
  }
}
