import 'package:get/state_manager.dart';

class HomeController extends GetxController {
  RxInt _currentIndex;
  int get currentIndex => _currentIndex.value;
  set currentIndex(int index) => _currentIndex.value = index;

  RxString _message;
  String get message => _message.value;
  set message(String message) => _message.value = message;

  RxBool _isError;
  bool get isError => _isError.value;
  set isError(bool load) => _isError.value = load;


  @override
  void onInit() {      
    super.onInit();
    _currentIndex = 0.obs;
    _message = ''.obs;
    _isError = false.obs;
  }
}