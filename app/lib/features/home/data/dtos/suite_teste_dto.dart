import 'package:quality_assurance_platform/core/common/domain/entities/application_entity.dart';
import 'package:quality_assurance_platform/core/common/domain/entities/test_entity.dart';

class ApplicationDto extends ApplicationEntity {
  ApplicationDto({
    required super.title,
    required super.platform,
    required super.id,
  });

  factory ApplicationDto.fromJson(Map<String, dynamic> json) {
    return ApplicationDto(
      title: json['titulo'],
      platform: json['plataforma'].toString().contains('web')
          ? Platform.web
          : Platform.mobile,
      id: json['id'] ?? 0,
    );
  }

  factory ApplicationDto.empty() {
    return ApplicationDto(
      title: '',
      platform: Platform.mobile,
      id: 0,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'title': super.title,
      'plataforma': super.platform,
      'idAplicacao': super.id,
    };
  }
}
