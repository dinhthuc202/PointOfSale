import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/apis.dart';
import '../models/product.dart';
import 'package:http/http.dart' as http;
import '../models/supplier.dart';

class ProductController extends GetxController {
  static ProductController instance = Get.find();
  RxBool buttonCheckNull = false.obs;
  late List<Supplier> suppliers;
  late List<Product> products;

  //late TextEditingController saleableController;
  var saleable = false.obs;


  void buttonOnPress() {
    buttonCheckNull.value = true;
  }

  Future<void> fetchData() async {
    suppliers = await APIs.getListSupplier();
  }

  Future<http.Response> addProduct(Product product) async{
    return await APIs.postProduct(product);
  }

  Future<void> getDataProduct() async{
    products = await APIs.getListProduct();
  }
}
