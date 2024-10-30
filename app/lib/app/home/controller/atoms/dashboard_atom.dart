import 'package:asp/asp.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:quality_assurance_platform/app/home/controller/states/dashboard_state.dart';
import 'package:quality_assurance_platform/core/common/domain/entities/dashboard_entity.dart';
import 'package:quality_assurance_platform/features/home/domain/usecases/interface/dashboard_usecase.dart';

final dashboardUseCase = GetIt.I.get<DashboardUseCase>();
final statusDashbordAtom = atom<StatusDashbord>(StatusDashbord.initial);
final dashboardDataAtom = atom<List<DashboardEntity>>([]);
final initialDateAtom = atom<String>(
  DateFormat('yyyy-MM-dd')
      .format(DateTime.now().subtract(const Duration(days: 30))),
);
final finalDateAtom =
    atom<String>(DateFormat('yyyy-MM-dd').format(DateTime.now()));
final stateDahboard = selector((get) {
  return DashboardState(
    statusDashbord: get(statusDashbordAtom),
    dashboardData: get(dashboardDataAtom),
    initialDate: get(initialDateAtom),
    finalDate: get(finalDateAtom),
  );
});

final updateStatusDashboad = atomAction1<StatusDashbord>((set, newValue) {
  set(statusDashbordAtom, newValue);
});
final updateDashboardData = atomAction1<List<DashboardEntity>>((set, newValue) {
  set(dashboardDataAtom, newValue);
});
final updateFinalDate = atomAction1<String>((set, newValue) {
  set(finalDateAtom, newValue);
});

final updateInitialDate = atomAction1<String>((set, newValue) {
  set(initialDateAtom, newValue);
});

final getDashboard =
    atomAction2<String, String>((set, dataInicial, dataFinal) async {
  updateStatusDashboad(StatusDashbord.loading);
  final result =
      await dashboardUseCase(dataInicial: dataInicial, dataFinal: dataFinal);
  if (result.failure != null) {
    updateStatusDashboad(StatusDashbord.loading);
  } else if (result.dashboard != null) {
    updateDashboardData(result.dashboard!);
    updateStatusDashboad(StatusDashbord.loaded);
  }
});
