import 'dart:typed_data';

import 'package:quality_assurance_platform/core/common/data/dtos/arquivo_dto.dart';
import 'package:quality_assurance_platform/features/historico/data/dto/historico_dto.dart';

abstract class HistoricoDataSource {
  Future<List<HistoricoDto>> getHistorics({
    required int offset,
    required int idAplicacao,
  });
  Future<String> createHistoric({
    required int idAplicacao,
    required String creatorName,
    required String versionAppOrBranch,
    required String featuresTestadas,
    required String aplicacao,
    FileDto? fileDto,
  });

  Future<String> deleteHistoric({
    required int idHistorico,
    required int idAplicacao,
  });
  Future<String> deleteFileHistoric(int idHistorico);

  Future<String> uploadFileHistoric(
    int idHistorico,
    FileDto fileDto,
  );

  Future<String> update(Map<String, dynamic> mapUpdate);

  Future<Uint8List> donwloadFileHistoric({
    required int idArquivo,
    required int idHistorico,
  });
}
