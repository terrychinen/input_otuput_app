import 'package:get/state_manager.dart';
import 'package:input_store_app/features/commodity/api/commodity_api.dart';
import 'package:input_store_app/features/commodity/models/commodity.dart';

class CommodityController extends GetxController {
  CommodityAPI _commodityAPI;

  Rx<Commodity> _commodity;
  Commodity get commodity => _commodity.value;

  RxBool _isLoading;
  bool get isLoading => _isLoading.value;
  set isLoading(bool isLoading) => _isLoading.value = isLoading;

  @override
  void onInit() {     
    super.onInit();
    _commodityAPI = new CommodityAPI();
    _commodity = new Commodity().obs;
    _isLoading = false.obs;

  }

  @override
  void onReady() {      
    super.onReady();
  }

  Future<Map<String, dynamic>> getCommodity(int storeID, int commodityID) async {
    var getCommodity = await _commodityAPI.getCommodity(storeID, commodityID);
    
    if(getCommodity['commodity'] != null) {
      _commodity.value = getCommodity['commodity'];
      return {'ok': true, 'commodity': _commodity.value};      
    }else {
      return {'ok': false};
    }
  }


}