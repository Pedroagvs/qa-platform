part of data;

abstract class AplicacaoGateway {
  Future<List<AplicacaoDto>> get();
  Future<bool> create({required RequestParams requestParams});
  Future<bool> delete({required RequestParams requestParams});
  Future<bool> update({required RequestParams requestParams});
  Future<bool> checkExistsApplication({required RequestParams requestParams});
}
