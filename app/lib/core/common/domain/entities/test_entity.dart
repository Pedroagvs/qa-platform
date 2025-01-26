import 'package:flutter/material.dart';
import 'package:quality_assurance_platform/core/common/data/dtos/arquivo_dto.dart';

class TesteEntity {
  int id;
  String criador;
  String responsavel;
  String tester;
  TagTeste tagTeste;
  String feature;
  SituacaoTeste situacaoTeste;
  String descricao;
  String passos;
  List<FileDto> files;
  String observacoes;
  String loginTeste;
  String senhaTeste;
  String resultadoEsperado;
  String devolutiva;
  bool closed;
  TesteEntity({
    required this.criador,
    required this.responsavel,
    required this.resultadoEsperado,
    required this.tagTeste,
    required this.feature,
    required this.situacaoTeste,
    required this.descricao,
    required this.passos,
    required this.files,
    required this.observacoes,
    required this.loginTeste,
    required this.senhaTeste,
    required this.tester,
    required this.id,
    required this.devolutiva,
    required this.closed,
  });

  static String getSituacao(SituacaoTeste situacaoTeste) {
    final mapStatus = <SituacaoTeste, String>{
      SituacaoTeste.correcaoAplicada: 'Correção aplicada',
      SituacaoTeste.emCorrecao: 'Em correção',
      SituacaoTeste.naoReproduzivel: 'Não reproduzível',
      SituacaoTeste.pendente: 'Pendente',
      SituacaoTeste.errorBack: 'Error no backend',
      SituacaoTeste.finalizado: 'Finalizado',
      SituacaoTeste.emCodeReview: 'Em code review',
      SituacaoTeste.retornouDeTeste: 'Retornou de teste',
      SituacaoTeste.aguardandoPublicacao: 'Aguardando publicação',
      SituacaoTeste.todos: 'Todos',
    };
    return mapStatus[situacaoTeste] ?? 'Todos';
  }

  static SituacaoTeste setSituacao(String situacaoTeste) {
    final mapStatus = <String, SituacaoTeste>{
      'Pendente': SituacaoTeste.pendente,
      'Em correção': SituacaoTeste.emCorrecao,
      'Não reproduzível': SituacaoTeste.naoReproduzivel,
      'Error no backend': SituacaoTeste.errorBack,
      'Em code review': SituacaoTeste.emCodeReview,
      'Retornou de teste': SituacaoTeste.retornouDeTeste,
      'Correção aplicada': SituacaoTeste.correcaoAplicada,
      'Aguardando publicação': SituacaoTeste.aguardandoPublicacao,
      'Finalizado': SituacaoTeste.finalizado,
      'Todos': SituacaoTeste.todos,
    };
    return mapStatus[situacaoTeste] ?? SituacaoTeste.todos;
  }

  static String getTagTeste(TagTeste tagTeste) {
    final mapTag = <TagTeste, String>{
      TagTeste.critico: 'Crítico',
      TagTeste.leve: 'Leve',
      TagTeste.mediano: 'Mediano',
      TagTeste.melhoria: 'Melhoria',
    };
    return mapTag[tagTeste] ?? 'Melhoria';
  }

  static TagTeste setTagTeste(String tagTeste) {
    final mapTag = <String, TagTeste>{
      'Crítico': TagTeste.critico,
      'Leve': TagTeste.leve,
      'Mediano': TagTeste.mediano,
      'Melhoria': TagTeste.melhoria,
    };
    return mapTag[tagTeste] ?? TagTeste.melhoria;
  }

  static Color getColorTagTeste(TagTeste tagTeste) {
    switch (tagTeste) {
      case TagTeste.critico:
        return Colors.red;
      case TagTeste.leve:
        return Colors.blue;
      case TagTeste.mediano:
        return Colors.orange;
      case TagTeste.melhoria:
        return Colors.green;
    }
  }

  static Color? getColorSituacaoTeste(SituacaoTeste situacaoTeste) {
    switch (situacaoTeste) {
      case SituacaoTeste.aguardandoPublicacao:
        return Colors.amber;
      case SituacaoTeste.emCodeReview:
        return Colors.deepPurple;
      case SituacaoTeste.emCorrecao:
        return Colors.red;
      case SituacaoTeste.errorBack:
        return Colors.blue;
      case SituacaoTeste.finalizado:
        return Colors.green;
      case SituacaoTeste.correcaoAplicada:
        return Colors.pink;
      case SituacaoTeste.pendente:
        return Colors.orange;
      case SituacaoTeste.naoReproduzivel:
        return Colors.purple;
      case SituacaoTeste.retornouDeTeste:
        return Colors.cyan;
      case SituacaoTeste.todos:
        return Colors.transparent;
    }
  }
}

enum SituacaoTeste {
  emCorrecao,
  correcaoAplicada,
  pendente,
  naoReproduzivel,
  errorBack,
  finalizado,
  emCodeReview,
  retornouDeTeste,
  aguardandoPublicacao,
  todos,
}

enum TagTeste {
  critico,
  melhoria,
  leve,
  mediano,
}

enum Platform {
  mobile,
  web,
}
