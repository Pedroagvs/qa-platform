part of domain;

abstract class DashboardUseCase {
  Future<List<DashboardDto>> call({
    required RequestParams requestParams,
  });
}
