import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:input_store_app/features/input/controllers/input_controller.dart';
import 'package:input_store_app/features/input/models/inputDetail/input_detail.dart';

class InputDetailListWidget extends StatelessWidget {
  @required final List<InputDetail> inputDetailList;
  @required final int crossAxisCount;

  InputDetailListWidget({
    this.inputDetailList,
    this.crossAxisCount
  });

  @override
  Widget build(BuildContext context) {
    InputController _ = Get.find();

    return StaggeredGridView.countBuilder(
      crossAxisCount: this.crossAxisCount,
      physics: BouncingScrollPhysics(),
      itemCount: this.inputDetailList.length,
      itemBuilder: (_, index) {
        InputDetail inputDetail = this.inputDetailList[index];     
        return Card(          
          margin: EdgeInsets.all(10),    
          child: ListTile(            
            title: Text(
              '${inputDetail.commodityName}',
              style: TextStyle(fontSize: 18.0)
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                textWidget('Fec. entrada: ', inputDetail.inputDate),
                SizedBox(height: 5),
                textWidget('Proveedor: ', inputDetail.providerName),
                 SizedBox(height: 5),
                textWidget('Almacén: ', inputDetail.storeName),
                SizedBox(height: 20),
              ]
            ),
            leading: Text(
              '${index + 1} -',
              style: TextStyle(fontSize: 18.0)
            ),
            trailing: Container(
              margin: EdgeInsets.only(right: 20.0),
              child: Text(
                'x${inputDetail.quantity}',
                style: TextStyle(fontWeight: FontWeight.bold)
              ),
            ),
            onTap: () {
              
            }
          ),
        );
      },    
      staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,  
    );
  }

  Widget textWidget(String text1, String text2) {
    return Row(
      children: [
         Text(text1),
         Expanded(
           child: Text(
            text2,
            style: TextStyle(
              color: Colors.black, 
              fontWeight: FontWeight.bold
            )
        ),
         )
      ],
    );
  }
}