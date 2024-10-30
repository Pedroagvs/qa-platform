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
    // _mySqlConnection = MySQLConnectionPool(
    //   host: const String.fromEnvironment(
    //     'host',
    //   ),
    //   port: const int.fromEnvironment('port'),
    //   userName: const String.fromEnvironment('user'),
    //   password: const String.fromEnvironment('password'),
    //   databaseName: const String.fromEnvironment('db_name'),
    //   maxConnections: 15,
    // );
    _mySqlConnection = MySQLConnectionPool(
      host: 'localhost',
      port: 3306,
      userName: 'primeQA',
      password: 'Prime@123',
      databaseName: 'qa_prime',
      maxConnections: 50,
    );
  }
}
