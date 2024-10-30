import 'package:quality_assurance_platform/core/common/domain/entities/application_entity.dart';
import 'package:quality_assurance_platform/core/failure/failure.dart';

abstract class ApplicationUseCase {
  Future<({Failure? failure, List<ApplicationEntity>? aplications})>
      getAplications();
  Future<({Failure? failure, String? message})> createApplication({
    required String title,
    required String platform,
  });
  Future<({Failure? failure, String? message})> editApplication({
    required int idApplication,
    required String title,
    required String platform,
  });
  Future<({Failure? failure, String? message})> deleteApplication({
    required int idApplication,
  });
}
