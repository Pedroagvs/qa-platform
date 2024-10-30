// ignore_for_file: lines_longer_than_80_chars

part of infra;

class AplicacaoDAO implements AplicacaoGateway {
  final Connection connection;
  AplicacaoDAO({
    required this.connection,
  });
  @override
  Future<List<AplicacaoDto>> get({required RequestParams requestParams}) async {
    try {
      final row = await connection.query('''
            SELECT * FROM 
            tb_aplicacao 
            ORDER BY 
            dataCadastro 
            DESC
            ''');

      return row.map(AplicacaoDto.fromJson).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> create({required RequestParams requestParams}) async {
    try {
      final titulo = requestParams.body?['titulo'];
      final plataforma = requestParams.body?['plataforma'];
      if (titulo == null || plataforma == null) {
        throw FieldsIsEmpty();
      }
      final row = await connection.query(
        '''
        INSERT INTO 
          tb_aplicacao 
          (titulo,plataforma) 
        VALUES 
          (:titulo,:plataforma)
        ''',
        {
          'titulo': titulo,
          'plataforma': plataforma,
        },
      );

      return row.first['lastInsertID'] != null;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> delete({required RequestParams requestParams}) async {
    try {
      final idAplicacao = requestParams.body?['idAplicacao'] is String
          ? int.parse(requestParams.body?['idAplicacao'])
          : requestParams.body?['idAplicacao'];
      if (idAplicacao == null) {
        throw FieldsIsEmpty();
      }
      final row = await connection.query(
        'DELETE FROM tb_aplicacao WHERE id = :idAplicacao',
        {
          'idAplicacao': idAplicacao,
        },
      );
      return row.isEmpty;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> checkExistsApplication({
    required RequestParams requestParams,
  }) async {
    try {
      final titulo = requestParams.body?['titulo'];
      final plataforma = requestParams.body?['plataforma'];
      if (titulo == null || plataforma == null) {
        throw FieldsIsEmpty();
      }
      final row = await connection.query(
        'SELECT titulo FROM tb_aplicacao WHERE titulo = :titulo AND plataforma = :plataforma',
        {
          'titulo': titulo,
          'plataforma': plataforma,
        },
      );

      return row.isNotEmpty;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> update({required RequestParams requestParams}) async {
    try {
      if (requestParams.body == null ||
          requestParams.body!['idAplicacao'] == null) {
        throw FieldsIsEmpty();
      }
      final idAplicacao = requestParams.body!['idAplicacao'];
      final mapUpdateTeste = <String, dynamic>{
        'idAplicacao': idAplicacao,
      };
      final listFieldsUpdate = <String>[];
      requestParams.body!.forEach((key, value) {
        if (key != 'idAplicacao') {
          listFieldsUpdate.add('$key = :$key,');
        }
        mapUpdateTeste.addEntries({key: value}.entries);
      });
      listFieldsUpdate.add(listFieldsUpdate.removeLast().replaceAll(',', ''));

      final row = await connection.query(
        '''
        UPDATE tb_aplicacao 
        SET ${listFieldsUpdate.reduce((value, element) => '$value $element')}
        WHERE 
        id = :idAplicacao
         ''',
        mapUpdateTeste,
      );

      return row.isEmpty;
    } catch (e) {
      rethrow;
    }
  }
}
