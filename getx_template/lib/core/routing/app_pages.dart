import 'package:get/get.dart';
import 'package:juno_getx_base_project/features/dashboard/dashboard.dart';
import 'package:juno_getx_base_project/features/favourite/favourite.dart';
import 'package:juno_getx_base_project/features/home/home.dart';
import 'package:juno_getx_base_project/features/project_details/project_details.dart';
import 'package:juno_getx_base_project/features/settings/settings.dart';

import 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.main;

  static final routes = [
    GetPage(
        name: Routes.main,
        page: () => DashboardView(),
        binding: DashboardBinding()),
    GetPage(name: Routes.home, page: () => HomeView(), binding: HomeBinding()),
    GetPage(
        name: Routes.favourite,
        page: () => FavoriteView(),
        binding: FavoriteBinding()),
    GetPage(
        name: Routes.settings,
        page: () => SettingsView(),
        binding: SettingsBinding()),
    GetPage(
        name: Routes.projectDetails,
        page: () => ProjectDetailsView(),
        binding: ProjectDetailsBinding()),
  ];
}
