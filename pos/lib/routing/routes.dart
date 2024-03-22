import 'package:flutter/material.dart';

const rootRoute = "/";

const homePageDisplayName = "Home";
const homePageRoute = "/home";

const newSalePageDisplayName = "New Sale";
const newSalePageRoute = "/newSale";

const newSalePage2DisplayName = "New Sale 2";
const newSale2PageRoute = "/NewSale2";

const newProductDisplayName = "New Product";
const newProductPageRoute = "/newProduct";

const listProductDisplayName = "List Product";
const listProductPageRouter = "/listProduct";

const newSupplierPageDisplayName = "New Supplier";
const newSupplierPageRoute = "/newSupplier";

const authenticationPageDisplayName = "Log out";
const authenticationPageRoute = "/auth";

class MenuItem {
  final String name;
  final String route;
  MenuItem(this.name, this.route);
}

class DauMucItems{
  final String name;
  final List<MenuItem> itm;
  final Image ic;
  DauMucItems(this.name, this.itm, this.ic);
}

List<DauMucItems> listButtonMenu = [
  DauMucItems("Home", [MenuItem(homePageDisplayName, homePageRoute),], Image.asset("assets/icons/home.png")),
  DauMucItems("Sale", itemSale,Image.asset("assets/icons/sale.png")),
  DauMucItems("Products", itemProducts, Image.asset("assets/icons/product.png")),
  DauMucItems("Supplier", itemSupplier, Image.asset("assets/icons/supplier.png")),
];

List<MenuItem> itemSale = [
  MenuItem(newSalePageDisplayName, newSalePageRoute),
  MenuItem(newSalePage2DisplayName, newSale2PageRoute),
];

List<MenuItem> itemProducts = [
  MenuItem(newProductDisplayName, newProductPageRoute),
  MenuItem(listProductDisplayName, listProductPageRouter),
];

List<MenuItem> itemSupplier= [
  MenuItem(newSupplierPageDisplayName, newSupplierPageRoute),
];