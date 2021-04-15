import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:input_store_app/features/output/models/output.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:input_store_app/features/output/widgets/modal_output_bottom_widget.dart';

class OutputListWidget extends StatelessWidget {
  @required final List<Output> outputList;
  @required final int crossAxisCount;

  OutputListWidget({
    this.outputList,
    this.crossAxisCount
  });

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      crossAxisCount: this.crossAxisCount,
      physics: BouncingScrollPhysics(),
      itemCount: this.outputList.length,
      itemBuilder: (_, index) {
        Output output = this.outputList[index];     
        return Card(          
          margin: EdgeInsets.only(top: 10, left: 10, right: 10),
          child: ListTile(
            title: Text(
              '${output.commodityName}',
              style: TextStyle(fontSize: 18.0)
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                textWidget('Fec. salida: ', output.outputDate),
                textWidget('Lote: ', output.note),
                textWidget('Entregado por: ', output.employeeGivesName),
                textWidget('Recibido por: ', output.employeeReceivesName),
              ]
            ),
            leading: Text(
              '${output.outputId} -',
              style: TextStyle(fontSize: 18.0)
            ),
            trailing: Container(
              margin: EdgeInsets.only(right: 20.0),
              child: Text(
                'x${output.quantity}',
                style: TextStyle(
                  fontWeight: FontWeight.bold
                )
              ),
            ),
            onTap: () {
              showMaterialModalBottomSheet(
                context: context,
                builder: (context) => EditOutputModalSheetWidget(output: output)
              );
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
          )
        )
      ],
    );
  }

}