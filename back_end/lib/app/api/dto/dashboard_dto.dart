import 'dart:convert';

class DashboardDto {
  String aplicacao;
  Map<int, Map<String, int>> data;

  DashboardDto({
    required this.aplicacao,
    required this.data,
  });

  factory DashboardDto.fromJson(Map<String, dynamic> json) {
    return DashboardDto(
      aplicacao: json['aplicacao'] ?? '',
      data: {
        int.tryParse(json['dataCadastro'] ?? '0') ?? 0: {
          'totalHistoricos': int.tryParse(json['totalHistoricos'] ?? '0') ?? 0,
          'testesFechados': int.tryParse(json['testesFechados'] ?? '0') ?? 0,
          'testesAbertos': int.tryParse(json['testesAbertos'] ?? '0') ?? 0,
          'historicoAbertos':
              int.tryParse(json['historicoAbertos'] ?? '0') ?? 0,
          'historicoFechados':
              int.tryParse(json['historicoFechados'] ?? '0') ?? 0,
        },
      },
    );
  }
  Map<String, dynamic> toJson() {
    final jsonData = <String, String>{};
    data.forEach((k, v) {
      jsonData.addAll({k.toString(): jsonEncode(v)});
    });
    return {
      'aplicacao': aplicacao,
      'data': jsonData,
    };
  }
}
