part of infra;

class TestDAO implements TestGateWay {
  final Connection connection;
  TestDAO({required this.connection});
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

      final criador = dados['criador'];
      final feature = dados['feature'];
      final tag = dados['tag'];
      final descricao = dados['descricao'];
      final passos = dados['passos'];
      final observacoes = dados['observacoes'];
      final usuario = dados['usuario'];
      final senha = dados['senha'];
      final situacao = dados['situacao'];
      final idHistorico = dados['idHistorico'];
      final resultadoEsperado = dados['resultadoEsperado'];

      final row = await connection.query('''
          INSERT INTO 
          tb_testes
          (criador, feature,tag,descricao,passos, observacoes, usuario, senha, situacao,resultadoEsperado,historico_testes_id)
          VALUES
          (:criador,:feature,:tag,:descricao,:passos,:observacoes,:usuario,:senha,:situacao,:resultadoEsperado,:historico_testes_id) 
          ''', {
        'criador': criador,
        'feature': feature,
        'tag': tag,
        'descricao': descricao,
        'passos': passos,
        'observacoes': observacoes,
        'usuario': usuario,
        'senha': senha,
        'situacao': situacao,
        'resultadoEsperado': resultadoEsperado,
        'historico_testes_id': idHistorico,
      });
      final int lastInsertID = row.first['lastInsertID'] ?? -1;

      if (arquivo.isEmpty) {
        return lastInsertID != -1;
      }
      var newRow = <Map<String, dynamic>>[];
      for (final entrie in arquivo.entries) {
        final nome = entrie.key;
        final bytes = entrie.value;
        newRow = await connection.query('''
          INSERT INTO
          tb_arquivos_teste
            (nome,bytes,testes_id)
          VALUES
            (:nome,:bytes,:id)
          ''', {
          'id': lastInsertID,
          'nome': nome,
          'bytes': bytes,
        });
      }
      return newRow.isNotEmpty;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<TestDto>> get({required RequestParams requestParams}) async {
    try {
      final idHistorico = requestParams.body?['idHistorico'] is String
          ? int.parse(requestParams.body?['idHistorico'])
          : requestParams.body?['idHistorico'];
      if (idHistorico == null) {
        throw FieldsIsEmpty();
      }
      final row = await connection.query('''
            SELECT
              t.id,
              t.criador,
              t.responsavel,
              t.tester,
              t.tag,
              t.feature,
              t.descricao,
              t.passos,
              t.observacoes,
              t.devolutiva,
              t.situacao,
              t.usuario,
              t.senha,
              t.dataCadastro,
              t.fechado,
              t.resultadoEsperado,
              GROUP_CONCAT(CONCAT(a.id, ':', a.nome) ORDER BY a.id SEPARATOR ', ') AS arquivos
            FROM  
              tb_testes t
            LEFT JOIN
              tb_arquivos_teste a
            ON 
              t.id = a.testes_id
            WHERE 
              historico_testes_id = :idHistorico 
            GROUP BY 
              t.id
            ORDER BY 
              t.dataCadastro DESC
            ''', {
        'idHistorico': idHistorico,
      });

      return row.map((e) => TestDto.fromJson(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> update({required RequestParams requestParams}) async {
    try {
      if (requestParams.body == null ||
          requestParams.body!['idTeste'] == null) {
        throw FieldsIsEmpty();
      }
      final idTeste = requestParams.body!['idTeste'];
      final mapUpdateTeste = <String, dynamic>{
        'idTeste': idTeste,
      };
      final listFieldsUpdate = <String>[];
      requestParams.body!.forEach((key, value) {
        if (key != 'idTeste') {
          listFieldsUpdate.add('$key = :$key,');
        }
        mapUpdateTeste.addEntries({key: value}.entries);
      });
      listFieldsUpdate.add(listFieldsUpdate.removeLast().replaceAll(',', ''));

      final row = await connection.query(
        '''
        UPDATE tb_testes 
        SET ${listFieldsUpdate.reduce((value, element) => '$value $element')}
        WHERE id = :idTeste
        ''',
        mapUpdateTeste,
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
    try {
      final idTeste = requestParams.body?['idTeste'] is String
          ? int.parse(requestParams.body?['idTeste'])
          : requestParams.body?['idTeste'];

      final idArquivo = requestParams.body?['idArquivo'] is String
          ? int.parse(requestParams.body?['idArquivo'])
          : requestParams.body?['idArquivo'];

      if (idArquivo == null || idTeste == null) {
        throw FieldsIsEmpty();
      }
      final row = await connection.query('''
          SELECT 
            bytes 
          FROM 
            tb_arquivos_teste 
          WHERE 
            testes_id = :idTeste 
          AND
            id = :idArquivo
          ''', {
        'idTeste': idTeste,
        'idArquivo': idArquivo,
      });

      final bytes =
          Uint8List.fromList(jsonDecode(row.first.values.first).cast<int>());
      return bytes;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> uploadFile({required RequestParams requestParams}) async {
    try {
      if (requestParams.body == null ||
          requestParams.body!.isEmpty ||
          requestParams.body!['formdata'] == null) {
        throw FieldsIsEmpty();
      }
      var formdata = <String, dynamic>{};
      var dados = <String, dynamic>{};
      var arquivos = <String, dynamic>{};
      if (requestParams.body?['formdata'] != null) {
        formdata = requestParams.body!['formdata'];
      }
      if (formdata.isNotEmpty) {
        dados = jsonDecode(formdata['dados']['dados']);
        arquivos = formdata['arquivos'];
      } else {
        dados = requestParams.body!;
      }

      var row = <Map<String, dynamic>>[];
      arquivos.forEach((nome, bytes) async {
        row = await connection.query('''
          INSERT INTO
          tb_arquivos_teste
            (nome,bytes,testes_id)
          VALUES
            (:nome,:bytes,:id)
          ''', {
          'id': dados['idTeste'],
          'nome': nome,
          'bytes': bytes,
        });
      });
      return row.isEmpty;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> deleteFile({required RequestParams requestParams}) async {
    final idTeste = requestParams.body?['idTeste'] is String
        ? int.parse(requestParams.body?['idTeste'])
        : requestParams.body?['idTeste'];
    final idArquivo = requestParams.body?['idArquivo'] is String
        ? int.parse(requestParams.body?['idArquivo'])
        : requestParams.body?['idArquivo'];

    if (idArquivo == null || idTeste == null) {
      throw FieldsIsEmpty();
    }

    try {
      final row = await connection.query(
        '''
         DELETE FROM
          tb_arquivos_teste 
         WHERE 
          testes_id = :idTeste 
         AND 
          id = :idArquivo
         ''',
        {
          'idTeste': idTeste,
          'idArquivo': idArquivo,
        },
      );

      return row.isEmpty;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> delete({required RequestParams requestParams}) async {
    final idHistorico = requestParams.body?['idHistorico'] is String
        ? int.parse(requestParams.body?['idHistorico'])
        : requestParams.body?['idHistorico'];
    final idTeste = requestParams.body?['idTeste'] is String
        ? int.parse(requestParams.body?['idTeste'])
        : requestParams.body?['idTeste'];
    if (idHistorico == null || idTeste == null) {
      throw FieldsIsEmpty();
    }
    try {
      final row = await connection.query(
        '''
        DELETE FROM
         tb_testes 
        WHERE 
          historico_testes_id = :idHistorico
        AND 
          id = :idTeste
        ''',
        {
          'idHistorico': idHistorico,
          'idTeste': idTeste,
        },
      );
      return row.isEmpty;
    } catch (e) {
      rethrow;
    }
  }
}
