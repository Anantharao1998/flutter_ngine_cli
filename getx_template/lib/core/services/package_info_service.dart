import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class PackageInfoService extends GetxService {
  late final PackageInfo packageInfo;

  Future<PackageInfoService> init() async {
    packageInfo = await PackageInfo.fromPlatform();

    return this;
  }

  String? get appName => packageInfo.appName;

  String? get packageName => packageInfo.packageName;

  String? get version => packageInfo.version;

  String? get buildNumber => packageInfo.buildNumber;
}
