import 'package:get/get.dart';
import 'package:juno_getx_base_project/features/favourite/favourite.dart';

class FavoriteBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FavoriteController>(() => FavoriteController());
  }
}
