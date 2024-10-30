// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:quality_assurance_platform/core/common/domain/entities/arquivo_entity.dart';

class HistoricEntity {
  int? idHistorico;
  String creator;
  String source;
  String feature;
  String dataCadastro;
  int closedTickets;
  int openedTickets;
  bool closed;
  ArquivoEntity? arquivoEntity;
  HistoricEntity({
    required this.creator,
    required this.source,
    required this.feature,
    this.idHistorico,
    this.closed = false,
    this.openedTickets = 0,
    this.closedTickets = 0,
    required this.dataCadastro,
    this.arquivoEntity,
  });
}
