import 'package:get/get.dart';
import 'package:juno_getx_base_project/core/base/base.dart';

class FavoriteController extends BaseController {
  final RxInt count = 0.obs;

  void increment() => count.value++;
}
