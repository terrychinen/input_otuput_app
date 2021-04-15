import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:input_store_app/features/order/models/order/order.dart';
import 'package:input_store_app/features/commodity/models/commodity.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:input_store_app/features/order/widgets/edit_modal_sheet_widget.dart';
import 'package:input_store_app/features/order/models/order_detail/order_detail.dart';
import 'package:input_store_app/features/order/controllers/edit_order_detail_controller.dart';
import 'package:input_store_app/features/order/controllers/order_detail_error_controller.dart';
import 'package:input_store_app/features/order/widgets/edit_subtitle_commodity_list_widget.dart';



class EditOrderDetailListWidget extends StatelessWidget {
  @required final Order order;
  @required final int crossAxisCount;

  EditOrderDetailListWidget({
    this.order,
    this.crossAxisCount
  });

  @override
  Widget build(BuildContext context) {
    final OrderDetailErrorController orderErrorController = Get.find();

    return GetBuilder<EditOrderDetailController>(
      init: EditOrderDetailController(order: this.order),
      builder: (_) => Obx(() {
        if(_.loading) return Center(child: CircularProgressIndicator());
        return StaggeredGridView.countBuilder(
          crossAxisCount: this.crossAxisCount,
          physics: BouncingScrollPhysics(),
          itemCount: _.orderDetailList.length,
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
          staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
          itemBuilder: (context, index) {
            OrderDetail orderDetail = _.orderDetailList[index];
            List<Commodity> commodityList = orderDetail.commodityListSelected;

            return Column(
              children: [
                ListTile(
                  title: Text(
                    '${orderDetail.commodityName}',
                    style: TextStyle(fontSize: 18.0)
                  ),

                  leading: Text(
                    '${index + 1} -',
                    style: TextStyle(fontSize: 18.0)
                  ),

                  trailing: Text(
                    'X${orderDetail.quantity}',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold
                    )
                  ),

                  subtitle: EditSubTitleCommodityListWidget(
                    index: index,
                    commodityList: commodityList,
                  ),

                  onTap: () async {
                    String barcodeScanRes = 
                      await FlutterBarcodeScanner
                        .scanBarcode(
                          '#FFFFFF',
                          'Cancelar',
                          false,
                          ScanMode.QR
                        );

                    if(barcodeScanRes != '-1') {
                      var parseStoreCommodity = jsonDecode(barcodeScanRes);

                      int storeID = parseStoreCommodity['store_id'];
                      int commodityID = parseStoreCommodity['commodity_id'];

                      if(storeID != null && commodityID != null) {
                        await _.getCommodity(storeID, commodityID);

                        if(_.commodityList.length >= 1) {
                          var firstWordCommodityApi = _.commoditySelected.
                          commodityName.split(" ")[0];

                          var firstWordCommodityOrder = orderDetail.
                            commodityName.split(" ")[0];
                
                          if(firstWordCommodityApi == firstWordCommodityOrder) {
                            _.commodityExists = false;

                            if(commodityList == null) {
                              showMaterialModalBottomSheet(
                                context: context,
                                builder: (context) => EditModalSheetWidget(
                                  index: index,
                                    orderDetail: orderDetail
                                  )
                              );
                            }else {
                              for(int i=0; i< commodityList.length; i++) {
                                int commId1 = commodityList[i].commodityId;
                                int commId2 = _.commoditySelected.commodityId;

                                int storeId1 = commodityList[i].storeId;
                                int storeId2 = _.commoditySelected.storeId;
                                if(commId1 == commId2 || storeId1 == storeId2) {
                                  _.commodityExists = true;
                                }
                              }
                              
                              if(!_.commodityExists) {
                                showMaterialModalBottomSheet(
                                  context: context,
                                  builder: (context) => EditModalSheetWidget(
                                    index: index,
                                    orderDetail: orderDetail
                                  )
                                );
                              }else {
                                orderErrorController.icon = FontAwesomeIcons.
                                  exclamationCircle;
                                orderErrorController.iconColor = Colors.red;
                                orderErrorController.title = 'Error';
                                orderErrorController.description = 'Ya está '+
                                'agregado ${_.commoditySelected.commodityName}';
                                orderErrorController.isError = true;
                              }
                            }

                          }else {
                            orderErrorController.icon = FontAwesomeIcons.
                              exclamationCircle;
                            orderErrorController.iconColor = Colors.red;
                            orderErrorController.title = 'Error';
                            orderErrorController.description = 'No puede '+
                            'almacenar $firstWordCommodityApi en la sección ' +
                            'de $firstWordCommodityOrder';
                            orderErrorController.isError = true;
                          }

                        }else {
                          orderErrorController.icon = FontAwesomeIcons.exclamationCircle;
                          orderErrorController.iconColor = Colors.red;
                          orderErrorController.title = 'Error';
                          orderErrorController.description = 'La mercancía o'+ 
                          'el almacén no existe';                        
                          orderErrorController.isError = true;
                        }
                      }else {
                        orderErrorController.icon = FontAwesomeIcons
                          .exclamationCircle;
                        orderErrorController.iconColor = Colors.red;
                        orderErrorController.title = 'Error';
                        orderErrorController.description = 'El QR es inválido';                        
                        orderErrorController.isError = true;
                      }
                    }
                  }
                ),

                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Divider(color: Colors.black)
                )

              ],
            );
          },
        );
      }),
    );
  }
}