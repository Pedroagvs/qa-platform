import 'package:quality_assurance_platform/core/common/domain/entities/test_entity.dart';

class ApplicationEntity {
  final int id;
  final String title;
  final Platform platform;
  ApplicationEntity({
    required this.title,
    required this.platform,
    required this.id,
  });

  ApplicationEntity copyWith({
    int? id,
    String? title,
    Platform? platform,
  }) {
    return ApplicationEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      platform: platform ?? this.platform,
    );
  }

  @override
  String toString() =>
      'ApplicationEntity(id: $id, title: $title, plataforma: $platform)';

  static Platform getPlatform(String p) {
    switch (p) {
      case 'mobile':
        return Platform.mobile;
      case 'web':
        return Platform.web;
      default:
        return Platform.mobile;
    }
  }
}
