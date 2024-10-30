part of infra;

class UserDAO implements UserGateway {
  final Connection connection;
  UserDAO({required this.connection});
  @override
  Future<List<UserDto>> getAllUsers() async {
    try {
      final row = await connection.query(
        'SELECT id,nome FROM tb_user',
      );

      return row.map(UserDto.fromJsonLessInformation).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> getUserByEmail({required RequestParams requestParams}) async {
    final email = requestParams.body!['email'];
    try {
      final row = await connection.query(
        'SELECT email FROM tb_user WHERE email = :email',
        {
          'email': email,
        },
      );

      return row.isNotEmpty;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> setThumbnailUser({
    required RequestParams requestParams,
  }) async {
    if (requestParams.body == null || requestParams.body!.isEmpty) {
      throw FieldsIsEmpty();
    }
    var formdata = <String, dynamic>{};
    var dados = <String, dynamic>{};
    var arquivo = <String, dynamic>{};
    if (requestParams.body?['formdata'] != null) {
      formdata = requestParams.body!['formdata'];
    }
    if (formdata.isNotEmpty) {
      dados = jsonDecode(formdata['dados']['dados']);
      arquivo = formdata['arquivos'];
    }

    try {
      final row = await connection.query(
        'UPDATE tb_user SET thumbnail = :thumbnail WHERE id = :idUser',
        {
          'thumbnail': arquivo.values.first,
          'idUser': dados['idUser'],
        },
      );

      return row.isEmpty;
    } catch (e) {
      rethrow;
    }
  }
}
