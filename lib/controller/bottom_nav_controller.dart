import 'package:get/get.dart';

class BottomNavController extends GetxController {
  int currentIndex = 0;

  changeScreen(int index) {
    currentIndex = index;
    update();
  }
}
