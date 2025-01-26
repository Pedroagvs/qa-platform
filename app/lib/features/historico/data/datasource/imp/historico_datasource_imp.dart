// ignore_for_file: unnecessary_lambdas

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:quality_assurance_platform/core/client/client.dart';
import 'package:quality_assurance_platform/core/client/status_code.dart';
import 'package:quality_assurance_platform/core/common/data/dtos/arquivo_dto.dart';
import 'package:quality_assurance_platform/core/failure/failure.dart';
import 'package:quality_assurance_platform/features/historico/data/datasource/interface/historico_datasource.dart';
import 'package:quality_assurance_platform/features/historico/data/dto/historico_dto.dart';
import 'package:uno/uno.dart';

class HistoricoDataSourceImp implements HistoricoDataSource {
  final Client client;
  HistoricoDataSourceImp({
    required this.client,
  });
  @override
  Future<String> createHistoric({
    required int idAplicacao,
    required String creatorName,
    required String versionAppOrBranch,
    required String featuresTestadas,
    required String aplicacao,
    FileDto? fileDto,
  }) async {
    var data = const <String, dynamic>{};
    final formaData = FormData();
    try {
      if (fileDto != null && fileDto.bytes != null) {
        formaData
          ..add(
            'dados',
            jsonEncode({
              'idAplicacao': idAplicacao.toString(),
              'criador': creatorName,
              'descricao': featuresTestadas,
              'fonte': versionAppOrBranch,
              'nomeArquivo': fileDto.name,
            }),
          )
          ..addBytes(
            'arquivo',
            fileDto.bytes!,
            filename: fileDto.name,
            contentType: 'application/octet-stream',
          );
      } else {
        data = {
          'idAplicacao': idAplicacao.toString(),
          'criador': creatorName,
          'descricao': featuresTestadas,
          'fonte': versionAppOrBranch,
        };
      }

      final response = await client.post(
        path: '/historico',
        data: fileDto != null && fileDto.bytes != null ? formaData : data,
      );
      switch (response.status) {
        case StatusCode.ok:
          if (response.data != null) {
            return response.data['mensagem'];
          } else {
            throw Failure();
          }
        case StatusCode.badRequest:
          throw Failure();
        case StatusCode.forbidden:
          throw Failure();
        case StatusCode.notFound:
          throw Failure();
        case StatusCode.internalError:
          throw Failure();
      }
      throw Failure();
    } on Failure {
      rethrow;
    } catch (e, s) {
      throw Failure(errorMessage: e.toString(), stackTrace: s);
    }
  }

  @override
  Future<String> deleteHistoric({
    required int idHistorico,
    required int idAplicacao,
  }) async {
    try {
      final response = await client.delete(
        path: '/historico',
        data: {
          'idHistorico': idHistorico,
          'idAplicacao': idAplicacao,
        },
      );
      switch (response.status) {
        case StatusCode.ok:
          if (response.data != null) {
            return response.data['mensagem'];
          } else {
            throw Failure();
          }
        case StatusCode.badRequest:
          throw Failure();
        case StatusCode.forbidden:
          throw Failure();
        case StatusCode.notFound:
          throw Failure();
        case StatusCode.internalError:
          throw Failure();
      }
      throw Failure();
    } on Failure {
      rethrow;
    } catch (e, s) {
      throw Failure(errorMessage: e.toString(), stackTrace: s);
    }
  }

  @override
  Future<List<HistoricoDto>> getHistorics({
    required int offset,
    required int idAplicacao,
  }) async {
    try {
      final response = await client.get(
        path: '/historico',
        params: {
          'idAplicacao': idAplicacao.toString(),
          'offset': offset.toString(),
        },
      );
      switch (response.status) {
        case StatusCode.ok:
          if (response.data != null) {
            return (response.data as List<dynamic>)
                .map((e) => HistoricoDto.fromJson(e))
                .toList();
          } else {
            throw Failure();
          }
        case StatusCode.badRequest:
          throw Failure();
        case StatusCode.forbidden:
          throw Failure();
        case StatusCode.notFound:
          throw Failure();
        case StatusCode.internalError:
          throw Failure();
      }
      throw Failure();
    } on Failure {
      rethrow;
    } catch (e, s) {
      throw Failure(errorMessage: e.toString(), stackTrace: s);
    }
  }

  @override
  Future<String> deleteFileHistoric(int idHistorico) async {
    try {
      final response = await client.delete(
        path: '/historico/deleteFile',
        data: {
          'idHistorico': idHistorico,
        },
      );
      switch (response.status) {
        case StatusCode.ok:
          if (response.data != null) {
            return response.data['mensagem'];
          } else {
            throw Failure();
          }
        case StatusCode.badRequest:
          throw Failure();
        case StatusCode.forbidden:
          throw Failure();
        case StatusCode.notFound:
          throw Failure();
        case StatusCode.internalError:
          throw Failure();
      }
      throw Failure();
    } on Failure {
      rethrow;
    } catch (e, s) {
      throw Failure(errorMessage: e.toString(), stackTrace: s);
    }
  }

  @override
  Future<Uint8List> donwloadFileHistoric({
    required int idArquivo,
    required int idHistorico,
  }) async {
    try {
      final response = await client.get(
        path: '/historico/downloadFile',
        params: {
          'idHistorico': idHistorico.toString(),
          'idArquivo': idArquivo.toString(),
        },
      );
      switch (response.status) {
        case StatusCode.ok:
          if (response.data != null) {
            return Uint8List.fromList(response.data.cast<int>());
          } else {
            throw Failure();
          }
        case StatusCode.badRequest:
          throw Failure();
        case StatusCode.forbidden:
          throw Failure();
        case StatusCode.notFound:
          throw Failure();
        case StatusCode.internalError:
          throw Failure();
      }
      throw Failure();
    } on Failure {
      rethrow;
    } catch (e, s) {
      throw Failure(errorMessage: e.toString(), stackTrace: s);
    }
  }

  @override
  Future<String> uploadFileHistoric(
    int idHistorico,
    FileDto fileDto,
  ) async {
    try {
      final formData = FormData()
        ..add('dados', jsonEncode({'idHistorico': idHistorico}))
        ..addFile(
          'arquivo',
          fileDto.path,
          filename: fileDto.name,
        );
      final response = await client.post(
        path: '/historico/uploadFile',
        data: formData,
      );
      switch (response.status) {
        case StatusCode.ok:
          if (response.data != null) {
            return response.data['mensagem'];
          } else {
            throw Failure();
          }
        case StatusCode.badRequest:
          throw Failure();
        case StatusCode.forbidden:
          throw Failure();
        case StatusCode.notFound:
          throw Failure();
        case StatusCode.internalError:
          throw Failure();
      }
      throw Failure();
    } on Failure {
      rethrow;
    } catch (e, s) {
      throw Failure(errorMessage: e.toString(), stackTrace: s);
    }
  }

  @override
  Future<String> update(Map<String, dynamic> mapUpdate) async {
    try {
      final response = await client.put(
        path: '/historico',
        data: mapUpdate,
      );
      switch (response.status) {
        case StatusCode.ok:
          if (response.data != null) {
            return response.data['mensagem'];
          } else {
            throw Failure();
          }
        case StatusCode.badRequest:
          throw Failure();
        case StatusCode.forbidden:
          throw Failure();
        case StatusCode.notFound:
          throw Failure();
        case StatusCode.internalError:
          throw Failure();
      }
      throw Failure();
    } on Failure {
      rethrow;
    } catch (e, s) {
      throw Failure(errorMessage: e.toString(), stackTrace: s);
    }
  }
}
