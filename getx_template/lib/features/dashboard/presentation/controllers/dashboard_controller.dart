import 'package:get/get.dart';
import 'package:juno_getx_base_project/core/base/base.dart';
import 'package:juno_getx_base_project/features/dashboard/domain/entities/menu_code.dart';

class DashboardController extends BaseController {
  final Rx<MenuCode> _selectedMenuCodeController = MenuCode.home.obs;

  MenuCode get selectedMenuCode => _selectedMenuCodeController.value;

  final RxBool lifeCardUpdateController = false.obs;

  Future<void> onMenuSelected(MenuCode menuCode) async {
    _selectedMenuCodeController(menuCode);
  }
}
