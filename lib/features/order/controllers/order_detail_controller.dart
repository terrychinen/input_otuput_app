import 'package:get/state_manager.dart';
import 'package:input_store_app/features/input/api/input_api.dart';
import 'package:input_store_app/features/input/models/inputDetail/input_detail.dart';
import 'package:input_store_app/features/order/models/order/order.dart';
import 'package:input_store_app/features/commodity/models/commodity.dart';
import 'package:input_store_app/features/order/api/order_detail_api.dart';
import 'package:input_store_app/features/commodity/api/commodity_api.dart';
import 'package:input_store_app/features/order/models/order_detail/order_detail.dart';

class OrderDetailController extends GetxController {
  final int check;
  final Order order;

  OrderDetailController({
    this.check, 
    this.order
  });

  InputAPI _inputAPI;
  OrderDetailAPI _orderDetailAPI;
  CommodityAPI _commodityAPI;

  RxList<OrderDetail> _orderDetailList;
  RxList<OrderDetail> get orderDetailList => _orderDetailList;


  RxList<InputDetail> _inputDetailList;
  RxList<InputDetail> get inputDetailList => _inputDetailList;


  Rx<Commodity> _commoditySelected;
  Commodity get commoditySelected => _commoditySelected.value;
  set commoditySelected(Commodity value) => _commoditySelected.value = value;


  RxList<Commodity> _commodityList;
  RxList<Commodity> get commodityList => _commodityList;


  RxList<Commodity> _commoditySelectedList;
  RxList<Commodity> get commoditySelectedList => _commoditySelectedList;


  RxDouble _editCommodityValue;
  double get editCommodityValue => _editCommodityValue.value;
  set editCommodityValue(double value) => _editCommodityValue.value = value;


  Rx<OrderDetail> _orderDetail;
  OrderDetail get orderDetail => _orderDetail.value;
  set orderDetail(OrderDetail value) => _orderDetail.value = value;


  RxBool _commodityExists;
  bool get commodityExists => _commodityExists.value;
  set commodityExists(bool value) => _commodityExists.value = value;




  RxBool _loading;
  bool get loading => _loading.value;

  RxDouble _addValue;
  double get addValue => _addValue.value;
  set addValue(double value) => _addValue.value = value;

  RxBool _dismissModalSheet;
  bool get dismissModalSheet => _dismissModalSheet.value;
  set dismissModalSheet(bool value) => _dismissModalSheet.value = value;

  @override
  void onInit() {
    super.onInit();
    _inputAPI = new InputAPI();
    _orderDetailAPI = new OrderDetailAPI();

    _orderDetailList = <OrderDetail>[].obs;
    _commodityList = <Commodity>[].obs;
    _inputDetailList = <InputDetail>[].obs;

    _commodityAPI = new CommodityAPI();
    _commoditySelected = new Commodity().obs;

    _commoditySelectedList = <Commodity>[].obs;

    _loading = false.obs;
    _dismissModalSheet = false.obs;


    _orderDetail = new OrderDetail().obs;


    _addValue = 1.0.obs;

    _commodityExists = false.obs;

    _editCommodityValue = 0.0.obs;
  }


  @override
  void onReady() async {
    super.onReady();
    _loading.value = true;
    await loadOrderDetail(order.purchaseOrderId);
    await loadInputDetail(order.purchaseOrderId);
    _loading.value = false;
  }


