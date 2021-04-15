import 'package:get/state_manager.dart';
import 'package:input_store_app/features/output/api/output_api.dart';
import 'package:input_store_app/features/output/models/output.dart';

class EditOutputController extends GetxController {
  OutputAPI _outputAPI;

  Rx<Output> _output;
  Output get output => _output.value;
  set output(Output value) => _output.value = value; 

  RxDouble _addValue;
  double get addValue => _addValue.value;
  set addValue(double value) => _addValue.value = value;

  RxString _note;
  String get note => _note.value;
  set note(String note) => _note.value;


  @override
  void onInit() {
    super.onInit();
    _outputAPI = new OutputAPI();

    _output = new Output().obs;
    _addValue = 1.0.obs;
    _note = ''.obs;
  }

  @override
  void onReady() {
    super.onReady();
    _addValue.value = output.quantity;
  }


  void returnValue(double value) {
    _addValue.value = _addValue.value + value;
    if(_addValue.value > _output.value.quantity) {
      _addValue.value -=1;
    }else if(_addValue.value <= 0) {
      _addValue.value = 0;    
    }
  }

  void editValue(double value) {
    _addValue.value = value;
  }


  Future updateStock(int outputID, int storeID, int commodityID, 
  double quantity, double leftQuantity) async {    
    final updateStock = await _outputAPI.updateStock(outputID, storeID, commodityID, quantity, leftQuantity);

    if(updateStock['ok']) {
      return {
        'ok': true,
        'message': 'Se actualizó correctamente'
      };
    }else {
      return {
        'ok': false,
        'message': updateStock['message']
      };
    }
  }

}