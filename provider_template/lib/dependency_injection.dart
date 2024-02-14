import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:juno_provider_base_project/core/core.dart';
import 'package:juno_provider_base_project/features/dashboard/dashboard.dart';
import 'package:juno_provider_base_project/features/home/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/project_details/project_details.dart';

final locator = GetIt.instance;

Future<void> init() async {
  /// Here is where you put get_storage, hive, shared_pref initialization.
  /// or moor connection, or whatever that's async.

  /* services that will be accessible throughout the app,
    there's only ever one instance of it while the app is running.
    These services will be accessed by calling getIt<ServiceName>()
    */

  locator.registerLazySingletonAsync<SharedPreferences>(
    () => SharedPreferences.getInstance(),
  );
  await locator.isReady<SharedPreferences>();

  locator.registerLazySingleton(() => Dio());
  locator
      .registerLazySingleton<ConnectionChecker>(() => ConnectionCheckerImpl());
  locator.registerLazySingleton<DioClient>(
      () => DioClientImpl(connectionChecker: locator(), dio: locator()));

  locator.registerSingletonAsync<PackageInfoService>(() async {
    final configService = PackageInfoService();
    await configService.init();

    return configService;
  });

  locator.registerLazySingleton(
      () => StorageService(sharedPreferences: locator()));
  locator.registerLazySingleton(() => NavigationService());

  // register dashboard dependencies
  registerDashboardDeps(locator);
  registerHomeDeps(locator);
  registerProjectDetailsDeps(locator);

  return;
}
