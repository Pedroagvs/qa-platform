// ignore_for_file: lines_longer_than_80_chars

part of infra;

class RegisterDAO implements RegisterGateway {
  final Connection connection;
  RegisterDAO({required this.connection});
  @override
  @override
  Future<bool> call({
    required RequestParams requestParams,
  }) async {
    try {
      final nome = requestParams.body?['nome'];
      final email = requestParams.body?['email'];
      final senha = requestParams.body?['senha'];
      final cargo = requestParams.body?['cargo'];
      if (nome == null || email == null || cargo == null || senha == null) {
        throw FieldsIsEmpty();
      }
      final row = await connection.query('''
          INSERT INTO
            tb_user 
            (nome, email, cargo , senha)
          VALUES 
            (:nome, :email, :cargo , md5(:senha))
          ''', {
        'nome': nome,
        'email': email,
        'senha': senha,
        'cargo': cargo,
      });
      final idNewUser = row.first['lastInsertID'];
      if (idNewUser != null) {
        final newRow = await connection.query(
          '''
          INSERT INTO
          tb_usuarios_cargos
            (user_id,cargo_id)
          SELECT
            (SELECT id FROM tb_user WHERE id = :idNewUser) as user_id,
            (SELECT id FROM tb_cargos WHERE nome = :cargo) as cargo_id;
        ''',
          {
            'idNewUser': idNewUser,
            'cargo': cargo,
          },
        );
        return newRow.first['lastInsertID'] != null;
      }
      return false;
    } catch (e) {
      rethrow;
    }
  }
}
