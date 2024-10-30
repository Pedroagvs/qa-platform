import 'package:quality_assurance_platform/core/common/domain/entities/application_entity.dart';
import 'package:quality_assurance_platform/core/failure/failure.dart';
import 'package:quality_assurance_platform/features/home/domain/respositories/aplicacoes_repository.dart';
import 'package:quality_assurance_platform/features/home/domain/usecases/interface/aplicacoes_usecase.dart';

class ApplicationUseCaseImp implements ApplicationUseCase {
  final ApplicationRepository _aplicacaoRepository;
  ApplicationUseCaseImp(this._aplicacaoRepository);
  @override
  Future<({Failure? failure, String? message})> createApplication({
    required String title,
    required String platform,
  }) async =>
      _aplicacaoRepository.createApplication(
        title: title,
        platform: platform,
      );

  @override
  Future<({Failure? failure, List<ApplicationEntity>? aplications})>
      getAplications() async => _aplicacaoRepository.getAplications();

  @override
  Future<({Failure? failure, String? message})> deleteApplication({
    required int idApplication,
  }) async =>
      _aplicacaoRepository.deleteApplication(idApplication: idApplication);

  @override
  Future<({Failure? failure, String? message})> editApplication({
    required int idApplication,
    required String title,
    required String platform,
  }) async =>
      _aplicacaoRepository.editApplication(
        idApplication: idApplication,
        title: title,
        platform: platform,
      );
}
