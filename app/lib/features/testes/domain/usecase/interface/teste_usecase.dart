import 'package:flutter/foundation.dart';
import 'package:quality_assurance_platform/core/common/data/dtos/arquivo_dto.dart';
import 'package:quality_assurance_platform/core/common/data/dtos/teste_dto.dart';
import 'package:quality_assurance_platform/core/common/domain/entities/test_entity.dart';
import 'package:quality_assurance_platform/core/failure/failure.dart';

abstract class TesteUseCase {
  Future<({Failure? failure, bool? success})> create({
    required TesteEntity testeEntity,
    required int idHistorico,
    required void Function(int, int)? onProgress,
  });
  Future<({Failure? failure, List<TesteDto>? testes})> getTestes({
    required int idHistorico,
    required void Function(int, int)? onProgress,
  });
  Future<({Failure? failure, bool? success})> updateTeste({
    required Map<String, dynamic> mapUpdate,
    required void Function(int, int)? onProgress,
  });
  Future<({Failure? failure, bool? success})> uploadArquivos({
    required int idTeste,
    required List<FileDto> files,
    required void Function(int, int)? onProgress,
  });
  Future<({Uint8List? bytes, Failure? failure})> downloadArquivos({
    required int idTeste,
    required int idArquivo,
    required void Function(int, int)? onProgress,
  });

  Future<({Failure? failure, bool? success})> deleteTicket({
    required int idTeste,
    required int idHistorico,
  });

  Future<({Failure? failure, bool? success})> deleteArquivo({
    required int idTeste,
    required int idArquivo,
  });
}
