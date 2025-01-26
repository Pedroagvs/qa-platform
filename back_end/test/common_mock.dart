import 'package:back_end/app/infra/infra.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mysql_client/mysql_client.dart';

class MySQLMock extends Mock implements MySQl {
  @override
  Future<List<Map<String, dynamic>>> query(
    String source, [
    Map<String, dynamic> params = const {},
  ]) async {
    return [
      {'': ''},
    ];
  }
}

class MySQLConnectionPoolMock extends Mock implements MySQLConnectionPool {}

class MySQLConnectionMock extends Mock implements MySQLConnection {}
