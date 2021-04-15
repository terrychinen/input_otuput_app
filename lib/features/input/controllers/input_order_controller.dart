import 'package:get/state_manager.dart';
import 'package:input_store_app/features/input/api/input_api.dart';
import 'package:input_store_app/features/input/models/input/input.dart';
import 'package:intl/intl.dart';

class InputOrderController extends GetxController {
  InputAPI _inputAPI;

  RxBool _loading;
  bool get loading => _loading.value;
  set loading(bool value) => _loading.value = value;

  Rx<DateTime> _datePicked;
  DateTime get datePicked => _datePicked.value;
  set datePicked(DateTime value) => _datePicked.value = value;

  RxList<Input> _inputList;
  RxList<Input> get inputList => _inputList;

  @override
  void onInit() {
    super.onInit();
    _inputAPI = new InputAPI();

    _loading = false.obs;
    _inputList = <Input>[].obs;
     _datePicked = new DateTime(1, 1, 1).obs;
  }

  @override
  void onReady() async {
    _loading.value = true;
    final DateTime now = new DateTime.now();
    final DateFormat format = DateFormat('yyyy-MM-dd');
    final DateTime dateFormat = DateTime.parse(format.format(now));

    
    await loadInputs(format.format(now));

    _datePicked.value = dateFormat;
    _loading.value = false;
  }

  Future loadInputs(String inputDate) async {
    final getInputs = await _inputAPI.getInputs(inputDate);
    if(getInputs['ok']) {
      if(getInputs['result'].length != 0) {
        _inputList.clear();
        _inputList.addAll(getInputs['result']);
      }else {
        _inputList.clear();
      }
    }
  }
}