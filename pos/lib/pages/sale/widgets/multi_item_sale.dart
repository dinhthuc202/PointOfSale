import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/constants/controllers.dart';
import 'package:pos/controllers/sale_order_controller.dart';
import 'package:pos/models/sale_order.dart';
import 'package:pos/pages/sale/widgets/item_sale.dart';

class MultiItemSale extends StatefulWidget {
  const MultiItemSale({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MultiItemSaleState();
  }
}

class _MultiItemSaleState extends State<MultiItemSale> {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(key: saleOrderController.formKey,
          child: Expanded(
              child: GetBuilder(
            init: SaleOrderController(),
            builder: (controller) => SingleChildScrollView(
              child: ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(0),
                  itemCount: saleOrderController.itemSales.length,
                  itemBuilder: (_, index) {
                    return Stack(children: [
                      saleOrderController.itemSales[index],
                       Positioned(
                        top: 15,
                        left: 30,
                        child: Text(
                          "Item ${index + 1} ",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.orange),
                        ),
                      ),
                    ],);
                  }),
            ),
          )),
        ),
        InkWell(
          onTap: () {
            saleOrderController.onAdd();
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(10)),
              child: const Icon(Icons.add),
            ),
          ),
        ),
      ],
    );
  }
}
