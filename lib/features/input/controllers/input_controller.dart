import 'package:intl/intl.dart';
import 'package:get/state_manager.dart';
import 'package:input_store_app/features/input/api/input_api.dart';
import 'package:input_store_app/features/input/models/input/input.dart';
import 'package:input_store_app/features/input/models/inputDetail/input_detail.dart';


class InputController extends GetxController {
  InputAPI _inputAPI;

  RxList<Input> _inputList;
  RxList<Input> get inputList => _inputList;

  RxList<Input> _input;
  RxList<Input> get input => _input;

  RxList<InputDetail> _inputDetailList;
  RxList<InputDetail> get inputDetailList => _inputDetailList;
  
  RxBool _loading;
  bool get loading => _loading.value;
  
  Rx<DateTime> _datePicked;
  DateTime get datePicked => _datePicked.value;
  set datePicked(DateTime datePicked) => _datePicked.value = datePicked;

  @override
  void onInit() {      
    super.onInit();
    _loading = true.obs;
    _inputAPI = new InputAPI();
    _inputList = <Input>[].obs;
    _input = <Input>[].obs;
    _inputDetailList = <InputDetail>[].obs;
  }

  @override
  void onReady() async {
    super.onReady();
    final DateTime now = new DateTime.now();
    final DateFormat format = DateFormat('yyyy-MM-dd');
    final DateTime dateFormat = DateTime.parse(format.format(now));
    
    loadInputDetails(format.format(now));
    
    _datePicked = dateFormat.obs; 
    _loading.value = false;
  }


  Future loadInputs(String inputDate) async {
    final getInputs = await _inputAPI.getInputs(inputDate);
    if(getInputs['ok']) {
      if(getInputs['result'].length != 0){
        _inputList.clear();
        _inputList.addAll(getInputs['result']);
      }else {
        _inputList.clear();
      }
    }
  }

  Future loadInputDetails(String inputDate) async {
    final getInputsDetail = await _inputAPI.getInputDetailByDate(inputDate);

    if(getInputsDetail['ok']) {
      if(getInputsDetail['result'].length != 0) {
        _inputDetailList.clear();
        _inputDetailList.addAll(getInputsDetail['result']);
      }else {
        _inputDetailList.clear();
      }
    }
  }


  Future searchInput(int orderID) async {
    final getInputs = await _inputAPI.getInput(orderID);
    if(getInputs['ok']) {
      if(getInputs['result'].length != 0){
        _input.clear();
        _input.addAll(getInputs['result']);
      }else {
        _input.clear();
      }
    }
  }


  Future createInput(int orderID, int employeeID) async {
    final DateTime now = new DateTime.now();
    final DateFormat format = DateFormat('yyyy-MM-dd hh:mm:ss');

    await _inputAPI.createInput(orderID, employeeID, format.format(now));
  } 



  

}