  Future loadInputDetail(int orderID) async {
    final getInputDetail = await _inputAPI.
        getInputDetailByID(orderID);

    for(int x=0; x<_orderDetailList.length; x++) {
      OrderDetail orderDetail = _orderDetailList[x];
      orderDetail.commodityListSelected = <Commodity>[];
      _commoditySelectedList = <Commodity>[].obs;

      if(getInputDetail['ok']) {
        if(getInputDetail['result'].length != 0) {
          _inputDetailList.clear();
          _inputDetailList.addAll(getInputDetail['result']);

          for(int i=0; i<_inputDetailList.length; i++) {
            InputDetail inputDetail = _inputDetailList[i];

            Commodity commodity = new Commodity();
            commodity.commodityId = inputDetail.commodityId;
            commodity.commodityName = inputDetail.commodityName;
            commodity.storeId = inputDetail.storeId;
            commodity.storeName = inputDetail.storeName;
            commodity.stock = inputDetail.quantity;

            var commodityName1 = commodity.commodityName.split(" ")[0];
            var commodityName2 = orderDetail.commodityName.split(" ")[0];

            if(commodityName1 == commodityName2) {
              orderDetail.commodityListSelected.add(commodity);
              commoditySelectedList.add(commodity);
            }                      
          }     
        }
      }
    }   
  }


  Future loadOrderDetail(int orderID) async {
    final getOrderDetail = await _orderDetailAPI.getOrderDetail(orderID);

    if(getOrderDetail['ok']) {
      if(getOrderDetail['result'].length != 0) {
        _orderDetailList.clear();
        _orderDetailList.addAll(getOrderDetail['result']);
      }
    }
  }


  Future getCommodity(int storeID, int commodityID) async {
    var getCommodity = await _commodityAPI.getCommodity(storeID, commodityID);
    if(getCommodity['ok']) {
      if(getCommodity['result'].length != 0) {
        _commodityList.clear();
        _commodityList.addAll(getCommodity['result']);
        _commoditySelected.value = _commodityList[0];
      }
    }
  }


  Future createInputDetail(int orderID, int commodityID, int storeID, 
  double quantity) async {    

    final createInputDetail = await _inputAPI.createInputDetail(
      orderID, storeID, commodityID, quantity
    );

    if(createInputDetail['ok']) {
      return {
        'ok': true, 
        'message': 'Se registró correctamente en la base de datos'
      };
    } else {
      return {
        'ok': false, 
        'message': createInputDetail['message']
      };
    }
  }


  void addCommodity(int index) {
    _loading.value = true;
    
    _commoditySelected.value.stock = _addValue.value;
    _commoditySelectedList.add(_commoditySelected.value);
    _orderDetailList[index].commodityListSelected = <Commodity>[];
    _orderDetailList[index].commodityListSelected.addAll(_commoditySelectedList);
    
    _addValue.value = 1.0;
    _loading.value = false;
  }


  void editCommodity(int indexOriginal, int indexConvert) {
     _loading.value = true;
    
    _commoditySelected.value.stock = _addValue.value;
    _orderDetailList[indexOriginal].commodityListSelected[indexConvert].stock 
      = _commoditySelected.value.stock;
    
    _loading.value = false;
  }


  void returnValue(double value) {
    _addValue.value = _addValue.value + value;
    if(_addValue <= 0) {
      _addValue.value +=1;
    }
  }


  void editValue(double value) {
    _addValue.value = value;
  } 


  Future deleteCommodityOrderDetail(int indexOriginal, int indexConvert) async {
    _loading.value = true;
    OrderDetail orderDetail = _orderDetailList[indexOriginal];

    final deleteInput = await _inputAPI.deleteInputDetail(
      orderDetail.purchaseOrderId, 
      orderDetail.commodityListSelected[indexConvert].commodityId, 
      orderDetail.commodityListSelected[indexConvert].storeId
    );

    if(deleteInput['ok']) {
      _commoditySelectedList.clear();
      _commoditySelectedList.addAll(orderDetail.commodityListSelected);
      
      orderDetail.commodityListSelected.removeAt(indexConvert);
      _commoditySelectedList.removeAt(indexConvert);

      _addValue.value = 1.0;
      _loading.value = false; 

      return {
        'ok': true, 
        'message': 'Se eliminó correctamente en la base de datos'
      };
    }else {
      _addValue.value = 1.0;
      _loading.value = false; 

      return {
        'ok': true, 
        'message': deleteInput['message']
      };
    }
  
  }


}