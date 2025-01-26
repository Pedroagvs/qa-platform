import 'package:back_end/app/api/dto/arquivo_dto.dart';

class HistoricDto {
  int? id;
  final String creatorName;
  final String versionApp;
  final String featuresTestadas;
  final String dataCadastro;
  bool fechado;
  ArquivoDto? arquivoDto;
  int closedTickets;
  int openedTickets;
  HistoricDto({
    this.id,
    required this.creatorName,
    required this.versionApp,
    required this.featuresTestadas,
    required this.openedTickets,
    required this.closedTickets,
    required this.dataCadastro,
    required this.fechado,
    this.arquivoDto,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'criador': creatorName,
      'fonte': versionApp,
      'dataCadastro': dataCadastro,
      'descricao': featuresTestadas,
      'arquivo': arquivoDto?.toJson(),
      'testesAbertos': openedTickets,
      'testesFechados': closedTickets,
      'fechado': fechado,
    };
  }

  factory HistoricDto.fromJson(
    Map<String, dynamic> map,
  ) {
    return HistoricDto(
      id: map['id'] != null ? int.parse(map['id']) : null,
      creatorName: map['criador'] as String,
      dataCadastro: map['dataCadastro'] as String,
      versionApp: map['fonte'] as String,
      featuresTestadas: map['descricao'] as String,
      arquivoDto: map['idArquivo'] != null ? ArquivoDto.fromJson(map) : null,
      openedTickets: map['testesAbertos'] ?? 0,
      closedTickets: map['testesFechados'] ?? 0,
      fechado: map['fechado'] == '1',
    );
  }
}
