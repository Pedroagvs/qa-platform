import 'dart:typed_data';

import 'package:quality_assurance_platform/core/common/domain/entities/arquivo_entity.dart';
import 'package:quality_assurance_platform/core/failure/failure.dart';
import 'package:quality_assurance_platform/features/historico/data/datasource/interface/historico_datasource.dart';
import 'package:quality_assurance_platform/features/historico/data/dto/historico_dto.dart';
import 'package:quality_assurance_platform/features/historico/domain/repositories/historico_repository.dart';

class HistoricoRepositoryImp implements HistoricoRepository {
  final HistoricoDataSource _dataSource;
  HistoricoRepositoryImp(this._dataSource);
  @override
  Future<({Failure? failure, String? message})> createHistorico({
    required int idAplicacao,
    required String creatorName,
    required String versionAppOrBranch,
    required String featuresTestadas,
    required String aplicacao,
    ArquivoEntity? arquivoEntity,
  }) async {
    try {
      return (
        failure: null,
        message: await _dataSource.createHistorico(
          idAplicacao: idAplicacao,
          creatorName: creatorName,
          featuresTestadas: featuresTestadas,
          versionAppOrBranch: versionAppOrBranch,
          aplicacao: aplicacao,
          arquivoEntity: arquivoEntity,
        )
      );
    } on Failure catch (e) {
      return (failure: e, message: null);
    }
  }

  @override
  Future<({Failure? failure, String? message})> deleteHistorico({
    required int idHistorico,
    required int idAplicacao,
  }) async {
    try {
      return (
        failure: null,
        message: await _dataSource.deleteHistorico(
          idHistorico: idHistorico,
          idAplicacao: idAplicacao,
        ),
      );
    } on Failure catch (e) {
      return (failure: e, message: null);
    }
  }

  @override
  Future<({Failure? failure, List<HistoricoDto>? historicos})> getHistoricos({
    required int offset,
    required int idAplicacao,
  }) async {
    try {
      return (
        failure: null,
        historicos: await _dataSource.getHistoricos(
          offset: offset,
          idAplicacao: idAplicacao,
        )
      );
    } on Failure catch (e) {
      return (failure: e, historicos: null);
    }
  }

  @override
  Future<({Failure? failure, String? message})> uploadFileHistorico(
    int idHistorico,
    ArquivoEntity arquivoEntity,
  ) async {
    try {
      return (
        failure: null,
        message:
            await _dataSource.uploadFileHistorico(idHistorico, arquivoEntity)
      );
    } on Failure catch (e) {
      return (failure: e, message: null);
    }
  }

  @override
  Future<({Failure? failure, String? message})> deleteFileHistorico(
    int idHistorico,
  ) async {
    try {
      return (
        failure: null,
        message: await _dataSource.deleteFileHistorico(idHistorico)
      );
    } on Failure catch (e) {
      return (failure: e, message: null);
    }
  }

  @override
  Future<({Failure? failure, String? message})> update(
    Map<String, dynamic> mapUpdate,
  ) async {
    try {
      return (failure: null, message: await _dataSource.update(mapUpdate));
    } on Failure catch (e) {
      return (failure: e, message: null);
    }
  }

  @override
  Future<({Uint8List? bytes, Failure? failure})> downloadFileHistorico({
    required int idArquivo,
    required int idHistorico,
  }) async {
    try {
      return (
        failure: null,
        bytes: await _dataSource.donwloadFileHistorico(
          idArquivo: idArquivo,
          idHistorico: idHistorico,
        )
      );
    } on Failure catch (e) {
      return (failure: e, bytes: null);
    }
  }
}
