import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/constants/apis.dart';
import 'package:pos/models/customer.dart';
import 'package:pos/pages/sale/widgets/item_sale.dart';
import 'package:pos/pages/sale/widgets/multi_item_sale.dart';
import '../../constants/controllers.dart';
import '../../constants/style.dart';
import '../../controllers/sale_order_controller.dart';
import '../../helpers/reponsiveness.dart';
import '../../models/sale_order.dart';
import '../../widgets/custom_text.dart';
import '../products/widgets/form_product.dart';

class NewSalePage extends StatefulWidget {
  const NewSalePage({super.key});

  @override
  State<NewSalePage> createState() => _NewSalePageState();
}

class _NewSalePageState extends State<NewSalePage> {
  TextEditingController customerTextEditingController =
      TextEditingController(text: "Khách hàng mới");


  SODs soDs = SODs(flag: 0);

  @override
  void initState() {
    super.initState();
    //restbill
    saleOrderController.customerSelect = Rx<Customer>(Customer());
    saleOrderController.itemSales = [];
    saleOrderController.itemSales.add(ItemSale(
      onRemove: () => saleOrderController.onRemove(soDs),
      soDs: soDs,
    ));
    saleOrderController.billAmount.value =0.0;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Obx(
          () => Row(
            children: [
              Container(
                  margin: EdgeInsets.only(
                      top: ResponsiveWidget.isSmallScreen(context) ? 56 : 6),
                  child: CustomText(
                    text: menuController.activeItem.value,
                    size: 24,
                    weight: FontWeight.bold,
                  )),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Container(
            height: (width > 768 ? (height - 80) : height - 130),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[50],
                border: Border.all(color: Colors.black12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FutureBuilder(
                  future:
                      saleOrderController.getDataCustomer().then((_) => null),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 65.0,top: 10),
                              child: SizedBox(
                                height: 35,
                                width: width*0.8*0.25,
                                child: Stack(
                                  children: [
                                    DropdownSearch<String>(
                                      items: saleOrderController.customers
                                              .map((customer) => customer.name.toString())
                                              .toList(),
                                      onChanged: (value) {
                                        customerTextEditingController.text = value!;
                                        saleOrderController.changeCustomer(value);
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
                                    IgnorePointer(
                                      child: Container(
                                        width: width*0.8*0.25-35,
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
                                            controller: customerTextEditingController,
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                            readOnly: true,
                                            decoration: const InputDecoration(
                                              labelText: "Select Customer",
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
                            ),
                            // RowInputWidget(
                            //   title: 'Customer Name',
                            //   required: true,
                            //   textSize: 14,
                            //   isDropdownSearch: true,
                            //   listItem: saleOrderController.customers
                            //       .map((customer) => customer.name.toString())
                            //       .toList(),
                            //   textEditingController:
                            //       customerTextEditingController,
                            //   onChange: (value) {
                            //     saleOrderController.changeCustomer(value);
                            //   },
                            // ),
                            SizedBox(
                              width: (width - 200) * 0.25,
                            ),
                            const CustomText(
                              text: 'Address: ',
                              size: 14,
                            ),
                            Obx(() => CustomText(
                                  text: saleOrderController
                                          .customerSelect.value.address ??
                                      '',
                                  size: 14,
                                )),
                          ],
                        ),
                      );
                    }
                    return Container();
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 65.0, bottom: 10),
                  child: CustomText(
                    text: "Nhân viên: ${userController.user.name!}",
                    size: 14,
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey)),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 5,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: FutureBuilder(
                                future: productController
                                    .getDataProduct()
                                    .then((_) => null),
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  }
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    return const MultiItemSale();
                                  }
                                  return Container();
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              color: Colors.grey[200],
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const CustomText(
                                    text: "Hóa Đơn",
                                    size: 20,
                                    weight: FontWeight.w700,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Expanded(
                                      child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 10),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: const BoxDecoration(
                                          border: Border(
                                        bottom: BorderSide(
                                          color: Colors.black,
                                          width: 2.0,
                                        ),
                                      )),
                                      child: GetBuilder<SaleOrderController>(
                                          builder: (controller) =>
                                              ListView.builder(
                                                  padding:
                                                      const EdgeInsets.all(0),
                                                  itemCount: saleOrderController
                                                      .itemSales.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        //Hóa đơn
                                                        controller
                                                                    .itemSales[
                                                                        index]
                                                                    .soDs
                                                                    .productName !=
                                                                null && controller
                                                            .itemSales[
                                                        index]
                                                            .soDs
                                                            .productName !=
                                                            ''
                                                            ? Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  CustomText(
                                                                      size: 14,
                                                                      text: controller
                                                                          .itemSales[
                                                                              index]
                                                                          .soDs
                                                                          .productName!),
                                                                  CustomText(
                                                                      size: 14,
                                                                      text:
                                                                          "Giá tiền: ${formatMoney.format(controller.itemSales[index].soDs.salePrice ?? 0)} vnđ"),
                                                                  CustomText(
                                                                      size: 14,
                                                                      text:
                                                                          "Số lượng: ${controller.itemSales[index].soDs.quantity == null ? "0" : controller.itemSales[index].soDs.quantity.toString()}"),
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Container(),
                                                                      CustomText(
                                                                          size:
                                                                              14,
                                                                          text:
                                                                              "Thành tiền: ${formatMoney.format((controller.itemSales[index].soDs.salePrice == null ? 0.0 : controller.itemSales[index].soDs.salePrice!) * (controller.itemSales[index].soDs.quantity == null ? 0 : controller.itemSales[index].soDs.quantity!))} vnđ"),
                                                                    ],
                                                                  ),
                                                                  if (index <
                                                                      controller
                                                                              .itemSales
                                                                              .length -
                                                                          1)
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                          .symmetric(
                                                                          vertical:
                                                                              5.0,
                                                                          horizontal:
                                                                              10),
                                                                      child:
                                                                          Container(
                                                                        color: Colors
                                                                            .black,
                                                                        height:
                                                                            1,
                                                                      ),
                                                                    ),
                                                                ],
                                                              )
                                                            : Container(),
                                                      ],
                                                    );
                                                  })),
                                    ),
                                  )),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("Tổng tiền"),
                                        Obx(() => Text(
                                            "${formatMoney.format(saleOrderController.billAmount.value)} vnđ")),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 50,
                                    child: ElevatedButton(
                                      onPressed: () async{
                                        if (saleOrderController
                                            .formKey.currentState!
                                            .validate()) {
                                          saleOrderController.onSave(context);
                                        }
                                      },
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Colors.lightBlue),
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ))),
                                      child: const Text(
                                        "Thanh Toán",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 15),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
