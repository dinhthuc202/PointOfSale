import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pos/constants/controllers.dart';
import 'package:pos/controllers/sale_order_controller.dart';
import '../../../constants/style.dart';
import '../../../models/product.dart';
import '../../../widgets/custom_text.dart';

class FormProduct extends StatefulWidget {
  const FormProduct({super.key});

  @override
  State<FormProduct> createState() => _FormProductState();
}

class _FormProductState extends State<FormProduct> {
  late TextEditingController productNameController;
  late TextEditingController purchasePriceController;
  late TextEditingController salePriceController;
  late TextEditingController stockController;
  late TextEditingController perPackController;
  late TextEditingController totalPieceController;
  late TextEditingController rackPositionController;
  late TextEditingController supplierController;

  @override
  void initState() {
    productNameController = TextEditingController();
    purchasePriceController = TextEditingController();
    salePriceController = TextEditingController();
    stockController = TextEditingController();
    perPackController = TextEditingController();
    totalPieceController = TextEditingController();
    //saleableController = TextEditingController();
    rackPositionController = TextEditingController();
    supplierController = TextEditingController();
    //saleableController.text = 'false';
    super.initState();
  }

  @override
  void dispose() {
    productNameController.dispose();
    purchasePriceController.dispose();
    salePriceController.dispose();
    stockController.dispose();
    perPackController.dispose();
    totalPieceController.dispose();
    //saleableController.dispose();
    rackPositionController.dispose();
    supplierController.dispose();
    super.dispose();
  }

  void clearValueController() {
    productNameController.clear();
    purchasePriceController.clear();
    salePriceController.clear();
    stockController.clear();
    perPackController.clear();
    totalPieceController.clear();
    //saleableController.text = 'false';
    productController.saleable.value = false;
    rackPositionController.clear();
    supplierController.clear();
  }

