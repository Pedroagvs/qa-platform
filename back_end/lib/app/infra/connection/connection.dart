part of infra;

abstract class Connection {
  Future<List<Map<String, dynamic>>> query(
    String source, [
    Map<String, dynamic> params,
  ]);
  Future<void> close();
  Future<void> initConnection();
}
