import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:pos/constants/controllers.dart';
import 'package:pos/models/product.dart';
import 'package:pos/models/sale_order.dart';
import '../../../constants/style.dart';

class ItemSale extends StatefulWidget {
  ItemSale({super.key, required this.soDs, required this.onRemove});

  SODs soDs;
  final Function onRemove;

  @override
  State<ItemSale> createState() => _ItemSaleState();

  TextEditingController nameController = TextEditingController();
  TextEditingController salePriceController = TextEditingController();
  TextEditingController purchasePriceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();

  bool validate() {
    return nameController.text.isNotEmpty &&
        salePriceController.text.isNotEmpty &&
        purchasePriceController.text.isNotEmpty &&
        quantityController.text.isNotEmpty;
  }
}

class _ItemSaleState extends State<ItemSale> {
  late Product productSelect;
  final Color redColor = Colors.red;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width*0.8;
    //double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(
                        onPressed: () {
                          setState(() {
                            //Clear All forms Data
                            widget.soDs.productName = null;
                            widget.soDs.quantity = 0;
                            widget.soDs.salePrice = 0;
                            widget.soDs.purchasePrice = 0;
                            widget.nameController.clear();
                            widget.quantityController.clear();
                            widget.salePriceController.clear();
                            widget.purchasePriceController.clear();
                            saleOrderController.updateController();
                          });
                        },
                        child: const Text(
                          "Clear",
                          style: TextStyle(color: Colors.blue),
                        )),
                    TextButton(
                        onPressed: () => widget.onRemove(),
                        child: const Text(
                          "Remove",
                          style: TextStyle(color: Colors.blue),
                        )),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: width*0.25,
                  child: Stack(
                    children: [
                      SizedBox(
                        height: 35,
                        child: DropdownSearch<String>(
                          items: productController.products
                              .map((e) => e.name)
                              .toList(),
                          onChanged: (value) {
                            widget.nameController.text = value.toString();
                            widget.soDs.productName = value;
                            productSelect = (productController.products
                                .firstWhere(
                                    (element) => element.name == value));
                            widget.soDs.productId = productSelect.id;
                            widget.salePriceController.text = productSelect.salePrice.toString();
                            widget.soDs.salePrice = productSelect.salePrice;
                            widget.purchasePriceController.text = productSelect.purchasePrice.toString();
                            widget.soDs.purchasePrice = productSelect.purchasePrice;
                            saleOrderController.updateController();
                          },
                          popupProps: PopupProps.menu(
                            searchFieldProps: TextFieldProps(
                              autofocus: true,
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: const EdgeInsets.only(left: 5,top: 10,right: 5,bottom: 10),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7),
                                ),
                              ),
                            ),
                            showSearchBox: true,
                            constraints: const BoxConstraints(
                              maxHeight: 300,
                            ),
                            searchDelay: const Duration(microseconds: 50),
                          ),
                        ),
                      ),
                      IgnorePointer(
                        child: Container(
                          width: width*0.25-35,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          //child: Center(child: Text(widget.contactController.text,)),
                          child: Center(
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Vui lòng chọn';
                                }
                                return null;
                              },
                              controller: widget.nameController,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                              readOnly: true,
                              decoration: const InputDecoration(
                                labelText: "ProductName",
                                labelStyle: TextStyle(
                                  fontSize: 14,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(5),bottomLeft: Radius.circular(5)),
                                ),
                                isDense: true,
                                contentPadding: EdgeInsets.only(left: 5,top: 11,right: 5,bottom: 11),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: width*0.2,
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng điền đầy đủ thông tin';
                      }
                      return null;
                    },
                    onChanged: (value){
                      if(value == ""){
                        widget.soDs.quantity = 0;
                      }else{
                        widget.soDs.quantity = int.parse(value);
                      }
                      saleOrderController.updateController();
                    },
                    inputFormatters: inputFormattersDecimal,
                    controller: widget.quantityController,
                    style: const TextStyle(
                        fontSize: 14
                    ),
                    decoration: InputDecoration(
                      labelText: "Quantity",labelStyle: const TextStyle(
                      fontSize: 14,
                    ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      isDense: true,
                      contentPadding: const EdgeInsets.only(left: 5,top: 11,right: 5,bottom: 11),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: width*0.25,
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng điền đầy đủ thông tin';
                      }
                      return null;
                    },
                    inputFormatters: inputFormattersDecimal,
                    onChanged: (value){
                      if(value == ""){
                        widget.soDs.purchasePrice = 0.0;
                      }
                      else{
                        widget.soDs.purchasePrice = double.parse(value);
                      }
                      saleOrderController.updateController();
                    },
                    controller: widget.purchasePriceController,
                    style: const TextStyle(
                      fontSize: 14
                    ),
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.only(left: 5,top: 11,right: 5,bottom: 11),
                      labelText: "Purchase Price",
                      labelStyle: const TextStyle(
                        fontSize: 14,
                      ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                    ),
                  ),
                ),
                SizedBox(
                  width: width*0.25,
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng điền đầy đủ thông tin';
                      }
                      return null;
                    },
                    onChanged: (value){
                      if(value == ""){
                        widget.soDs.salePrice = 0.0;
                      }
                      else{
                        widget.soDs.salePrice = double.parse(value);
                      }                          saleOrderController.updateController();

                    },
                    inputFormatters: inputFormattersDecimal,
                    controller: widget.salePriceController,
                    style: const TextStyle(
                        fontSize: 14
                    ),
                    decoration: InputDecoration(
                      labelText: "Sale Price",
                      labelStyle: const TextStyle(
                        fontSize: 14,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      isDense: true,
                      contentPadding: const EdgeInsets.only(left: 5,top: 11,right: 5,bottom: 11),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
