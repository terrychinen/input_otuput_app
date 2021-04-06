import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class OrderDetailErrorController extends GetxController {
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

  @override
  void onInit() {
    super.onInit();
    _title = ''.obs;
    _icon = Icons.check.obs;
    _iconColor = Colors.black.obs;
    _description = ''.obs;
    _isError = false.obs;    
  }


  @override
  void onReady() async {
    super.onReady();
  }

}