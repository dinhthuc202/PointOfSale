import 'dart:convert';

import 'package:pos/models/product.dart';
import 'package:pos/models/sale_order.dart';
import 'package:pos/models/supplier.dart';

import '../models/customer.dart';import 'package:http/http.dart' as http;

//String urlApi = "https://picked-remarkably-toucan.ngrok-free.app/";
String urlApi = "http://127.0.0.1:90/";
class APIs{
  //Customer
  static Future<List<Customer>> getListCustomer() async {
    try {
      final response = await http.get(Uri.parse("${urlApi}api/Customer"));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['customers'];
        final List<Customer> customers = data
            .map((customerData) => Customer.fromJson(customerData))
            .toList();
        return customers;
      } else {
        return [];
      }
    } catch (ex) {
      print(ex);
      throw Exception('Failed to load data');
    }
  }

  static Future<Map<String, dynamic>> postCustomer(Customer customer) async {
    try {
      final response = await http.post(
        Uri.parse("${urlApi}api/Customer"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(customer.toJson()),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to send data: ${response.statusCode}');
      }
    } catch (ex) {
      print(ex);
      throw Exception('Failed to send data');
    }
  }

  ///Supplier
  static Future<List<Supplier>> getListSupplier() async {
    try {
      final response = await http.get(Uri.parse("${urlApi}api/Supplier"));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['suppliers'];
        final List<Supplier> suppliers = data
            .map((supplierData) => Supplier.fromJson(supplierData))
            .toList();
        return suppliers;
      } else {
        return [];
      }
    } catch (ex) {
      print(ex);
      throw Exception('Failed to load data');
    }
  }

  ///Product
  static Future<http.Response> postProduct(Product product) async {
    try {
      final response = await http.post(
        Uri.parse("${urlApi}api/Product"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(product.toJson()),
      );
      return response;
    } catch (ex) {
      print(ex);
      throw Exception('Failed to send data');
    }
  }
  static Future<List<Product>> getListProduct() async {
    try {
      final response = await http.get(Uri.parse("${urlApi}api/Product"));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['products'];
        final List<Product> products = data
            .map((productsData) => Product.fromJson(productsData))
            .toList();
        return products;
      } else {
        return [];
      }
    } catch (ex) {
      print(ex);
      throw Exception('Failed to load data');
    }
  }

  ///SaleOrder
  static Future<String> postSaleOrder(SaleOrder saleOrder) async {
    try {
      final response = await http.post(
        Uri.parse("${urlApi}api/SaleOrder/NewSale"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(saleOrder.toJson()),
      );
      //return response;
      Map<String, dynamic> decodedResponse = jsonDecode(response.body);
      String base64DataUrl = decodedResponse['data']['qrDataURL'].split(',')[1];
      print(base64DataUrl);
      return base64DataUrl;
    } catch (ex) {
      print(ex);
      throw Exception('Failed to send data');
    }
  }
  //return chuỗi base64
  static Future<String> generateQRCode(double amount)async{
    try{
      final response = await http.post(
        Uri.parse("https://api.vietqr.io/v2/generate?x-client-id=dab29287-60c5-4a86-97d5-aae7a686442a&x-api-key=c7f46480-800e-48da-917c-e8e2bff01c16"),
        body: <String, dynamic>{
          "accountNo": "0846961712",
          "accountName": "NGUYEN DINH THUC",
          "acqId": 970418.toString(),
          "amount": amount.toString(),
          "addInfo": "Thanh toán hóa đơn",
          "format": "text",
          "template": "compact2"
        },
      );
      Map<String, dynamic> decodedResponse = jsonDecode(response.body);
      String base64DataUrl = decodedResponse['data']['qrDataURL'].split(',')[1];
      return base64DataUrl;
    }catch(ex){
      print(ex);
      throw Exception(ex);
    }
  }
}