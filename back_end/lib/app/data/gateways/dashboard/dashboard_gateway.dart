import 'package:back_end/app/api/api.dart';
import 'package:back_end/app/api/dto/dashboard_dto.dart';

abstract class DashboardGateway {
  Future<List<DashboardDto>> call({required RequestParams requestParams});
}
