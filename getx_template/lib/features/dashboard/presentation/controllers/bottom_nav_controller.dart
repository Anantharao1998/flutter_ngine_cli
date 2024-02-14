import 'package:get/get.dart';

class BottomNavController extends GetxController {
  final RxInt _selectedIndexController = 0.obs;

  void updateSelectedIndex(int index) => _selectedIndexController(index);

  int get selectedIndex => _selectedIndexController.value;
}
