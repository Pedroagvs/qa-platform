import 'package:quality_assurance_platform/core/client/client.dart';
import 'package:quality_assurance_platform/core/client/status_code.dart';
import 'package:quality_assurance_platform/core/common/domain/entities/application_entity.dart';
import 'package:quality_assurance_platform/core/failure/failure.dart';
import 'package:quality_assurance_platform/features/home/data/datasources/interface/aplicacoes_datasource.dart';
import 'package:quality_assurance_platform/features/home/data/dtos/suite_teste_dto.dart';

class ApplicationDataSourceImp implements ApplicationDataSource {
  final Client unoClient;
  ApplicationDataSourceImp({required this.unoClient});
  @override
  Future<String> createApplication({
    required String title,
    required String platform,
  }) async {
    try {
      final response = await unoClient.post(
        path: '/aplicacao',
        data: {
          'titulo': title,
          'plataforma': platform,
        },
      );
      switch (response.status) {
        case StatusCode.ok:
          if (response.data != null) {
            return response.data['mensagem'];
          } else {
            throw Failure();
          }
        case StatusCode.badRequest:
          throw Failure();
        case StatusCode.forbidden:
          throw Failure();
        case StatusCode.notFound:
          throw Failure();
        case StatusCode.internalError:
          throw Failure();
      }
      throw Failure();
    } on Failure {
      rethrow;
    } catch (e, s) {
      throw Failure(errorMessage: e.toString(), stackTrace: s);
    }
  }

  @override
  Future<List<ApplicationEntity>> getAplications() async {
    try {
      final response = await unoClient.get(
        path: '/aplicacao',
      );
      switch (response.status) {
        case StatusCode.ok:
          if (response.data != null) {
            return (response.data as List<dynamic>)
                .map((e) => ApplicationDto.fromJson(e))
                .toList();
          } else {
            throw Failure();
          }
        case StatusCode.badRequest:
          throw Failure();
        case StatusCode.forbidden:
          throw Failure();
        case StatusCode.notFound:
          throw Failure();
        case StatusCode.internalError:
          throw Failure();
      }
      throw Failure();
    } on Failure {
      rethrow;
    } catch (e, s) {
      throw Failure(errorMessage: e.toString(), stackTrace: s);
    }
  }

  @override
  Future<String> deleteApplication({required int idApplication}) async {
    try {
      final response = await unoClient.delete(
        path: '/aplicacao',
        data: {
          'idAplicacao': idApplication,
        },
      );
      switch (response.status) {
        case StatusCode.ok:
          if (response.data != null) {
            return response.data['mensagem'];
          } else {
            throw Failure();
          }
        case StatusCode.badRequest:
          throw Failure();
        case StatusCode.forbidden:
          throw Failure();
        case StatusCode.notFound:
          throw Failure();
        case StatusCode.internalError:
          throw Failure();
      }
      throw Failure();
    } on Failure {
      rethrow;
    } catch (e, s) {
      throw Failure(errorMessage: e.toString(), stackTrace: s);
    }
  }

  @override
  Future<String> editApplication({
    required int idApplication,
    required String title,
    required String platform,
  }) async {
    try {
      final response = await unoClient.put(
        path: '/aplicacao',
        data: {
          'idAplicacao': idApplication,
          'titulo': title,
          'plataforma': platform,
        },
      );
      switch (response.status) {
        case StatusCode.ok:
          if (response.data != null) {
            return response.data['mensagem'];
          } else {
            throw Failure();
          }
        case StatusCode.badRequest:
          throw Failure();
        case StatusCode.forbidden:
          throw Failure();
        case StatusCode.notFound:
          throw Failure();
        case StatusCode.internalError:
          throw Failure();
      }
      throw Failure();
    } on Failure {
      rethrow;
    } catch (e, s) {
      throw Failure(errorMessage: e.toString(), stackTrace: s);
    }
  }
}
