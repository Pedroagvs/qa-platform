part of domain;

abstract class AplicacaoUseCase {
  Future<List<AplicacaoDto>> get();
  Future<bool> create({required RequestParams requestParams});
  Future<bool> delete({required RequestParams requestParams});
  Future<bool> update({required RequestParams requestParams});
}
