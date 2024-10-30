import 'package:flutter/foundation.dart';
import 'package:quality_assurance_platform/core/common/data/dtos/teste_dto.dart';
import 'package:quality_assurance_platform/core/common/domain/entities/arquivo_entity.dart';
import 'package:quality_assurance_platform/core/common/domain/entities/test_entity.dart';
import 'package:quality_assurance_platform/core/failure/failure.dart';
import 'package:quality_assurance_platform/features/testes/domain/repository/teste_repository.dart';
import 'package:quality_assurance_platform/features/testes/domain/usecase/interface/teste_usecase.dart';

class TesteUseCaseImp implements TesteUseCase {
  final TesteRepository testeRepository;
  TesteUseCaseImp({required this.testeRepository});
  @override
  Future<({Failure? failure, bool? success})> create({
    required TesteEntity testeEntity,
    required int idHistorico,
    required void Function(int, int)? onProgress,
  }) async =>
      testeRepository.create(
        testeEntity: testeEntity,
        idHistorico: idHistorico,
        onProgress: onProgress,
      );

  @override
  Future<({Failure? failure, List<TesteDto>? testes})> getTestes({
    required int idHistorico,
    required void Function(int, int)? onProgress,
  }) async =>
      testeRepository.getTestes(
        idHistorico: idHistorico,
        onProgress: onProgress,
      );

  @override
  Future<({Failure? failure, bool? success})> updateTeste({
    required Map<String, dynamic> mapUpdate,
    required void Function(int, int)? onProgress,
  }) async =>
      testeRepository.updateTeste(
        mapUpdate: mapUpdate,
        onProgress: onProgress,
      );

  @override
  Future<({Failure? failure, bool? success})> deleteTicket({
    required int idTeste,
    required int idHistorico,
  }) async =>
      testeRepository.deleteTicket(idTeste: idTeste, idHistorico: idHistorico);

  @override
  Future<({Uint8List? bytes, Failure? failure})> downloadArquivos({
    required int idTeste,
    required int idArquivo,
    required void Function(int, int)? onProgress,
  }) async =>
      testeRepository.downloadArquivos(
        idTeste: idTeste,
        idArquivo: idArquivo,
        onProgress: onProgress,
      );

  @override
  Future<({Failure? failure, bool? success})> uploadArquivos({
    required int idTeste,
    required List<ArquivoEntity> arquivos,
    required void Function(int, int)? onProgress,
  }) async =>
      testeRepository.uploadArquivos(
        idTeste: idTeste,
        arquivos: arquivos,
        onProgress: onProgress,
      );

  @override
  Future<({Failure? failure, bool? success})> deleteArquivo({
    required int idTeste,
    required int idArquivo,
  }) =>
      testeRepository.deleteArquivo(idTeste: idTeste, idArquivo: idArquivo);
}
