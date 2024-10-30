import 'package:quality_assurance_platform/core/common/domain/entities/application_entity.dart';

abstract class ApplicationDataSource {
  Future<List<ApplicationEntity>> getAplications();
  Future<String> createApplication({
    required String title,
    required String platform,
  });
  Future<String> editApplication({
    required int idApplication,
    required String title,
    required String platform,
  });
  Future<String> deleteApplication({
    required int idApplication,
  });
}
