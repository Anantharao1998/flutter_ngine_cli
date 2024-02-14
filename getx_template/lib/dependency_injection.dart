import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:juno_getx_base_project/core/network/dio_client.dart';
import 'package:juno_getx_base_project/core/network/util/connection_checker.dart';
import 'package:juno_getx_base_project/core/services/services.dart';

Future<void> init() async {
  /// Here is where you put get_storage, hive, shared_pref initialization.
  /// or moor connection, or whatever that's async.
  await Get.putAsync(() => PackageInfoService().init(), permanent: true);
  await Get.putAsync(() => StorageService().init(), permanent: true);

  /// register [ConnectionChecker]
  Get.lazyPut<ConnectionChecker>(() => ConnectionCheckerImpl());

  Get.lazyPut<Dio>(() => Dio());

  /// register [DioClient]
  Get.lazyPut<DioClient>(
      () => DioClientImpl(dio: Get.find(), connectionChecker: Get.find()));
}
