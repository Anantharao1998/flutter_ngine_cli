import 'package:get_it/get_it.dart';
import 'package:juno_provider_base_project/features/dashboard/presentation/provider/bottom_nav_provider.dart';

void registerDashboardDeps(GetIt sl) {
  sl.registerFactory(() => BottomNavProvider());
}
