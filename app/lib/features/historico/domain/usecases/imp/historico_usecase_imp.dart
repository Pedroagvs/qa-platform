import 'dart:typed_data';

import 'package:quality_assurance_platform/core/common/data/dtos/arquivo_dto.dart';
import 'package:quality_assurance_platform/core/failure/failure.dart';
import 'package:quality_assurance_platform/features/historico/data/dto/historico_dto.dart';
import 'package:quality_assurance_platform/features/historico/domain/repositories/historico_repository.dart';
import 'package:quality_assurance_platform/features/historico/domain/usecases/interface/historico_usecase.dart';

class HistoricoUseCaseImp implements HistoricoUsecase {
  final HistoricoRepository _repository;
  HistoricoUseCaseImp(this._repository);
  @override
  Future<({Failure? failure, String? message})> createHistoric({
    required int idAplicacao,
    required String creatorName,
    required String versionAppOrBranch,
    required String featuresTestadas,
    required String aplicacao,
    FileDto? fileDto,
  }) {
    return _repository.createHistoric(
      idAplicacao: idAplicacao,
      creatorName: creatorName,
      featuresTestadas: featuresTestadas,
      versionAppOrBranch: versionAppOrBranch,
      aplicacao: aplicacao,
      fileDto: fileDto,
    );
  }

  @override
  Future<({Failure? failure, String? message})> deleteHistoric({
    required int idHistorico,
    required int idAplicacao,
  }) {
    return _repository.deleteHistoric(
      idHistorico: idHistorico,
      idAplicacao: idAplicacao,
    );
  }

  @override
  Future<({Failure? failure, List<HistoricoDto>? historicos})> getHistorics({
    required int offset,
    required int idAplicacao,
  }) {
    return _repository.getHistorics(
      offset: offset,
      idAplicacao: idAplicacao,
    );
  }

  @override
  Future<({Failure? failure, String? message})> uploadFileHistoric(
    int idHistorico,
    FileDto fileDto,
  ) async {
    return _repository.uploadFileHistoric(idHistorico, fileDto);
  }

  @override
  Future<({Failure? failure, String? message})> deleteFileHistoric(
    int idHistorico,
  ) async {
    return _repository.deleteFileHistoric(idHistorico);
  }

  @override
  Future<({Failure? failure, String? message})> update(
    Map<String, dynamic> mapUpdate,
  ) async {
    return _repository.update(mapUpdate);
  }

  @override
  Future<({Uint8List? bytes, Failure? failure})> downloadFileHistoric({
    required int idArquivo,
    required int idHistorico,
  }) async =>
      _repository.downloadFileHistoric(
        idArquivo: idArquivo,
        idHistorico: idHistorico,
      );
}
