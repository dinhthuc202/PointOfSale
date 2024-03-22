import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/models/product.dart';
import 'package:pos/pages/sale/widgets/form_item.dart';
import 'package:pos/pages/sale/widgets/item_bill.dart';
import '../../constants/controllers.dart';
import '../../constants/style.dart';
import '../../controllers/sale_order_controller.dart';
import '../../helpers/reponsiveness.dart';
import '../../models/sale_order.dart';
import '../../routing/routes.dart';
import '../../widgets/custom_text.dart';
import '../products/widgets/form_product.dart';

class NewSale2Page extends StatefulWidget {
  const NewSale2Page({super.key});

  @override
  State<NewSale2Page> createState() => _NewSale2PageState();
}

class _NewSale2PageState extends State<NewSale2Page> {
  TextEditingController customerTextEditingController = TextEditingController();
  TextEditingController searchTextEditingController = TextEditingController();
  List<Product> searchList = [];
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //List<String> listTitle = ["Name", "SalePrice", "Quantity", "Unit", "PerPack", "Item Total"];
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    customerTextEditingController.text = "Khách hàng mới";
    saleOrderController.restBill();

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
            child: FutureBuilder(
              future: saleOrderController.fetchData().then((_) => null),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          RowInputWidget(
                            title: 'Customer Name',
                            required: true,
                            textSize: 14,
                            isDropdownSearch: true,
                            listItem: saleOrderController.customers
                                .map((customer) => customer.name.toString())
                                .toList(),
                            textEditingController:
                                customerTextEditingController,
                            isNewSale: true,
                          ),
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
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: StatefulBuilder(
                                    builder: (BuildContext context,
                                        StateSetter setState) {
                                      return Row(
                                        children: [
                                          Column(
                                            children: [
                                              Container(
                                                width: 200,
                                                height: 36,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  //color: AppColors.backgroundInput,
                                                ),
                                                child: TextField(
                                                  controller:
                                                      searchTextEditingController,
                                                  onChanged: (value) {
                                                    searchList.clear();
                                                    for (var i
                                                        in saleOrderController
                                                            .products) {
                                                      if (i.name
                                                          .toLowerCase()
                                                          .contains(value
                                                              .toLowerCase())) {
                                                        searchList.add(i);
                                                      }
                                                      setState(() {
                                                        searchList;
                                                      });
                                                    }
                                                  },
                                                  decoration: InputDecoration(
                                                    hintText: "Search",
                                                    prefixIcon: IconButton(
                                                      icon: const Icon(
                                                          Icons.search),
                                                      onPressed: () {},
                                                    ),
                                                    border: InputBorder.none,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Container(
                                                  width: (width - width * 0.3) *
                                                      0.8,
                                                  decoration:
                                                      const BoxDecoration(
                                                          border: Border(
                                                              right: BorderSide(
                                                                  color: Colors
                                                                      .grey))),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 10.0),
                                                    child:
                                                        SingleChildScrollView(
                                                      scrollDirection:
                                                          Axis.vertical,
                                                      child: GridView.builder(
                                                          shrinkWrap: true,
                                                          scrollDirection:
                                                              Axis.vertical,
                                                          gridDelegate:
                                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                                            childAspectRatio:
                                                                5 / 7,
                                                            crossAxisCount: 5,
                                                            crossAxisSpacing:
                                                                10.0,
                                                            mainAxisSpacing:
                                                                10.0,
                                                          ),
                                                          itemCount: (isSearching ||
                                                                      searchTextEditingController
                                                                          .text
                                                                          .isNotEmpty
                                                                  ? searchList
                                                                  : saleOrderController
                                                                      .products)
                                                              .length,
                                                          itemBuilder:
                                                              (BuildContext
                                                                      context,
                                                                  int index) {
                                                            var item = (isSearching ||
                                                                    searchTextEditingController
                                                                        .text
                                                                        .isNotEmpty
                                                                ? searchList
                                                                : saleOrderController
                                                                    .products)[index];
                                                            return Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                ClipRRect(
                                                                  borderRadius:
                                                                      const BorderRadius
                                                                          .only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            10),
                                                                    topRight: Radius
                                                                        .circular(
                                                                            10),
                                                                  ),
                                                                  child:
                                                                      Container(
                                                                    color: Colors
                                                                            .grey[
                                                                        200],
                                                                    child:
                                                                        Stack(
                                                                      children: [
                                                                        item.image == null ||
                                                                                item.image!.isEmpty
                                                                            ? Image.asset("/images/default.jpg")
                                                                            : Image.network(item.image!,
                                                                                fit: BoxFit.cover,
                                                                              ),
                                                                        Positioned(
                                                                          left:
                                                                              0,
                                                                          right:
                                                                              0,
                                                                          bottom:
                                                                              0,
                                                                          child:
                                                                              Column(
                                                                            mainAxisSize:
                                                                                MainAxisSize.min,
                                                                            children: [
                                                                              Container(
                                                                                color: Colors.white.withOpacity(0.7),
                                                                                child: Center(
                                                                                  child: Text(
                                                                                    item.name,
                                                                                    style: const TextStyle(color: Colors.blueGrey, fontSize: 14, fontWeight: FontWeight.w600),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 40,
                                                                  width: double
                                                                      .infinity,
                                                                  child:
                                                                      ElevatedButton(
                                                                    onPressed:
                                                                        () {
                                                                      saleOrderController
                                                                          .onAddProduct2(
                                                                              item);
                                                                      saleOrderController
                                                                          .update();
                                                                    },
                                                                    style: ButtonStyle(
                                                                        backgroundColor: MaterialStateProperty.all<Color>(Colors.blueGrey[400]!),
                                                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(const RoundedRectangleBorder(
                                                                          borderRadius:
                                                                              BorderRadius.only(
                                                                            bottomLeft:
                                                                                Radius.circular(10),
                                                                            bottomRight:
                                                                                Radius.circular(10),
                                                                          ),
                                                                        ))),
                                                                    child:
                                                                        const Text(
                                                                      "Add",
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .white,
                                                                          fontSize:
                                                                              15),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            );
                                                          }),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                                Expanded(
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
                                            child:
                                                GetBuilder<SaleOrderController>(
                                                    builder: (controller) =>
                                                        ListView.builder(
                                                            itemCount:
                                                                controller
                                                                    .itemBills
                                                                    .length,
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              return Column(
                                                                children: [
                                                                  ItemBill(
                                                                      index: index),
                                                                  controller
                                                                      .itemBills
                                                                      .length -1 != index ? Padding(
                                                                        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
                                                                        child: Container(color: Colors.grey,height: 1,),
                                                                      ) : Container()
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
                                          //color: Colors.red,
                                          width: double.infinity,
                                          height: 50,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              navigationController
                                                  .navigateTo(newSalePageRoute);
                                            },
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all<
                                                            Color>(
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
                                                  color: Colors.white,
                                                  fontSize: 15),
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
                  );
                }
                return Container();
              },
            ),
          ),
        ),
      ],
    );
  }
}
