import 'package:quality_assurance_platform/core/common/domain/entities/application_entity.dart';
import 'package:quality_assurance_platform/core/failure/failure.dart';
import 'package:quality_assurance_platform/features/home/data/datasources/interface/aplicacoes_datasource.dart';
import 'package:quality_assurance_platform/features/home/domain/respositories/aplicacoes_repository.dart';

class ApplicationRepositoryImp implements ApplicationRepository {
  final ApplicationDataSource _aplicacaoDataSource;
  ApplicationRepositoryImp(this._aplicacaoDataSource);
  @override
  Future<({Failure? failure, String? message})> createApplication({
    required String title,
    required String platform,
  }) async {
    try {
      return (
        failure: null,
        message: await _aplicacaoDataSource.createApplication(
          title: title,
          platform: platform,
        )
      );
    } on Failure catch (e) {
      return (failure: e, message: null);
    }
  }

  @override
  Future<({List<ApplicationEntity>? aplications, Failure? failure})>
      getAplications() async {
    try {
      return (
        failure: null,
        aplications: await _aplicacaoDataSource.getAplications()
      );
    } on Failure catch (e) {
      return (failure: e, aplications: null);
    }
  }

  @override
  Future<({Failure? failure, String? message})> deleteApplication({
    required int idApplication,
  }) async {
    try {
      return (
        failure: null,
        message: await _aplicacaoDataSource.deleteApplication(
          idApplication: idApplication,
        )
      );
    } on Failure catch (e) {
      return (failure: e, message: null);
    }
  }

  @override
  Future<({Failure? failure, String? message})> editApplication({
    required int idApplication,
    required String title,
    required String platform,
  }) async {
    try {
      return (
        failure: null,
        message: await _aplicacaoDataSource.editApplication(
          idApplication: idApplication,
          title: title,
          platform: platform,
        )
      );
    } on Failure catch (e) {
      return (failure: e, message: null);
    }
  }
}
