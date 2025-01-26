// ignore_for_file: unnecessary_lambdas

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:quality_assurance_platform/core/client/client.dart';
import 'package:quality_assurance_platform/core/client/status_code.dart';
import 'package:quality_assurance_platform/core/common/data/dtos/arquivo_dto.dart';
import 'package:quality_assurance_platform/core/common/data/dtos/teste_dto.dart';
import 'package:quality_assurance_platform/core/common/domain/entities/test_entity.dart';
import 'package:quality_assurance_platform/core/failure/failure.dart';
import 'package:quality_assurance_platform/features/testes/data/interface/teste_datasource.dart';
import 'package:uno/uno.dart';

class TesteDataSourceImp implements TesteDataSource {
  final Client unoClient;
  TesteDataSourceImp({
    required this.unoClient,
  });
  @override
  Future<bool> create({
    required TesteEntity testeEntity,
    required void Function(int, int)? onProgress,
    required int idHistorico,
  }) async {
    try {
      final formaData = FormData();
      var data = <String, dynamic>{};
      data = {
        'criador': testeEntity.criador,
        'feature': testeEntity.feature,
        'tag': TesteEntity.getTagTeste(testeEntity.tagTeste),
        'descricao': testeEntity.descricao,
        'passos': testeEntity.passos,
        'observacoes': testeEntity.observacoes,
        'usuario': testeEntity.loginTeste,
        'senha': testeEntity.senhaTeste,
        'situacao': TesteEntity.getSituacao(testeEntity.situacaoTeste),
        'resultadoEsperado': testeEntity.resultadoEsperado,
        'idHistorico': idHistorico,
      };
      if (testeEntity.files.isNotEmpty) {
        for (var i = 0; i < testeEntity.files.length; i++) {
          formaData.addBytes(
            'arquivo-$i',
            testeEntity.files[i].bytes!,
            filename: testeEntity.files[i].name,
            contentType: 'application/octet-stream',
          );
        }
        formaData.add('dados', jsonEncode(data));
      }

      final response = await unoClient.post(
        path: '/teste',
        data: testeEntity.files.isNotEmpty ? formaData : jsonEncode(data),
        onProgress: onProgress,
      );
      if (response.data != null) {
        return (response.data['mensagem'] as String)
            .toLowerCase()
            .contains('sucesso');
      } else {
        return false;
      }
    } on Failure {
      rethrow;
    } catch (e, s) {
      throw Failure(errorMessage: e.toString(), stackTrace: s);
    }
  }

  @override
  Future<List<TesteDto>> getTestes({
    required int idHistorico,
    required void Function(int, int)? onProgress,
  }) async {
    try {
      final response = await unoClient.get(
        path: '/teste',
        params: {'idHistorico': idHistorico.toString()},
        onProgress: onProgress,
      );
      if (response.data != null) {
        return (response.data as List)
            .map((e) => TesteDto.fromJson(e))
            .toList();
      }
      return <TesteDto>[];
    } on Failure {
      rethrow;
    } catch (e, s) {
      throw Failure(errorMessage: e.toString(), stackTrace: s);
    }
  }

  @override
  Future<bool> updateTeste({
    required Map<String, dynamic> mapUpdate,
    required void Function(int, int)? onProgress,
  }) async {
    try {
      final response = await unoClient.put(
        path: '/teste',
        data: mapUpdate,
        onProgress: onProgress,
      );
      if (response.data != null) {
        return (response.data['mensagem'] as String)
            .toLowerCase()
            .contains('sucesso');
      } else {
        return false;
      }
    } on Failure {
      rethrow;
    } catch (e, s) {
      throw Failure(errorMessage: e.toString(), stackTrace: s);
    }
  }

  @override
  Future<bool> deleteTicket({
    required int idTeste,
    required int idHistorico,
  }) async {
    try {
      final response = await unoClient.delete(
        path: '/teste',
        data: {
          'idTeste': idTeste,
          'idHistorico': idHistorico,
        },
      );
      if (response.data != null) {
        return (response.data['mensagem'] as String)
            .toLowerCase()
            .contains('sucesso');
      } else {
        return false;
      }
    } on Failure {
      rethrow;
    } catch (e, s) {
      throw Failure(errorMessage: e.toString(), stackTrace: s);
    }
  }

  @override
  Future<Uint8List> downloadArquivos({
    required int idTeste,
    required int idArquivo,
    required void Function(int, int)? onProgress,
  }) async {
    try {
      final response = await unoClient.get(
        path: '/teste/arquivos',
        params: {
          'idTeste': idTeste.toString(),
          'idArquivo': idArquivo.toString(),
        },
        onProgress: onProgress,
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
  Future<bool> uploadArquivos({
    required int idTeste,
    required List<FileDto> files,
    required void Function(int, int)? onProgress,
  }) async {
    try {
      final formData = FormData()
        ..add('dados', jsonEncode({'idTeste': idTeste}));
      for (final file in files) {
        formData.addBytes(
          DateTime.now().millisecondsSinceEpoch.toString(),
          file.bytes!,
          filename: file.name,
        );
      }

      final response = await unoClient.post(
        path: '/teste/arquivos',
        data: formData,
        onProgress: onProgress,
      );
      if (response.data != null) {
        return (response.data['mensagem'] as String)
            .toLowerCase()
            .contains('sucesso');
      } else {
        return false;
      }
    } on Failure {
      rethrow;
    } catch (e, s) {
      throw Failure(errorMessage: e.toString(), stackTrace: s);
    }
  }

  @override
  Future<bool> deleteArquivo({
    required int idTeste,
    required int idArquivo,
  }) async {
    try {
      final response = await unoClient.delete(
        path: '/teste/arquivos',
        data: {
          'idTeste': idTeste,
          'idArquivo': idArquivo,
        },
      );
      if (response.data != null) {
        return (response.data['mensagem'] as String)
            .toLowerCase()
            .contains('sucesso');
      } else {
        return false;
      }
    } on Failure {
      rethrow;
    } catch (e, s) {
      throw Failure(errorMessage: e.toString(), stackTrace: s);
    }
  }
}
