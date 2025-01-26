import 'dart:typed_data';

import 'package:quality_assurance_platform/core/common/data/dtos/arquivo_dto.dart';
import 'package:quality_assurance_platform/core/failure/failure.dart';
import 'package:quality_assurance_platform/features/historico/data/dto/historico_dto.dart';

abstract class HistoricoRepository {
  Future<({Failure? failure, List<HistoricoDto>? historicos})> getHistorics({
    required int offset,
    required int idAplicacao,
  });
  Future<({Failure? failure, String? message})> createHistoric({
    required int idAplicacao,
    required String creatorName,
    required String versionAppOrBranch,
    required String featuresTestadas,
    required String aplicacao,
    FileDto? fileDto,
  });

  Future<({Failure? failure, String? message})> deleteHistoric({
    required int idHistorico,
    required int idAplicacao,
  });

  Future<({Failure? failure, String? message})> uploadFileHistoric(
    int idHistorico,
    FileDto fileDto,
  );
  Future<({Failure? failure, String? message})> deleteFileHistoric(
    int idHistorico,
  );
  Future<({Failure? failure, String? message})> update(
    Map<String, dynamic> mapUpdate,
  );
  Future<({Failure? failure, Uint8List? bytes})> downloadFileHistoric({
    required int idArquivo,
    required int idHistorico,
  });
}
