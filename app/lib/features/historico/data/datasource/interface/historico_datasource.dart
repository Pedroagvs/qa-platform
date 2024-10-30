import 'dart:typed_data';

import 'package:quality_assurance_platform/core/common/domain/entities/arquivo_entity.dart';
import 'package:quality_assurance_platform/features/historico/data/dto/historico_dto.dart';

abstract class HistoricoDataSource {
  Future<List<HistoricoDto>> getHistoricos({
    required int offset,
    required int idAplicacao,
  });
  Future<String> createHistorico({
    required int idAplicacao,
    required String creatorName,
    required String versionAppOrBranch,
    required String featuresTestadas,
    required String aplicacao,
    ArquivoEntity? arquivoEntity,
  });

  Future<String> deleteHistorico({
    required int idHistorico,
    required int idAplicacao,
  });
  Future<String> deleteFileHistorico(int idHistorico);
  Future<String> uploadFileHistorico(
    int idHistorico,
    ArquivoEntity arquivoEntity,
  );

  Future<String> update(Map<String, dynamic> mapUpdate);

  Future<Uint8List> donwloadFileHistorico({
    required int idArquivo,
    required int idHistorico,
  });
}
