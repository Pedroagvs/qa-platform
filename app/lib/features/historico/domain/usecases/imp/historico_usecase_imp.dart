import 'dart:typed_data';

import 'package:quality_assurance_platform/core/common/domain/entities/arquivo_entity.dart';
import 'package:quality_assurance_platform/core/failure/failure.dart';
import 'package:quality_assurance_platform/features/historico/data/dto/historico_dto.dart';
import 'package:quality_assurance_platform/features/historico/domain/repositories/historico_repository.dart';
import 'package:quality_assurance_platform/features/historico/domain/usecases/interface/historico_usecase.dart';

class HistoricoUseCaseImp implements HistoricoUsecase {
  final HistoricoRepository _repository;
  HistoricoUseCaseImp(this._repository);
  @override
  Future<({Failure? failure, String? message})> createHistorico({
    required int idAplicacao,
    required String creatorName,
    required String versionAppOrBranch,
    required String featuresTestadas,
    required String aplicacao,
    ArquivoEntity? arquivoEntity,
  }) {
    return _repository.createHistorico(
      idAplicacao: idAplicacao,
      creatorName: creatorName,
      featuresTestadas: featuresTestadas,
      versionAppOrBranch: versionAppOrBranch,
      aplicacao: aplicacao,
      arquivoEntity: arquivoEntity,
    );
  }

  @override
  Future<({Failure? failure, String? message})> deleteHistorico({
    required int idHistorico,
    required int idAplicacao,
  }) {
    return _repository.deleteHistorico(
      idHistorico: idHistorico,
      idAplicacao: idAplicacao,
    );
  }

  @override
  Future<({Failure? failure, List<HistoricoDto>? historicos})> getHistoricos({
    required int offset,
    required int idAplicacao,
  }) {
    return _repository.getHistoricos(
      offset: offset,
      idAplicacao: idAplicacao,
    );
  }

  @override
  Future<({Failure? failure, String? message})> uploadFileHistorico(
    int idHistorico,
    ArquivoEntity arquivoEntity,
  ) async {
    return _repository.uploadFileHistorico(idHistorico, arquivoEntity);
  }

  @override
  Future<({Failure? failure, String? message})> deleteFileHistorico(
    int idHistorico,
  ) async {
    return _repository.deleteFileHistorico(idHistorico);
  }

  @override
  Future<({Failure? failure, String? message})> update(
    Map<String, dynamic> mapUpdate,
  ) async {
    return _repository.update(mapUpdate);
  }

  @override
  Future<({Uint8List? bytes, Failure? failure})> downloadFileHistorico({
    required int idArquivo,
    required int idHistorico,
  }) async =>
      _repository.downloadFileHistorico(
        idArquivo: idArquivo,
        idHistorico: idHistorico,
      );
}
