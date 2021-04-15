import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:input_store_app/features/input/api/input_api.dart';
import 'package:intl/intl.dart';

class OrderDetailErrorController extends GetxController {
  InputAPI _inputAPI;

  RxString _note;
  String get note => _note.value;
  set note(String value) => _note.value = value;


  
  RxString _title;
  String get title => _title.value;
  set title(String value) => _title.value = value;

  Rx<IconData> _icon;
  IconData get icon => _icon.value;
  set icon(IconData value) => _icon.value = value;

  Rx<Color> _iconColor;
  Color get iconColor => _iconColor.value;
  set iconColor(Color value) => _iconColor.value = value;

  RxString _description;
  String get description => _description.value;
  set description(String value) => _description.value = value;

  RxBool _isError;
  bool get isError => _isError.value;
  set isError(bool value) => _isError.value = value;

  RxBool _isEnd;
  bool get isEnd => _isEnd.value;
  set isEnd(bool value) => _isEnd.value = value;

  RxBool _isLoading;
  bool get isLoading => _isLoading.value;
  set isLoading(bool isLoading) => _isLoading.value = isLoading;

  @override
  void onInit() {
    super.onInit();
    _inputAPI = new InputAPI();
    _note = ''.obs;

    _title = ''.obs;
    _icon = Icons.check.obs;
    _iconColor = Colors.black.obs;
    _description = ''.obs;
    _isError = false.obs;

    _isEnd = false.obs;

    _isLoading = false.obs; 
  }


  @override
  void onReady() async {
    super.onReady();
  }


  Future updateInput(int orderID, String note) async {
    _isLoading.value = true;
    final DateTime now = new DateTime.now();
    final DateFormat format = DateFormat('yyyy-MM-dd hh:mm:ss');
    
    final createInputDetail = await _inputAPI.updateInput(
      orderID, format.format(now), note
    );

     _isLoading.value = false;

    if(createInputDetail['ok']) {
      return {
        'ok': true, 
        'message': 'Se registró correctamente la base de datos'
      };
    } else {
      return {
        'ok': false, 
        'message': createInputDetail['message']
      };
    }
  }

}