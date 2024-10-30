import 'package:quality_assurance_platform/core/client/status_code.dart';
import 'package:quality_assurance_platform/core/client/uno_client.dart';
import 'package:quality_assurance_platform/core/common/data/dtos/dashboard_dto.dart';
import 'package:quality_assurance_platform/core/common/domain/entities/dashboard_entity.dart';
import 'package:quality_assurance_platform/core/failure/failure.dart';
import 'package:quality_assurance_platform/features/home/data/datasources/interface/dashboard_datasource.dart';

class DashboardDataSourceImp implements DashboardDataSource {
  final UnoClient unoClient;
  DashboardDataSourceImp({required this.unoClient});
  @override
  Future<List<DashboardEntity>> call({
    required String dataInicial,
    required String dataFinal,
  }) async {
    try {
      final response = await unoClient.get(
        path: '/dashboard',
        params: {
          'dataInicial': dataInicial,
          'dataFinal': dataFinal,
        },
      );
      switch (response.status) {
        case StatusCode.ok:
          if (response.data != null) {
            return (response.data as List)
                .map((d) => DashboardDto.fromJson(d))
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
    } catch (e, s) {
      throw Failure(errorMessage: e.toString(), stackTrace: s);
    }
  }
}
