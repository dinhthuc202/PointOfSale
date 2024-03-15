import 'package:flutter/material.dart';
import 'package:pos/pages/products/new_product_page.dart';
import 'package:pos/pages/sale/new_sale.dart';
import 'package:pos/routing/routes.dart';
import '../pages/home_page.dart';
import '../pages/products/list_product.dart';
import '../pages/supplier/new_supplier_page.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case homePageRoute:
      return _getPageRoute(const HomePage());
    case newSupplierPageRoute:
      return _getPageRoute(const NewSupplierPage());
    case newProductPageRoute:
      return _getPageRoute(const NewProductPage());
    case listProductPageRouter:
      return _getPageRoute(const ListProductPage());
    case newSalePageRoute:
      return _getPageRoute(const NewSalePage());
    default:
      return _getPageRoute(const HomePage());
  }
}
// SelectionArea có thể copy được nội dung bên trong
PageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(builder: (context) =>  SelectionArea(child: child));
}
