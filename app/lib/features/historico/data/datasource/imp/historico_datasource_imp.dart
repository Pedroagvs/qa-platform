// ignore_for_file: unnecessary_lambdas

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:quality_assurance_platform/core/client/status_code.dart';
import 'package:quality_assurance_platform/core/client/uno_client.dart';
import 'package:quality_assurance_platform/core/common/domain/entities/arquivo_entity.dart';
import 'package:quality_assurance_platform/core/failure/failure.dart';
import 'package:quality_assurance_platform/features/historico/data/datasource/interface/historico_datasource.dart';
import 'package:quality_assurance_platform/features/historico/data/dto/historico_dto.dart';
import 'package:uno/uno.dart';

class HistoricoDataSourceImp implements HistoricoDataSource {
  final UnoClient unoClient;
  HistoricoDataSourceImp({
    required this.unoClient,
  });
  @override
  Future<String> createHistorico({
    required int idAplicacao,
    required String creatorName,
    required String versionAppOrBranch,
    required String featuresTestadas,
    required String aplicacao,
    ArquivoEntity? arquivoEntity,
  }) async {
    var data = const <String, dynamic>{};
    final formaData = FormData();
    try {
      if (arquivoEntity != null && arquivoEntity.bytes != null) {
        formaData
          ..add(
            'dados',
            jsonEncode({
              'idAplicacao': idAplicacao.toString(),
              'criador': creatorName,
              'descricao': featuresTestadas,
              'fonte': versionAppOrBranch,
              'nomeArquivo': arquivoEntity.nome,
            }),
          )
          ..addBytes(
            'arquivo',
            arquivoEntity.bytes!,
            filename: arquivoEntity.nome,
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

      final response = await unoClient.post(
        path: '/historico',
        data: arquivoEntity != null && arquivoEntity.bytes != null
            ? formaData
            : data,
        headers: {
          'Content-type': arquivoEntity != null && arquivoEntity.bytes != null
              ? 'multipart/form-data'
              : 'aplication/json',
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
    } catch (e, s) {
      throw Failure(errorMessage: e.toString(), stackTrace: s);
    }
  }

  @override
  Future<String> deleteHistorico({
    required int idHistorico,
    required int idAplicacao,
  }) async {
    try {
      final response = await unoClient.delete(
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
    } catch (e, s) {
      throw Failure(errorMessage: e.toString(), stackTrace: s);
    }
  }

  @override
  Future<List<HistoricoDto>> getHistoricos({
    required int offset,
    required int idAplicacao,
  }) async {
    try {
      final response = await unoClient.get(
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
    } catch (e, s) {
      throw Failure(errorMessage: e.toString(), stackTrace: s);
    }
  }

  @override
  Future<String> deleteFileHistorico(int idHistorico) async {
    try {
      final response = await unoClient.delete(
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
    } catch (e, s) {
      throw Failure(errorMessage: e.toString(), stackTrace: s);
    }
  }

  @override
  Future<Uint8List> donwloadFileHistorico({
    required int idArquivo,
    required int idHistorico,
  }) async {
    try {
      final response = await unoClient.get(
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
    } catch (e, s) {
      throw Failure(errorMessage: e.toString(), stackTrace: s);
    }
  }

  @override
  Future<String> uploadFileHistorico(
    int idHistorico,
    ArquivoEntity arquivoEntity,
  ) async {
    try {
      final formData = FormData()
        ..add('dados', jsonEncode({'idHistorico': idHistorico}))
        ..addFile(
          'arquivo',
          arquivoEntity.path,
          filename: arquivoEntity.nome,
        );
      final response = await unoClient.post(
        path: '/historico/uploadFile',
        data: formData,
        headers: {
          'Content-type': 'multipart/form-data',
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
    } catch (e, s) {
      throw Failure(errorMessage: e.toString(), stackTrace: s);
    }
  }

  @override
  Future<String> update(Map<String, dynamic> mapUpdate) async {
    try {
      final response = await unoClient.put(
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
    } catch (e, s) {
      throw Failure(errorMessage: e.toString(), stackTrace: s);
    }
  }
}
