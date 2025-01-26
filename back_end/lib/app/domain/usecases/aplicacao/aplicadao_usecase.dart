part of domain;

abstract class AplicationUseCase {
  Future<List<AplicationDto>> get();
  Future<bool> create({required RequestParams requestParams});
  Future<bool> delete({required RequestParams requestParams});
  Future<bool> update({required RequestParams requestParams});
}
