import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:input_store_app/features/output/models/output.dart';
import 'package:input_store_app/features/output/api/output_api.dart';
import 'package:input_store_app/features/commodity/models/commodity.dart';
import 'package:input_store_app/features/commodity/api/commodity_api.dart';

class OutputController extends GetxController {
  OutputAPI _outputAPI;
  CommodityAPI _commodityAPI;

  RxList<Output> _outputList;
  RxList<Output> get outputList => _outputList;

  RxList<Commodity> _commodityList;
  RxList<Commodity> get commodityList => _commodityList;   

  RxBool _createLoading;
  bool get createLoading => _createLoading.value;

  RxBool _loading;
  bool get loading => _loading.value;
  set loading(bool value) => _loading.value = value;
  
  Rx<DateTime> _datePicked;
  DateTime get datePicked => _datePicked.value;
  set datePicked(DateTime datePicked) => _datePicked.value = datePicked;

  RxDouble _addValue;
  double get addValue => _addValue.value;
  set addValue(double value) => _addValue.value = value;

  RxString _note;
  String get note => _note.value;
  set note(String note) => _note.value = note;



/*====================== Custom AlertDialog ======================*/
  RxString _title;
  String get title => _title.value;
  set title(String value) => _title.value = value;

  Rx<IconData> _icon;
  IconData get icon => _icon.value;
  set icon(IconData value) => _icon.value = value;

  Rx<Color> _colorIcon;
  Color get colorIcon => _colorIcon.value;
  set colorIcon(Color value) => _colorIcon.value = value;

  RxBool _isMessage;
  bool get isMessage => _isMessage.value;
  set isMessage(bool value) => _isMessage.value = value;

  RxString _message;
  String get message => _message.value;
  set message(String value) => _message.value = value;

  /*==============================================================*/

  @override
  void onInit() {      
    super.onInit();
    _outputAPI = new OutputAPI();
    _commodityAPI = new CommodityAPI();
   
    _outputList = <Output>[].obs;
    _commodityList = <Commodity>[].obs;     
    
    _loading = true.obs;
    _createLoading = false.obs;

    _addValue = 1.0.obs;
    _note = ''.obs;
    
    _title = ''.obs;
    _icon = Icons.check.obs;
    _colorIcon = Colors.black.obs;
    _isMessage = false.obs;
    _message = ''.obs;
  }

  @override
  void onReady() async {
    super.onReady();
    final DateTime now = new DateTime.now();
    final DateFormat format = DateFormat('yyyy-MM-dd');
    final DateTime dateFormat = DateTime.parse(format.format(now));
    _datePicked = dateFormat.obs;   

    await loadOutputs(format.format(now), 0, 1);
    _loading.value = false;
  }

  @override
  void onClose() {
    super.onClose();
    _outputList.close();
  }

  Future loadOutputs(String dateOutput, int offset, int state) async {    
    final getOutputs = await 
      _outputAPI.getOutputs(dateOutput, offset, state);

    if(getOutputs['ok']) {
      if(getOutputs['result'].length != 0) {
        _outputList.clear();
        _outputList.addAll(getOutputs['result']);
      }else {
        _outputList.clear();
      }
    }
  }


  Future checkIfStoreAndCommodityExist(int storeID, int commodityID) async {
    final checkStoreCommodity = await _commodityAPI
      .checkIfStoreAndCommodityExists(storeID, commodityID);

     if(checkStoreCommodity['ok']) {
      if(checkStoreCommodity['result'].length != 0) {
        _commodityList.clear();
        _commodityList.addAll(checkStoreCommodity['result']);
      }
    }
  }


  void returnValue(double value) {
    _addValue = _addValue + value;
    if(_addValue <= 0) {
      _addValue +=1;
    }

    if(_addValue > _commodityList[0].stock) {
      _addValue -= 1;
    }
  }


  Future createOutput(int storeID, 
    int commodityID, String note, double quantity, 
    int employeeGives, int employeeReceives, 
    int environmentID) async {

    this._createLoading.value = true;

    if(quantity != null || quantity != 0.0) {
      final DateTime now = new DateTime.now();
      final DateFormat format = DateFormat('yyyy-MM-dd hh:mm:ss');

      final create = await _outputAPI.createOutput(storeID, 
        commodityID, note, quantity, employeeGives, 
        employeeReceives, format.format(now), environmentID, 1);

      this._createLoading.value = false;

      if(create['ok']) {
        this._title.value = 'Éxito';
        this._icon.value = FontAwesomeIcons.check;
        this._colorIcon.value = Colors.green;
        this._message.value = 'Se creó correctamente la salida';
        this._isMessage.value = true;
      }else{
        this._title.value = 'Error';
        this._icon.value = FontAwesomeIcons.exclamationCircle;
        this._colorIcon.value = Colors.red;
        this._message.value = create['message'];
        this._isMessage.value = true;
      }
    }else{
      this._title.value = 'Error';
      this._icon.value = FontAwesomeIcons.exclamationCircle;
      this._colorIcon.value = Colors.red;
      this._message.value = 'Ingrese la cantidad';
      this._isMessage.value = true;
    }
  }

}