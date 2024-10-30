import 'dart:typed_data';

import 'package:quality_assurance_platform/core/common/domain/entities/arquivo_entity.dart';
import 'package:quality_assurance_platform/core/failure/failure.dart';
import 'package:quality_assurance_platform/features/historico/data/dto/historico_dto.dart';

abstract class HistoricoRepository {
  Future<({Failure? failure, List<HistoricoDto>? historicos})> getHistoricos({
    required int offset,
    required int idAplicacao,
  });
  Future<({Failure? failure, String? message})> createHistorico({
    required int idAplicacao,
    required String creatorName,
    required String versionAppOrBranch,
    required String featuresTestadas,
    required String aplicacao,
    ArquivoEntity? arquivoEntity,
  });

  Future<({Failure? failure, String? message})> deleteHistorico({
    required int idHistorico,
    required int idAplicacao,
  });

  Future<({Failure? failure, String? message})> uploadFileHistorico(
    int idHistorico,
    ArquivoEntity arquivoEntity,
  );
  Future<({Failure? failure, String? message})> deleteFileHistorico(
    int idHistorico,
  );
  Future<({Failure? failure, String? message})> update(
    Map<String, dynamic> mapUpdate,
  );
  Future<({Failure? failure, Uint8List? bytes})> downloadFileHistorico({
    required int idArquivo,
    required int idHistorico,
  });
}
