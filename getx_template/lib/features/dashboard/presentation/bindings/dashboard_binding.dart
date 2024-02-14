import 'package:get/get.dart';
import 'package:juno_getx_base_project/features/dashboard/presentation/controllers/controllers.dart';
import 'package:juno_getx_base_project/features/favourite/favourite.dart';
import 'package:juno_getx_base_project/features/home/presentation/bindings/home_binding.dart';
import 'package:juno_getx_base_project/features/settings/settings.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController(), fenix: true);
    Get.lazyPut<BottomNavController>(() => BottomNavController(), fenix: true);
    HomeBinding().dependencies();
    FavoriteBinding().dependencies();
    SettingsBinding().dependencies();
  }
}
