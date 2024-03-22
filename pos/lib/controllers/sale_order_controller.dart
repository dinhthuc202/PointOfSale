import 'package:get/get.dart';
import 'package:pos/models/product.dart';
import '../constants/apis.dart';
import '../constants/controllers.dart';
import '../models/customer.dart';
import '../models/sale_order.dart';
import '../pages/sale/widgets/form_item.dart';

class SaleOrderController extends GetxController {
  static SaleOrderController instance = Get.find();
  RxList<FromItem> fromItems = <FromItem>[].obs;
  RxList<Product> itemBills = <Product>[].obs;


  Rx<double> billAmount = 0.0.obs;
  late List<Customer> customers;
  late List<Product> products;
  Rx<Customer> customerSelect = Rx<Customer>(Customer());


  Future<void> fetchData() async {
    customers = await APIs.getListCustomer();
    customers.insert(0, Customer(name:'Khách hàng mới'));
    products = await APIs.getListProduct();
  }

  Future<void> fetchData2() async {
    customers = await APIs.getListCustomer();
    customers.insert(0, Customer(name:'Khách hàng mới'));
    products = await APIs.getListProduct();
  }

  calcBillAmount() {
    double tmp = 0.0;
    for (var item in fromItems) {
      tmp = tmp + item.item.salePrice!;
    }
    billAmount.value = tmp;
  }

  changeCustomer(String customerName){
      customerSelect.value = customers
          .firstWhere(
            (item) =>
        item.name ==
            customerName,
      );
  }
  onAddProduct() {
    SODs sod =
    SODs(flag: fromItems.isNotEmpty ? fromItems.last.item.flag! + 1 : 1);
    fromItems.add(FromItem(
      item: sod,
      onRemove: () => onRemoveProduct(sod),
    ));
  }

  onAddProduct2(Product product) {
    if(itemBills.where((item) => item.id == product.id).isEmpty){
      product.quantity = 1;
      itemBills.add(
        product
      );
    }else{
      int index =
      itemBills.indexWhere((item) => item.id == product.id);
      itemBills[index].quantity = itemBills[index].quantity! + 1;
      print(itemBills[index].quantity);
    }
    calcBillAmount2();
  }

  onRemoveProduct(SODs sod) {
    if(fromItems.length == 1){
      //Ngăn xóa khi còn 1 item
      return;
    }
    int index =
    fromItems.indexWhere((element) => element.item.flag == sod.flag);
    if (fromItems.isNotEmpty) fromItems.removeAt(index);
    saleOrderController.update();//Update state
  }


  restBill(){
    itemBills.value = [];
    billAmount.value = 0.0;
  }
  onRemoveProduct2(int index){
    itemBills.removeAt(index);
    calcBillAmount2();
    saleOrderController.update();
  }

  increaseQuantityProduct(int index){
    itemBills[index].quantity =itemBills[index].quantity! + 1;
    calcBillAmount2();
    saleOrderController.update();
  }

  decreaseQuantityProduct(int index){
    itemBills[index].quantity =itemBills[index].quantity! - 1;
    if (itemBills[index].quantity == 0){
      itemBills.removeAt(index);
    }
    calcBillAmount2();
    saleOrderController.update();
  }
  calcBillAmount2() {
    double tmp = 0.0;
    for (var item in itemBills) {
      tmp = tmp + item.salePrice! * item.quantity!;
    }
    billAmount.value = tmp;
  }
}
