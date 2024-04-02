import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pos/constants/controllers.dart';
import '../constants/apis.dart';
import '../models/customer.dart';
import '../models/sale_order.dart';
import '../pages/sale/widgets/item_sale.dart';
import '../pages/sale/widgets/widget_pay.dart';

class SaleOrderController extends GetxController {
  static SaleOrderController instance = Get.find();
  List<ItemSale> itemSales = List.empty(growable: true);
  Rx<double> billAmount = 0.0.obs;
  late List<Customer> customers;
  Image? qrPay;
  Rx<Customer> customerSelect = Rx<Customer>(Customer());
  final formKey = GlobalKey<FormState>();

  Future<void> getDataCustomer() async {
    customers = await APIs.getListCustomer();
    customers.insert(0, Customer(name: 'Khách hàng mới'));
  }

  changeCustomer(String customerName) {
    customerSelect.value = customers.firstWhere(
      (item) => item.name == customerName,
    );
  }

  onRemove(SODs soDs) {
    int index = itemSales.indexWhere((item) => item.soDs.flag == soDs.flag);
    itemSales.remove(itemSales[index]);
    updateController();
  }

  onAdd() {
    SODs soDs;
    if (itemSales.isEmpty) {
      soDs = SODs(flag: 0, quantity: 0);
    } else {
      soDs = SODs(flag: itemSales.last.soDs.flag! + 1, quantity: 0);
    }
    itemSales.add(ItemSale(
      onRemove: () => onRemove(soDs),
      soDs: soDs,
    ));
    updateController();
  }

  onSave(BuildContext context) async {
    bool allValid = true;
    for (var element in itemSales) {
      allValid = (allValid && element.validate());
    }
    if (allValid) {
      for (int i = 0; i < itemSales.length; i++) {
        Get.dialog(widgetPay(context));
      }
    } else {
      debugPrint("Form is Not Valid");
      Get.defaultDialog(
          title: "Vui lòng điền đầy đủ thông tin!",
          content: const Text("Vui lòng điền đầy đủ thông tin"));
    }
  }

  updateController() {
    calcAmount();
    update();
  }

  calcAmount() {
    double tmp = 0.0;
    for (var item in itemSales) {
      double salePrice =
          item.soDs.salePrice == null ? 0.0 : item.soDs.salePrice!;
      int quantity = item.soDs.quantity == null ? 0 : item.soDs.quantity!;
      tmp = tmp + salePrice * quantity;
    }
    billAmount.value = tmp;
  }

  reset() {
    saleOrderController.customerSelect = Rx<Customer>(Customer());
    itemSales = [];
    SODs soDs = SODs(flag: 0);
    itemSales.add(ItemSale(
      onRemove: () => onRemove(soDs),
      soDs: soDs,
    ));
    billAmount.value = 0.0;
  }

  Future<void> sentSaleOrder() async {
    SaleOrder saleOrder = SaleOrder(sODs: []);
    saleOrder.billAmount = billAmount.value;
    saleOrder.billPaid = billAmount.value;
    saleOrder.id = customerSelect.value.id.toString();
    for (var item in itemSales) {
      saleOrder.sODs!.add(item.soDs);
    }
    //   var response = await APIs.postSaleOrder(saleOrder);
    //   print(response.statusCode);
    //   if (response.statusCode == 200) {
    //     Get.back(closeOverlays: true);//Back về màn hình gốc
    //
    //     Get.defaultDialog(title: 'Thanh toán thành công');
    //   }
    if (true) {
      Get.back(closeOverlays: true); //Back về màn hình gốc
      //Xóa dữ liệu
      reset();
      saleOrderController.updateController();
      Get.defaultDialog(title: 'Thanh toán thành công');
    }
  }

  Future<void> loadQRCode () async{
    qrPay = Image.memory(const Base64Decoder().convert(await APIs.generateQRCode(saleOrderController.billAmount.value)),fit: BoxFit.contain,);
  }
}
