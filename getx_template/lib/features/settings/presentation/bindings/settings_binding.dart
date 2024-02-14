import 'package:get/get.dart';
import 'package:juno_getx_base_project/features/settings/settings.dart';

class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingsController>(() => SettingsController());
  }
}
