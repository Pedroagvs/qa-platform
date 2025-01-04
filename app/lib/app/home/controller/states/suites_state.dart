import 'package:quality_assurance_platform/core/common/domain/entities/application_entity.dart';

class ApplicationState {
  final ApplicationStatus applicationStatus;
  final List<ApplicationEntity> aplications;
  final bool showForm;
  final bool isEdit;
  final ApplicationEntity application;
  const ApplicationState({
    this.isEdit = false,
    this.showForm = false,
    this.applicationStatus = ApplicationStatus.initial,
    required this.application,
    this.aplications = const [],
  });
}

enum ApplicationStatus {
  initial,
  loading,
  failureGet,
  failureCreate,
  failureDelete,
  successCreate,
  successDelete,
  failureEdit,
  successEdit,
  successGet,
}
