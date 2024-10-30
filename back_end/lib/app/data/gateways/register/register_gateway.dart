part of data;

abstract class RegisterGateway {
  Future<bool> call({
    required RequestParams requestParams,
  });
}
