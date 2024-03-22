import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/pages/sale/widgets/form_item.dart';
import '../../constants/controllers.dart';
import '../../constants/style.dart';
import '../../controllers/sale_order_controller.dart';
import '../../helpers/reponsiveness.dart';
import '../../models/sale_order.dart';
import '../../widgets/custom_text.dart';
import '../products/widgets/form_product.dart';
import 'package:intl/intl.dart';

class NewSalePage extends StatefulWidget {
  const NewSalePage({super.key});

  @override
  State<NewSalePage> createState() => _NewSalePageState();
}

class _NewSalePageState extends State<NewSalePage> {
  TextEditingController customerTextEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    //reset giá trị
    saleOrderController.fromItems.value = [];
    SODs sod = SODs(flag: 0);
    saleOrderController.fromItems.add(FromItem(
      item: sod,
      onRemove: () => saleOrderController.onRemoveProduct(sod),
    ));
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
                        padding: const EdgeInsets.only(left: 65.0),
                        child: CustomText(
                          text: "Nhân viên: ${userController.user.name!}",
                          size: 14,
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Flexible(
                                child: GetBuilder<SaleOrderController>(
                              builder: (controller) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: height - 240,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: controller.fromItems
                                            .asMap()
                                            .entries
                                            .map((entry) {
                                          int index =
                                              entry.key;
                                          Widget item = entry
                                              .value;
                                          return Stack(children: [
                                            item,
                                            Positioned(
                                              left: 30,
                                              top: 15,
                                              child: Text(
                                                "Item - ${index}",
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                    color: Colors.orange),
                                              ),
                                            ),
                                          ]);
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      saleOrderController.onAddProduct();
                                      controller.update();
                                      //navigationController.goBack();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, bottom: 10, top: 10),
                                      child: Container(
                                        width: 56,
                                        height: 56,
                                        decoration: BoxDecoration(
                                            color: Colors.orange,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: const Icon(Icons.add),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                            SizedBox(
                              width: (width - width / 20) * 0.3,
                              child: Obx(() {
                                final formattedAmount = formatMoney.format(
                                    saleOrderController.billAmount.value);
                                return Text(
                                    'Bill amount: $formattedAmount vnđ');
                              }),
                            ),
                          ],
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

  onSave() {
    // bool allValid = true;
    // for (var element in controller.fromItems) {
    //   allValid = (allValid && element.isValidated());
    // }
    // if (allValid) {
    //   List<String> names = controller.fromItems.map((e) => e.saleOrder.id!).toList();
    //   debugPrint("$names");
    // } else {
    //   debugPrint("Form is Not Valid");
    // }
  }
// Obx(
//   // () => ListView(
//   //   shrinkWrap: true,
//   //   children:
//   //       fromItems
//   //           .map((item) {
//   //     return item;
//   //   }).toList(),
//   // ),
//       () =>
//       ListView.builder(
//           shrinkWrap: true,
//           itemCount: saleOrderController.fromItems
//               .length,
//           itemBuilder:
//               (_, index) {
//             return saleOrderController.fromItems[
//             index];
//           }),
// ),
}
