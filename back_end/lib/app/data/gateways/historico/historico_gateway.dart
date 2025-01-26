part of data;

abstract class HistoricGateway {
  Future<List<HistoricDto>> get({
    required RequestParams requestParams,
  });

  Future<bool> create({required RequestParams requestParams});

  Future<bool> delete({required RequestParams requestParams});

  Future<bool> update({required RequestParams requestParams});

  Future<bool> deleteFile({required RequestParams requestParams});

  Future<List<Map<String, dynamic>>> countTickets({
    required RequestParams requestParams,
  });

  Future<Uint8List> downloadFile({
    required RequestParams requestParams,
  });
  Future<bool> uploadFile({
    required RequestParams requestParams,
  });
}
