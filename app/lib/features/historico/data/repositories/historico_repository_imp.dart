import 'dart:typed_data';

import 'package:quality_assurance_platform/core/common/data/dtos/arquivo_dto.dart';
import 'package:quality_assurance_platform/core/failure/failure.dart';
import 'package:quality_assurance_platform/features/historico/data/datasource/interface/historico_datasource.dart';
import 'package:quality_assurance_platform/features/historico/data/dto/historico_dto.dart';
import 'package:quality_assurance_platform/features/historico/domain/repositories/historico_repository.dart';

class HistoricoRepositoryImp implements HistoricoRepository {
  final HistoricoDataSource _dataSource;
  HistoricoRepositoryImp(this._dataSource);
  @override
  Future<({Failure? failure, String? message})> createHistoric({
    required int idAplicacao,
    required String creatorName,
    required String versionAppOrBranch,
    required String featuresTestadas,
    required String aplicacao,
    FileDto? fileDto,
  }) async {
    try {
      return (
        failure: null,
        message: await _dataSource.createHistoric(
          idAplicacao: idAplicacao,
          creatorName: creatorName,
          featuresTestadas: featuresTestadas,
          versionAppOrBranch: versionAppOrBranch,
          aplicacao: aplicacao,
          fileDto: fileDto,
        )
      );
    } on Failure catch (e) {
      return (failure: e, message: null);
    }
  }

  @override
  Future<({Failure? failure, String? message})> deleteHistoric({
    required int idHistorico,
    required int idAplicacao,
  }) async {
    try {
      return (
        failure: null,
        message: await _dataSource.deleteHistoric(
          idHistorico: idHistorico,
          idAplicacao: idAplicacao,
        ),
      );
    } on Failure catch (e) {
      return (failure: e, message: null);
    }
  }

  @override
  Future<({Failure? failure, List<HistoricoDto>? historicos})> getHistorics({
    required int offset,
    required int idAplicacao,
  }) async {
    try {
      return (
        failure: null,
        historicos: await _dataSource.getHistorics(
          offset: offset,
          idAplicacao: idAplicacao,
        )
      );
    } on Failure catch (e) {
      return (failure: e, historicos: null);
    }
  }

  @override
  Future<({Failure? failure, String? message})> uploadFileHistoric(
    int idHistorico,
    FileDto fileDto,
  ) async {
    try {
      return (
        failure: null,
        message: await _dataSource.uploadFileHistoric(idHistorico, fileDto)
      );
    } on Failure catch (e) {
      return (failure: e, message: null);
    }
  }

  @override
  Future<({Failure? failure, String? message})> deleteFileHistoric(
    int idHistorico,
  ) async {
    try {
      return (
        failure: null,
        message: await _dataSource.deleteFileHistoric(idHistorico)
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
  Future<({Uint8List? bytes, Failure? failure})> downloadFileHistoric({
    required int idArquivo,
    required int idHistorico,
  }) async {
    try {
      return (
        failure: null,
        bytes: await _dataSource.donwloadFileHistoric(
          idArquivo: idArquivo,
          idHistorico: idHistorico,
        )
      );
    } on Failure catch (e) {
      return (failure: e, bytes: null);
    }
  }
}