  bool checkNullControllerRequired() {
    return productNameController.text.isEmpty ||
        purchasePriceController.text.isEmpty ||
        salePriceController.text.isEmpty ||
        totalPieceController.text.isEmpty ||
        supplierController.text.isEmpty;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                RowInputWidget(
                  textEditingController: productNameController,
                  title: 'Product Name',
                  required: true,
                ),
                SizedBox(
                  width: (width - 190) * 0.25,
                ),
                RowInputWidget(
                  textEditingController: purchasePriceController,
                  title: 'Purchase Price',
                  required: true,
                  isDecimal: true,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                RowInputWidget(
                    textEditingController: salePriceController,
                    title: 'Sale Price',
                    required: true,
                    isDecimal: true),
                SizedBox(
                  width: (width - 200) * 0.25,
                ),
                RowInputWidget(
                  textEditingController: totalPieceController,
                  title: 'Total Piece',
                  required: true,
                  isDecimal: true,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                RowInputWidget(
                  textEditingController: perPackController,
                  title: 'Per Pack',
                  isNumber: true,
                ),
                SizedBox(
                  width: (width - 200) * 0.25,
                ),
                RowInputWidget(
                    textEditingController: stockController,
                    title: 'Stock',
                    isDecimal: true),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                RowInputWidget(
                    textEditingController: rackPositionController,
                    title: 'Rack Position'),
                SizedBox(
                  width: (width - 200) * 0.25,
                ),
                RowInputWidget(
                  textEditingController: supplierController,
                  title: 'Supplier',
                  isDropdownSearch: true,
                  required: true,
                  listItem: productController.suppliers
                      .map((supplier) => supplier.name.toString())
                      .toList(),
                ),
              ],
            ),
            const RowInputWidget(
              title: 'Saleable',
              required: true,
              isCheckBox: true,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                onPressed: clearValueController,
                style: ElevatedButton.styleFrom(
                  backgroundColor: active,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const CustomText(
                  text: "Clear ô đã nhập",
                  color: light,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                onPressed: () async {
                  productController.buttonOnPress();
                  if (checkNullControllerRequired()) {
                    Get.defaultDialog(
                      title: "Lỗi",
                      titleStyle: const TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                      content: const CustomText(
                          text: "Vui lòng điền đầy đủ thông tin!"),
                    );
                    return;
                  } else {
                    Product product = Product(
                      name: productNameController.text,
                      purchasePrice: double.parse(purchasePriceController.text),
                      salePrice: double.parse(salePriceController.text),
                      stock: stockController.text.isEmpty
                          ? null
                          : double.parse(stockController.text),
                      perPack: perPackController.text.isEmpty
                          ? null
                          : int.parse(perPackController.text),
                      totalPiece: double.parse(totalPieceController.text),
                      saleable: productController.saleable.value,
                      rackPosition: rackPositionController.text,
                      supplierId: productController.suppliers
                          .firstWhere(
                            (item) => item.name == supplierController.text,
                          )
                          .id,
                    );

                    var result = await productController.addProduct(product);
                    if (result.statusCode == 200) {
                      Get.defaultDialog(
                        title: "Success",
                        titleStyle: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                        content:
                            const CustomText(text: "Thêm sản phẩm thành công!"),
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: active,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const CustomText(
                  text: "Thêm",
                  color: light,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

//--
class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final bool? isDecimal;
  final bool? isNumber;
  final Function? onChange;

  const TextFieldWidget({
    super.key,
    required this.controller,
    this.isDecimal = false,
    this.isNumber = false,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    List<TextInputFormatter> inputFormatters = [];
    if (isDecimal == true) {
      inputFormatters = inputFormattersDecimal;
    }
    if (isNumber == true) {
      inputFormatters = inputFormattersInt;
    }
    return TextField(
      onChanged: (value) {
        onChange!(value);
      },
      style: const TextStyle(fontSize: 12),
      inputFormatters: inputFormatters,
      controller: controller,
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black,
            width: 3,
          ),
        ),
      ),
    );
  }
}

class DropdownSearchWidget extends StatefulWidget {
  final List<String> listItem;
  final TextEditingController textEditingController;
  final String? itemDefault;
  final Function? onChange;

  const DropdownSearchWidget(
      {super.key,
      required this.listItem,
      required this.textEditingController,
      this.itemDefault,
      this.onChange});

  @override
  State<DropdownSearchWidget> createState() => _DropdownSearchWidgetState();
}

class _DropdownSearchWidgetState extends State<DropdownSearchWidget> {
  SaleOrderController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<String>(
      items: widget.listItem,
      selectedItem: widget.textEditingController.text,
      onChanged: (value) {
        // widget.textEditingController.text = value!;
        widget.onChange!(value);
      },
      popupProps: PopupProps.menu(
        searchFieldProps: TextFieldProps(
          autofocus: true,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(10),
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
    );
  }
}

//--
class CheckBoxWidget extends StatefulWidget {
  final Function onChange;

  const CheckBoxWidget({
    super.key,
    required this.onChange,
  });

  @override
  State<CheckBoxWidget> createState() => _CheckBoxWidgetState();
}

class _CheckBoxWidgetState extends State<CheckBoxWidget> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => Checkbox(
          value: productController.saleable.value,
          // value: widget.textEditingController.text.toLowerCase() == 'true',
          side: const BorderSide(
            width: 0.9,
          ),
          onChanged: (value) {
            setState(() {
              widget.onChange(value);
              //productController.saleable.value = value!;
            });
          },
        ));
  }
}

//Row
class RowInputWidget extends StatelessWidget {
  final bool? isDecimal;
  final bool? isNumber;
  final bool? isDropdownSearch;
  final bool? isCheckBox;
  final bool? required;
  final TextEditingController? textEditingController;
  final String title;
  final Color? colorText;
  final double? width;
  final double? height;
  final List<String>? listItem;
  final Color? color;
  final Function? onChange;
  final double? textSize;
  final String? itemDefault;

  const RowInputWidget({
    super.key,
    this.isDropdownSearch = false,
    this.textEditingController,
    required this.title,
    this.colorText,
    this.width,
    this.height,
    this.isDecimal = false,
    this.isNumber = false,
    this.isCheckBox,
    this.listItem,
    this.required,
    this.color,
    this.textSize,
    this.onChange, this.itemDefault,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
              width: 150,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomText(
                    text: productController.buttonCheckNull.value
                            .toString()
                            .isNotEmpty
                        ? title
                        : title,
                    size: textSize ?? 13,
                    color: required == true &&
                            productController.buttonCheckNull.value == true &&
                            textEditingController!.text.isEmpty
                        ? Colors.red
                        : Colors.black,
                  ),
                  required == true
                      ? const CustomText(
                          text: "*",
                          color: Colors.red,
                        )
                      : const CustomText(text: " "),
                ],
              )),
          const SizedBox(
            width: 10,
          ),
          SizedBox(
            width: width ?? 200,
            height: height ?? 30,
            child: isDropdownSearch == true
                ? DropdownSearchWidget(
              itemDefault: itemDefault,
                    onChange: (value) {
                      onChange!(value);
                    },
                    listItem: listItem!,
                    textEditingController: textEditingController!,
                    //onChange: onChange,
                  )
                : (isCheckBox == true
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CheckBoxWidget(
                            onChange: (value) {
                              onChange!(value);
                            },
                            //textEditingController: textEditingController!
                          ),
                        ],
                      )
                    : TextFieldWidget(
                        onChange: (value) {
                          onChange!(value);
                        },
                        controller: textEditingController!,
                        isDecimal: isDecimal,
                        isNumber: isNumber,
                      )),
          )
        ],
      ),
    );
  }
}
