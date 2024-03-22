import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/sale_order_controller.dart';
import '../../../models/sale_order.dart';

class FromItem extends StatefulWidget {
  FromItem(
      {super.key, required this.onRemove, required this.item});
  final SODs item;
  final Function onRemove;

  @override
  State<FromItem> createState() => _FromItemState();

  final TextEditingController _idController = TextEditingController();
  final TextEditingController _salePriceController = TextEditingController();
}

class _FromItemState extends State<FromItem> {
  final formKey = GlobalKey<FormState>();
  SaleOrderController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
        child: Form(
          key: formKey,
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
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  //Clear All forms Data
                                  widget.item.productId = 0;
                                  widget.item.salePrice = 0;
                                  widget._idController.clear();
                                  widget._salePriceController.clear();
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
                    ),
                  ],
                ),
                TextFormField(
                  controller: widget._idController,
                  onChanged: (value) =>widget.item.productId = int.parse(value),
                  validator: (value) => value!.length > 3 ? null : "Enter Name",
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 12),
                    border: OutlineInputBorder(),
                    hintText: "Enter Name",
                    labelText: "Product Name",
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: widget._salePriceController,
                  onChanged: (value) {
                        if(value.isNotEmpty){
                          widget.item.salePrice = double.parse(value);
                        }else{
                          widget.item.salePrice = 0.0;
                        }
                        controller.calcBillAmount();
                        print(controller.billAmount);
                  },
                  validator: (value) =>
                  value!.length > 3 ? null : "Number is Not Valid",
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 12),
                    border: OutlineInputBorder(),
                    hintText: "Enter Number",
                    labelText: "Number",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool validate() {
    //Validate Form Fields
    bool validate = formKey.currentState!.validate();
    if (validate) formKey.currentState!.save();
    return validate;
  }
}
