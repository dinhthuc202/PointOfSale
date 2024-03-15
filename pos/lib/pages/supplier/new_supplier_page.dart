import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:pos/models/supplier.dart';
import '../../constants/apis.dart';
import '../../constants/controllers.dart';
import '../../helpers/reponsiveness.dart';
import '../../widgets/custom_text.dart';

class NewSupplierPage extends StatefulWidget {
  const NewSupplierPage({super.key});

  @override
  State<NewSupplierPage> createState() => _NewSupplierPageState();
}

class _NewSupplierPageState extends State<NewSupplierPage> {

  @override
  void initState() {
    super.initState();
  }

  Future<void> sendData() async {
    List<Supplier> tmp = await APIs.getListSupplier();
    print(tmp[0].toJson());
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Row(
          children: [
            Container(
              margin: EdgeInsets.only(
                  top: ResponsiveWidget.isSmallScreen(context) ? 56 : 6),
              child: CustomText(
                text: menuController.activeItem.value,
                size: 24,
                weight: FontWeight.bold,
              ),
            ),
          ],
        ),
        // Padding(
        //   padding: const EdgeInsets.only(top: 30),
        //   child: Container(
        //     height: (width > 768 ? (height - 80) : height - 130),
        //     decoration: BoxDecoration(
        //         borderRadius: BorderRadius.circular(10),
        //         color: Colors.grey[50],
        //         border: Border.all(color: Colors.black12)),
        //     child: Padding(
        //       padding: const EdgeInsets.all(15.0),
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [
        //           Row(
        //             children: [
        //               SizedBox(
        //                 width: 300,
        //                 height: 40,
        //                 child: FutureBuilder(
        //                   future: sendData(),
        //                   builder:
        //                       (BuildContext context, AsyncSnapshot snapshot) {
        //                     if (snapshot.connectionState ==
        //                         ConnectionState.waiting) {
        //                       //return const CircularProgressIndicator();
        //                       // return DropdownSearch<String>(
        //                       //   items: [],
        //                       // );
        //                     }
        //                     if (snapshot.connectionState ==
        //                         ConnectionState.done) {
        //
        //                       return DropdownSearch<String>(
        //                         items: productController.suppliers.map((supplier) =>
        //                             supplier.name.toString())
        //                             .toList(),
        //                         onChanged: (value) {
        //                           print(value);
        //                         },
        //                         popupProps: PopupProps.menu(
        //                           searchFieldProps: TextFieldProps(
        //                             autofocus: true,
        //                             decoration: InputDecoration(
        //                               contentPadding:
        //                                   const EdgeInsets.all(10),
        //                               border: OutlineInputBorder(
        //                                 borderRadius:
        //                                     BorderRadius.circular(7),
        //                               ),
        //                             ),
        //                           ),
        //                           showSearchBox: true,
        //                           constraints: const BoxConstraints(
        //                               maxHeight: 300,),
        //                           searchDelay:
        //                               const Duration(microseconds: 50),
        //                         ),
        //                       );
        //                     }
        //                     return Container();
        //                   },
        //                   // child: DropdownSearch<Customer>(
        //                   //   items:customers,
        //                   // ),
        //                 ),
        //               ),
        //             ],
        //           ),
        //         ],
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
