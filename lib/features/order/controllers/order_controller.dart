import 'package:get/state_manager.dart';
import 'package:input_store_app/features/order/api/order_api.dart';
import 'package:input_store_app/features/order/models/order/order.dart';

class OrderController extends GetxController {
  OrderAPI _orderAPI;

  RxList<Order> _orderList;
  List<Order> get orderList => _orderList;

  RxBool _loading;
  bool get loading => _loading.value;
  set loading(bool value) => _loading.value = value;
  
  Rx<DateTime> _datePicked;
  DateTime get datePicked => _datePicked.value;
  set datePicked(DateTime datePicked) => _datePicked.value = datePicked;

  @override
  void onInit() {
    super.onInit();
    _orderAPI = new OrderAPI();
    _orderList = <Order>[].obs;

    _loading = true.obs;
  }

  @override
  void onReady() async {
    super.onReady();
    await loadOrders();
    _loading.value = false;
  }

  Future loadOrders() async {
    final getOrders = await _orderAPI.getOrders();

    if(getOrders['ok']) {
      if(getOrders['result'].length != 0) {
        _orderList.clear();
        _orderList.addAll(getOrders['result']);
      }else {
        _orderList.clear();
      }
    }
  }
}