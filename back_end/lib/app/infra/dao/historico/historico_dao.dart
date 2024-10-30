part of infra;

class HistoricoDAO implements HistoricGateway {
  final Connection connection;
  HistoricoDAO({
    required this.connection,
  });
  @override
  Future<bool> create({required RequestParams requestParams}) async {
    try {
      var formdata = <String, dynamic>{};
      var dados = <String, dynamic>{};
      var arquivo = <String, dynamic>{};
      if (requestParams.body?['formdata'] != null) {
        formdata = requestParams.body!['formdata'];
      }
      if (formdata.isNotEmpty) {
        dados = jsonDecode(formdata['dados']['dados']);
        arquivo = formdata['arquivos'];
      } else {
        dados = requestParams.body!;
      }
      if (dados['idAplicacao'] == null ||
          dados['criador'] == null ||
          dados['descricao'] == null ||
          dados['fonte'] == null) {
        throw FieldsIsEmpty();
      }

      final criador = dados['criador'];
      final fonte = dados['fonte'];
      final descricao = dados['descricao'];
      final idAplicacao = dados['idAplicacao'] is String
          ? int.parse(dados['idAplicacao'] as String)
          : dados['idAplicacao'];

      final row = await connection.query('''
          INSERT INTO
           tb_historico 
           (criador,
           fonte,
           descricao,
           aplicacao_id
           )
            VALUES 
            (:criador,
            :fonte,
            :descricao,
            :idAplicacao
          )
            ''', {
        'criador': criador,
        'fonte': fonte,
        'descricao': descricao,
        'idAplicacao': idAplicacao,
      });
      final int lastInsertID = row.first['lastInsertID'] ?? -1;

      if (arquivo.isEmpty) {
        return lastInsertID != -1;
      }

      final nomeArquivo = arquivo.keys.first;
      final bytes = jsonDecode(arquivo.values.first);
      final newRow = await connection.query('''
            INSERT INTO 
            tb_arquivos_historicos
            (historico_id,
            bytes,
            nome
            )
            VALUES
            (:lastInsertID,
            :bytes,
            :nomeArquivo
            )
          ''', {
        'lastInsertID': lastInsertID,
        'bytes': bytes,
        'nomeArquivo': nomeArquivo,
      });
      return newRow.first['lastInsertID'] != null;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<HistoricoDto>> get({
    required RequestParams requestParams,
  }) async {
    final idAplicacao = requestParams.body?['idAplicacao'] is String
        ? int.tryParse(requestParams.body?['idAplicacao'] as String)
        : requestParams.body?['idAplicacao'];
    final offset = int.tryParse(requestParams.body?['offset']);
    if (offset == null || idAplicacao == null) {
      throw FieldsIsEmpty();
    }
    try {
      final row = await connection.query(
        '''
        SELECT 
          h.id,
          h.criador,
          h.fonte,
          h.descricao,
          h.dataCadastro,
          h.fechado,
          a.id as idArquivo, 
          a.nome 
      FROM 
          tb_historico h
     LEFT JOIN 
          tb_arquivos_historicos a
      ON 
          h.id = a.historico_id
      WHERE 
          h.aplicacao_id = :idAplicacao
      ORDER BY 
          h.dataCadastro DESC
      LIMIT 
          :limit 
      OFFSET 
          :offset;
        ''',
        {
          'idAplicacao': idAplicacao,
          'limit': 10,
          'offset': offset,
        },
      );
      return row.map(HistoricoDto.fromJson).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> delete({required RequestParams requestParams}) async {
    final idAplicacao = requestParams.body?['idAplicacao'] is String
        ? int.tryParse(requestParams.body?['idAplicacao'])
        : requestParams.body?['idAplicacao'];
    final idHistorico = requestParams.body?['idHistorico'] is String
        ? int.tryParse(requestParams.body?['idHistorico'])
        : requestParams.body?['idHistorico'];
    if (idHistorico == null || idAplicacao == null) {
      throw FieldsIsEmpty();
    }
    try {
      final row = await connection.query(
        '''
          DELETE FROM 
          tb_historico
          WHERE aplicacao_id = :idAplicacao 
          AND id = :idHistorico 
        ''',
        {
          'idAplicacao': idAplicacao,
          'idHistorico': idHistorico,
        },
      );
      return row.isEmpty;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> update({required RequestParams requestParams}) async {
    try {
      final idHistorico = requestParams.body?['idHistorico'];
      if (idHistorico == null || requestParams.body!.isEmpty) {
        throw FieldsIsEmpty();
      }
      final mapUpdateTeste = <String, dynamic>{
        'idHistorico': idHistorico,
      };
      final listFieldsUpdate = <String>[];
      requestParams.body!.forEach((key, value) {
        if (key != 'idHistorico') {
          listFieldsUpdate.add('$key = :$key,');
        }
        mapUpdateTeste.addEntries({key: value}.entries);
      });
      listFieldsUpdate.add(listFieldsUpdate.removeLast().replaceAll(',', ''));

      final row = await connection.query(
        '''
        UPDATE tb_historico 
        SET ${listFieldsUpdate.reduce((value, element) => '$value $element')}
        WHERE id = :idHistorico
        ''',
        mapUpdateTeste,
      );
      return row.isEmpty;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> deleteFile({required RequestParams requestParams}) async {
    final idHistorico = requestParams.body!['idHistorico'] is String
        ? int.parse(requestParams.body!['idHistorico'])
        : requestParams.body!['idHistorico'];
    try {
      final row = await connection.query(
        '''
        DELETE FROM 
        tb_arquivos_historicos  
        WHERE historico_id = :idHistorico
        ''',
        {
          'idHistorico': idHistorico,
        },
      );
      return row.isEmpty;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Uint8List> downloadFile({
    required RequestParams requestParams,
  }) async {
    final idHistorico = requestParams.body?['idHistorico'] is String
        ? int.parse(requestParams.body?['idHistorico'])
        : requestParams.body?['idHistorico'];
    final idArquivo = requestParams.body?['idArquivo'] is String
        ? int.parse(requestParams.body?['idArquivo'])
        : requestParams.body?['idArquivo'];
    if (idArquivo == null || idHistorico == null) {
      throw FieldsIsEmpty();
    }
    try {
      final row = await connection.query(
        '''
         SELECT 
            bytes 
         FROM 
            tb_arquivos_historicos
         WHERE 
            historico_id = :idHistorico
          AND
            id = :idArquivo
         ''',
        {
          'idHistorico': idHistorico,
          'idArquivo': idArquivo,
        },
      );
      final bytes =
          Uint8List.fromList(jsonDecode(row.first.values.first).cast<int>());
      return bytes;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> uploadFile({required RequestParams requestParams}) async {
    if (requestParams.body == null && requestParams.body?['formdata'] == null) {
      throw FieldsIsEmpty();
    }

    final formdata = jsonDecode(requestParams.body!['formdata']);
    final dados = formdata['dados'];
    final arquivo = formdata['arquivos'];
    final idHistorico = dados['idHistorico'] is String
        ? int.parse(dados['idHistorico']!)
        : dados['idHistorico'];

    final nome = arquivo.keys.first;
    final bytes = jsonDecode(arquivo.values.first);

    try {
      final row = await connection.query(
        '''
         INSERT INTO
         tb_arquivos_historicos
            (nome,
            bytes,
            historico_id) 
          VALUES (
            :nome,
            :bytes,
            :idHistorico)
          ''',
        {
          'idHistorico': idHistorico,
          'nome': nome,
          'bytes': bytes,
        },
      );
      return row.first['lastInsertID'] != null;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> countTickets({
    required RequestParams requestParams,
  }) async {
    final idHistorico = requestParams.body!['idHistorico'] is String
        ? int.parse(requestParams.body!['idHistorico'])
        : requestParams.body!['idHistorico'];

    try {
      final row = await connection.query('''
          SELECT CASE 
          WHEN fechado = 0 THEN :Abertos ELSE :Fechados END AS Status,
          COUNT(*) AS QtdTickets
            FROM  qa_prime.tb_testes
            WHERE historico_testes_id = :idHistorico 
            GROUP BY Status
          ''', {
        'idHistorico': idHistorico,
        'Abertos': 'Abertos',
        'Fechados': 'Fechados',
      });
      return row;
    } catch (e) {
      rethrow;
    }
  }
}
