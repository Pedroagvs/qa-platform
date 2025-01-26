import 'package:back_end/app/api/dto/arquivo_dto.dart';

class TestDto {
  int? id;
  String criador;
  String responsavel;
  String tester;
  Tag tag;
  String feature;
  Situacao situacao;
  String descricao;
  String passos;
  List<ArquivoDto> arquivos;
  String observacoes;
  String usuario;
  String senha;
  String devolutiva;
  String resultadoEsperado;
  bool fechado;
  TestDto({
    this.id,
    required this.criador,
    required this.responsavel,
    required this.tester,
    required this.tag,
    required this.feature,
    required this.situacao,
    required this.descricao,
    required this.passos,
    required this.arquivos,
    required this.observacoes,
    required this.usuario,
    required this.senha,
    required this.devolutiva,
    required this.fechado,
    required this.resultadoEsperado,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'criador': criador,
      'responsavel': responsavel,
      'tester': tester,
      'tag': setTag(tag),
      'feature': feature,
      'situacao': setSituacao(situacao),
      'descricao': descricao,
      'passos': passos,
      'arquivos': arquivos.map((e) => e.toJson()).toList(),
      'observacoes': observacoes,
      'usuario': usuario,
      'senha': senha,
      'devolutiva': devolutiva,
      'fechado': fechado,
      'resultadoEsperado': resultadoEsperado,
    };
  }

  factory TestDto.fromJson(Map<String, dynamic> map) {
    return TestDto(
      id: map['id'] != null ? int.parse(map['id'] as String) : null,
      criador: map['criador'] ?? '',
      responsavel: map['responsavel'] ?? '',
      tester: map['tester'] ?? '',
      tag: map['tag'] != null ? getTag(map['tag']) : Tag.melhoria,
      feature: map['feature'] ?? '',
      situacao: map['situacao'] != null
          ? getSituacao(map['situacao'])
          : Situacao.pendente,
      descricao: map['descricao'] ?? '',
      passos: map['passos'] ?? '',
      resultadoEsperado: map['resultadoEsperado'] ?? '',
      arquivos: map['arquivos'] != null
          ? (map['arquivos'].toString().split(',') as List).map((e) {
              final result = e.toString().split(':');
              return ArquivoDto.fromJson(
                {'idArquivo': result.first, 'nome': result.last},
              );
            }).toList()
          : [],
      observacoes: map['observacoes'] ?? '',
      usuario: map['usuario'] ?? '',
      senha: map['senha'] ?? '',
      devolutiva: map['devolutiva'] ?? '',
      fechado: map['fechado'] == '1',
    );
  }
}

Tag getTag(String tagTeste) {
  final mapTag = <String, Tag>{
    'Crítico': Tag.critico,
    'Leve': Tag.leve,
    'Mediano': Tag.mediano,
    'Melhoria': Tag.melhoria,
  };
  return mapTag[tagTeste] ?? Tag.melhoria;
}

String setTag(Tag tag) {
  switch (tag) {
    case Tag.critico:
      return 'Crítico';
    case Tag.leve:
      return 'Leve';
    case Tag.mediano:
      return 'Mediano';
    case Tag.melhoria:
      return 'Melhoria';
  }
}

Situacao getSituacao(String statusTeste) {
  final mapStatus = <String, Situacao>{
    'Correção aplicada': Situacao.correcaoAplicada,
    'Em correção': Situacao.emCorrecao,
    'Não reproduzivel': Situacao.naoReproduzivel,
    'Pendente': Situacao.pendente,
    'Error no backend': Situacao.errorBack,
    'Finalizado': Situacao.finalizado,
    'Em code review': Situacao.emCodeReview,
    'Aguardando Publicação': Situacao.aguardandoPublicacao,
    'Retornou de teste': Situacao.retornouDeTeste,
  };
  return mapStatus[statusTeste] ?? Situacao.pendente;
}

String setSituacao(Situacao s) {
  switch (s) {
    case Situacao.correcaoAplicada:
      return 'Correção aplicada';
    case Situacao.emCorrecao:
      return 'Em correção';
    case Situacao.naoReproduzivel:
      return 'Não reproduzivel';
    case Situacao.pendente:
      return 'Pendente';
    case Situacao.errorBack:
      return 'Error no backend';
    case Situacao.finalizado:
      return 'Finalizado';
    case Situacao.emCodeReview:
      return 'Em code review';
    case Situacao.aguardandoPublicacao:
      return 'Aguardando Publicação';
    case Situacao.retornouDeTeste:
      return 'Retornou de teste';
  }
}

enum Situacao {
  emCorrecao,
  correcaoAplicada,
  pendente,
  naoReproduzivel,
  errorBack,
  finalizado,
  emCodeReview,
  aguardandoPublicacao,
  retornouDeTeste,
}

enum Tag {
  critico,
  melhoria,
  leve,
  mediano,
}
