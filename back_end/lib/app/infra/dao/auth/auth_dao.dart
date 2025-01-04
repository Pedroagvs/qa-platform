// ignore_for_file: lines_longer_than_80_chars

part of infra;

class AuthDAO implements AuthGateway {
  final Connection connection;
  AuthDAO({
    required this.connection,
  });
  @override
  Future<UserDto> login({required RequestParams requestParams}) async {
    try {
      final email = requestParams.body?['email'];
      final senha = requestParams.body?['senha'];
      if (senha == null || email == null) {
        throw FieldsIsEmpty();
      }

      final row = await connection.query(
        '''
      SELECT u.nome, u.id, u.email, u.thumbnail, c.nome AS cargo, GROUP_CONCAT(f.nome SEPARATOR ',') AS funcionalidades
      FROM tb_user u
      JOIN tb_usuarios_cargos uc ON u.id = uc.user_id
      JOIN tb_cargos c ON uc.cargo_id = c.id
      JOIN tb_cargo_funcionalidades cf ON c.id = cf.cargo_id
      JOIN tb_funcionalidades f ON cf.funcionalidade_id = f.id
      WHERE u.email = :email AND u.senha = MD5(:senha)
      GROUP BY u.id, c.nome;
      ''',
        {
          'email': email,
          'senha': senha,
        },
      );
      if (row.isEmpty) {
        throw NotExistsThisUser();
      }

      return UserDto.fromJson(row.first);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> changePassword({required RequestParams requestParams}) async {
    final idUser = requestParams.body?['idUser'];
    final novaSenha = requestParams.body?['novaSenha'];
    final senha = requestParams.body?['novaSenha'];
    try {
      if (senha == null || idUser == null) {
        throw FieldsIsEmpty();
      }
      final row = await connection.query('''
        SELECT
          senha
        FROM
          tb_user
        WHERE 
          id = :idUser
        ''', {
        'idUser': idUser,
      });
      if (row.first.values.first ==
          md5.convert(utf8.encode(senha)).toString()) {
        final row = await connection.query(
          '''
        UPDATE tb_user 
        SET senha = md5(:novaSenha)
        WHERE id = :idUser
        ''',
          {
            'idUser': idUser,
            'novaSenha': novaSenha,
          },
        );
        return row.isEmpty;
      }
      return false;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> createAccount({required RequestParams requestParams}) async {
    try {
      final nome = requestParams.body?['nome'];
      final email = requestParams.body?['email'];
      final senha = requestParams.body?['senha'];
      final cargo = requestParams.body?['cargo'];
      if (nome == null || email == null || cargo == null || senha == null) {
        throw FieldsIsEmpty();
      }
      final row = await connection.query('''
          INSERT INTO tb_user (nome, email, senha, cargo)
          SELECT :nome, :email, :senha, :cargo
          WHERE NOT EXISTS (SELECT 1 FROM tb_user WHERE email = :email);
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
