import 'dart:convert';

import 'package:quality_assurance_platform/core/common/domain/entities/dashboard_entity.dart';

class DashboardDto extends DashboardEntity {
  DashboardDto({
    required super.aplicacao,
    required super.data,
  });

  factory DashboardDto.fromJson(Map<String, dynamic> json) {
    final result = <int, Map<String, int>>{};
    if (json['data'] != null) {
      (json['data'] as Map).forEach(
        (key, value) {
          final date = jsonDecode(key);
          final valores = jsonDecode(value) as Map;
          result.addAll({date: valores.cast<String, int>()});
        },
      );
    }

    return DashboardDto(
      aplicacao: json['aplicacao'] ?? '',
      data: result,
    );
  }
}
