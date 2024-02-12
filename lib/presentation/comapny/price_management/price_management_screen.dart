import 'package:flutter/material.dart';
import 'package:unibus/core/utils/state_renderer/state_renderer_impl.dart';
import 'package:unibus/presentation/comapny/price_management/model/price.dart';
import 'package:unibus/widgets/drawer/comapnyDrawer.dart';

import '../../../core/app_export.dart';
import 'controller/price_controller.dart';

class PriceManagementScreen extends StatelessWidget {
  final PriceController priceController = Get.put(PriceController());
  final TextEditingController districtController = TextEditingController();
  final TextEditingController priceTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CompanyDrawer(),
      appBar: AppBar(
        title: Text('Price Management'),
        actions: [
          Image.asset(ImageConstant.imgLogo, width: 50.0,),
        ]
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [

            SizedBox(height: 20.0),
            Expanded(child: Obx(() =>
            priceController.state.value.getScreenWidget( _buildPriceList(), (){

            })
            )),
          ],
        ),
      ),
      floatingActionButton:FloatingActionButton(onPressed: (){
        Get.dialog(
          _buildAddPriceField(),
        );
      },
      child: Icon(Icons.add)) ,
    );
  }

  Widget _buildAddPriceField() {
    return AlertDialog(
      content: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: districtController,
              decoration: InputDecoration(labelText: 'District Name',),
            ),
            SizedBox(height: 10.0),
            TextFormField(
              controller: priceTextController,
              decoration: InputDecoration(labelText: 'Monthly Price'),
              keyboardType: TextInputType.number,
            ),

          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _addPrice,
          child: Text('Add'),
        ),
        TextButton(
          onPressed: (){
            Get.back();
          },
          child: Text('cancel'),
        )
      ],
    );
  }
  Widget _buildEditPriceField(index, district, price) {
    districtController.text = district;
    priceTextController.text = price.toString();
    return AlertDialog(
      content: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: districtController,
              decoration: InputDecoration(labelText: 'District Name',),
            ),
            SizedBox(height: 10.0),
            TextFormField(
              controller: priceTextController,
              decoration: InputDecoration(labelText: 'Monthly Price'),
              keyboardType: TextInputType.number,
            ),

          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: (){
            _editPrice(index, district, price);
          },
          child: Text('Edit'),
        ),
        TextButton(
          onPressed: (){
            Get.back();
          },
          child: Text('cancel'),
        )
      ],
    );
  }
  Widget _buildPriceList() {
    return ListView.builder(
      itemCount: priceController.districtPrices.length,
      itemBuilder: (context, index) {
        var district = priceController.districtPrices[index].district;
        var price = priceController.districtPrices[index].price;
        return Column(
          children: [
            ListTile(
              title: Text(district,style: TextStyle(color: theme.primaryColor),),
              subtitle: Text('\$$price'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Get.dialog(
                          _buildEditPriceField(index, district, price)
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _deletePrice(index),
                  ),
                ],
              ),
            ),
            Divider()
          ],
        );
      },
    );
  }

  void _addPrice() {
    String district = districtController.text.trim();
    double price = double.tryParse(priceTextController.text) ?? 0.0;

    if (district.isNotEmpty && price > 0) {
      priceController.addPrice(Price(price, district));
      districtController.clear();
      priceTextController.clear();
    }
    Get.back();
  }

  void _editPrice(int index,String district, double price) {
    if (district.isNotEmpty && price > 0) {
      priceController.editPrice(index,Price(price, district));
      districtController.clear();
      priceTextController.clear();
      Get.back();
    }
  }

  void _deletePrice(int index) {
    priceController.deletePrice(index);
  }
}
