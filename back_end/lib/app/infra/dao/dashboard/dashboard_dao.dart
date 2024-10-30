import 'package:back_end/app/api/api.dart';
import 'package:back_end/app/api/dto/dashboard_dto.dart';
import 'package:back_end/app/data/gateways/dashboard/dashboard_gateway.dart';
import 'package:back_end/app/domain/exceptions/dasboard/dashboard_exceptions.dart';
import 'package:back_end/app/infra/infra.dart';
import 'package:intl/intl.dart';

class DashboardDAO implements DashboardGateway {
  final Connection connection;
  DashboardDAO({
    required this.connection,
  });
  @override
  Future<List<DashboardDto>> call({
    required RequestParams requestParams,
  }) async {
    late var dataInicial = '';
    late var dataFinal = '';
    if (requestParams.body == null ||
        requestParams.body!['dataInicial'] == null ||
        requestParams.body!['dataFinal'] == null) {
      dataInicial = DateFormat('yyyy-MM-dd').format(DateTime.now());
      dataFinal = DateFormat('yyyy-MM-dd')
          .format(DateTime.now().add(const Duration(days: 30)));
    } else {
      dataInicial = requestParams.body!['dataInicial'] ?? '';
      dataFinal = requestParams.body!['dataFinal'] ?? '';
      final dI = DateTime.parse(dataInicial);
      final df = DateTime.parse(dataFinal);
      final result = df.compareTo(dI);
      if (result < 0) {
        throw DateInvalid();
      }
    }
    try {
      final row = await connection.query('''
        SELECT 
          COALESCE(UNIX_TIMESTAMP(h.dataCadastro), UNIX_TIMESTAMP(t.dataCadastro)) AS dataCadastro,
          COUNT(DISTINCT h.id) AS totalHistoricos,
          SUM(CASE WHEN h.fechado = 0 THEN 1 ELSE 0 END) AS historicosAbertos,
          SUM(CASE WHEN h.fechado = 1 THEN 1 ELSE 0 END) AS historicosFechados,
          MIN(a.titulo) AS aplicacao,
          COUNT(DISTINCT t.id) AS totalTestes,
          SUM(CASE WHEN t.fechado = 0 THEN 1 ELSE 0 END) AS testesAbertos,
          SUM(CASE WHEN t.fechado = 1 THEN 1 ELSE 0 END) AS testesFechados
        FROM 
            tb_aplicacao a
        LEFT JOIN 
            tb_historico h ON a.id = h.aplicacao_id
        LEFT JOIN 
            tb_testes t ON h.id = t.historico_testes_id
        WHERE 
            h.dataCadastro BETWEEN :dataInicial AND :dataFinal 
        GROUP BY 
            COALESCE(UNIX_TIMESTAMP(h.dataCadastro), UNIX_TIMESTAMP(t.dataCadastro))
        ORDER BY 
            dataCadastro;
        ''', {
        'dataInicial': dataInicial,
        'dataFinal': dataFinal,
      });
      return row.map(DashboardDto.fromJson).toList();
    } catch (e) {
      rethrow;
    }
  }
}
