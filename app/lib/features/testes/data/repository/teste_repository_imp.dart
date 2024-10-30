import 'package:flutter/foundation.dart';
import 'package:quality_assurance_platform/core/common/data/dtos/teste_dto.dart';
import 'package:quality_assurance_platform/core/common/domain/entities/arquivo_entity.dart';
import 'package:quality_assurance_platform/core/common/domain/entities/test_entity.dart';
import 'package:quality_assurance_platform/core/failure/failure.dart';
import 'package:quality_assurance_platform/features/testes/data/interface/teste_datasource.dart';
import 'package:quality_assurance_platform/features/testes/domain/repository/teste_repository.dart';

class TesteRepositoryImp implements TesteRepository {
  final TesteDataSource testeDataSource;
  TesteRepositoryImp({required this.testeDataSource});
  @override
  Future<({Failure? failure, bool? success})> create({
    required TesteEntity testeEntity,
    required int idHistorico,
    required void Function(int, int)? onProgress,
  }) async {
    try {
      return (
        failure: null,
        success: await testeDataSource.create(
          testeEntity: testeEntity,
          idHistorico: idHistorico,
          onProgress: onProgress,
        )
      );
    } on Failure catch (e) {
      return (failure: e, success: null);
    }
  }

  @override
  Future<({Failure? failure, List<TesteDto>? testes})> getTestes({
    required int idHistorico,
    required void Function(int, int)? onProgress,
  }) async {
    try {
      return (
        failure: null,
        testes: await testeDataSource.getTestes(
          idHistorico: idHistorico,
          onProgress: onProgress,
        ),
      );
    } on Failure catch (e) {
      return (failure: e, testes: null);
    }
  }

  @override
  Future<({Failure? failure, bool? success})> updateTeste({
    required Map<String, dynamic> mapUpdate,
    required void Function(int, int)? onProgress,
  }) async {
    try {
      return (
        failure: null,
        success: await testeDataSource.updateTeste(
          mapUpdate: mapUpdate,
          onProgress: onProgress,
        ),
      );
    } on Failure catch (e) {
      return (failure: e, success: null);
    }
  }

  @override
  Future<({Failure? failure, bool? success})> deleteTicket({
    required int idTeste,
    required int idHistorico,
  }) async {
    try {
      return (
        failure: null,
        success: await testeDataSource.deleteTicket(
          idTeste: idTeste,
          idHistorico: idHistorico,
        )
      );
    } on Failure catch (e) {
      return (
        failure: e,
        success: null,
      );
    }
  }

  @override
  Future<({Uint8List? bytes, Failure? failure})> downloadArquivos({
    required int idTeste,
    required int idArquivo,
    required void Function(int, int)? onProgress,
  }) async {
    try {
      return (
        failure: null,
        bytes: await testeDataSource.downloadArquivos(
          idTeste: idTeste,
          idArquivo: idArquivo,
          onProgress: onProgress,
        )
      );
    } on Failure catch (e) {
      return (
        failure: e,
        bytes: null,
      );
    }
  }

  @override
  Future<({Failure? failure, bool? success})> uploadArquivos({
    required int idTeste,
    required List<ArquivoEntity> arquivos,
    required void Function(int, int)? onProgress,
  }) async {
    try {
      return (
        failure: null,
        success: await testeDataSource.uploadArquivos(
          idTeste: idTeste,
          arquivos: arquivos,
          onProgress: onProgress,
        )
      );
    } on Failure catch (e) {
      return (
        failure: e,
        success: null,
      );
    }
  }

  @override
  Future<({Failure? failure, bool? success})> deleteArquivo({
    required int idTeste,
    required int idArquivo,
  }) async {
    try {
      return (
        failure: null,
        success: await testeDataSource.deleteArquivo(
          idTeste: idTeste,
          idArquivo: idArquivo,
        )
      );
    } on Failure catch (e) {
      return (
        failure: e,
        success: null,
      );
    }
  }
}
