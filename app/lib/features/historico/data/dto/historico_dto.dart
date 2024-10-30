import 'package:intl/intl.dart';
import 'package:quality_assurance_platform/core/common/data/dtos/arquivo_dto.dart';
import 'package:quality_assurance_platform/core/common/domain/entities/historico_entity.dart';

class HistoricoDto extends HistoricEntity {
  HistoricoDto({
    required super.feature,
    required super.creator,
    required super.source,
    required super.idHistorico,
    required super.dataCadastro,
    required super.closedTickets,
    required super.openedTickets,
    required super.closed,
    super.arquivoEntity,
  });

  factory HistoricoDto.fromJson(
    Map<String, dynamic> json,
  ) {
    return HistoricoDto(
      creator: json['criador'] ?? '',
      feature: json['descricao'] ?? '',
      source: json['fonte'] ?? '',
      dataCadastro: json['dataCadastro'] != null
          ? DateFormat('dd/MM/yyyy').format(
              DateFormat('yyyy-MM-dd').parse(json['dataCadastro']),
            )
          : '',
      arquivoEntity:
          json['arquivo'] != null ? ArquivoDto.fromJson(json['arquivo']) : null,
      idHistorico: json['id'] ?? -1,
      openedTickets: json['testesAbertos'] ?? 0,
      closedTickets: json['testesFechados'] ?? 0,
      closed: json['fechado'] ?? false,
    );
  }
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'criador': super.creator,
      'descricao': super.feature,
      'fonte': super.source,
      'idHistorico': super.idHistorico,
    };
  }

  factory HistoricoDto.empty() {
    return HistoricoDto(
      feature: '',
      creator: '',
      source: '',
      idHistorico: null,
      dataCadastro: '',
      closedTickets: 0,
      closed: false,
      openedTickets: 0,
    );
  }
}
