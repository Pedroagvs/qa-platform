import 'package:flutter/foundation.dart';
import 'package:quality_assurance_platform/core/common/data/dtos/arquivo_dto.dart';
import 'package:quality_assurance_platform/core/common/data/dtos/teste_dto.dart';
import 'package:quality_assurance_platform/core/common/domain/entities/test_entity.dart';

abstract class TesteDataSource {
  Future<bool> create({
    required TesteEntity testeEntity,
    required int idHistorico,
    required void Function(int, int)? onProgress,
  });

  Future<List<TesteDto>> getTestes({
    required int idHistorico,
    required void Function(int, int)? onProgress,
  });

  Future<bool> updateTeste({
    required Map<String, dynamic> mapUpdate,
    required void Function(int, int)? onProgress,
  });

  Future<bool> uploadArquivos({
    required int idTeste,
    required List<FileDto> files,
    required void Function(int, int)? onProgress,
  });

  Future<Uint8List> downloadArquivos({
    required int idTeste,
    required int idArquivo,
    required void Function(int, int)? onProgress,
  });

  Future<bool> deleteTicket({
    required int idTeste,
    required int idHistorico,
  });
  Future<bool> deleteArquivo({
    required int idTeste,
    required int idArquivo,
  });
}
