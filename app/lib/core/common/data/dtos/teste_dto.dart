import 'package:quality_assurance_platform/core/common/data/dtos/arquivo_dto.dart';
import 'package:quality_assurance_platform/core/common/domain/entities/test_entity.dart';

class TesteDto extends TesteEntity {
  TesteDto({
    required super.criador,
    required super.responsavel,
    required super.tagTeste,
    required super.feature,
    required super.situacaoTeste,
    required super.descricao,
    required super.passos,
    required super.files,
    required super.observacoes,
    required super.loginTeste,
    required super.senhaTeste,
    required super.id,
    required super.tester,
    required super.closed,
    required super.devolutiva,
    required super.resultadoEsperado,
  });

  factory TesteDto.fromJson(Map<String, dynamic> json) {
    return TesteDto(
      criador: json['criador'],
      responsavel: json['responsavel'],
      tagTeste: TesteEntity.setTagTeste(json['tag'] as String),
      feature: json['feature'],
      situacaoTeste: TesteEntity.setSituacao(json['situacao'] as String),
      descricao: json['descricao'],
      passos: json['passos'],
      files: json['arquivos'] != null
          ? (json['arquivos'] as List).map((e) => FileDto.fromJson(e)).toList()
          : [],
      observacoes: json['observacoes'],
      loginTeste: json['usuario'],
      senhaTeste: json['senha'],
      tester: json['tester'],
      closed: json['fechado'],
      devolutiva: json['devolutiva'],
      id: json['id'],
      resultadoEsperado: json['resultadoEsperado'] ?? '',
    );
  }
  factory TesteDto.empty() {
    return TesteDto(
      criador: '',
      devolutiva: '',
      responsavel: '',
      tagTeste: TagTeste.critico,
      feature: '',
      situacaoTeste: SituacaoTeste.pendente,
      descricao: '',
      passos: '',
      files: [],
      observacoes: '',
      loginTeste: '',
      resultadoEsperado: '',
      senhaTeste: '',
      tester: '',
      id: -1,
      closed: false,
    );
  }
}
