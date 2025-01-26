part of data;

abstract class AplicationGateway {
  Future<List<AplicationDto>> get();
  Future<bool> create({required RequestParams requestParams});
  Future<bool> delete({required RequestParams requestParams});
  Future<bool> update({required RequestParams requestParams});
  Future<bool> checkExistsApplication({required RequestParams requestParams});
}
