part of infra;

final regex = RegExp(r'\s+');

class MySQl implements Connection {
  late MySQLConnectionPool? _mySqlConnection;
  @override
  Future<void> close() async {
    if (_mySqlConnection != null) {
      await _mySqlConnection?.close();
    }
  }

  @override
  Future<List<Map<String, dynamic>>> query(
    String source, [
    Map<String, dynamic> params = const {},
  ]) async {
    try {
      final treatmentSource = source.replaceAll(regex, ' ').trim();
      log(treatmentSource);
      final map = <Map<String, dynamic>>[];
      await _mySqlConnection?.withConnection((conn) async {
        await conn.transactional((connn) async {
          final results = await connn.execute(treatmentSource, params);
          results.rows.map((e) => map.add(e.assoc())).toList();
          if (treatmentSource.contains('INSERT')) {
            map.add({'lastInsertID': results.lastInsertID.toInt()});
          }
        });
      });
      return map;
    } on MySQLServerException catch (e, s) {
      log(e.toString(), stackTrace: s);
      throw Failure(e.message, s);
    } on MySQLClientException catch (e, s) {
      log(e.toString(), stackTrace: s);
      throw Failure(e.message, s);
    }
  }

  @override
  Future<void> initConnection() async {
    _mySqlConnection = MySQLConnectionPool(
      host: Platform.environment['HOST'] ?? 'default_host',
      port: int.tryParse(Platform.environment['PORT'] ?? '3306') ?? 3306,
      userName: Platform.environment['USER'] ?? 'default_user',
      password: Platform.environment['PASSWORD'] ?? 'default_password',
      databaseName: Platform.environment['DB_NAME'] ?? 'default_db',
      maxConnections: 15,
    );
  }
}
