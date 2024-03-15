import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../../constants/controllers.dart';
import '../../helpers/reponsiveness.dart';
import '../../widgets/custom_text.dart';

class NewSalePage extends StatefulWidget {
  const NewSalePage({super.key});

  @override
  State<NewSalePage> createState() => _NewSalePageState();
}

class _NewSalePageState extends State<NewSalePage> {
  @override
  Widget build(BuildContext context) {
    //List<String> listTitle = ["Name", "SalePrice", "Quantity", "Unit", "PerPack", "Item Total"];
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Obx(() => Row(
          children: [
            Container(
                margin: EdgeInsets.only(top:
                ResponsiveWidget.isSmallScreen(context) ? 56 : 6),
                child: CustomText(text: menuController.activeItem.value, size: 24, weight: FontWeight.bold,)),
          ],
        ),),
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Container(
            height: (width > 768 ? (height-80) : height - 130),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[50],
                border: Border.all(color: Colors.black12)
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          ],
                        ),
                      ),
                      SizedBox(
                        width: width/5,
                      ),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CustomText(text: 'Address',),
                            const SizedBox(
                              height: 15,
                            ),
                            SizedBox(
                              height: 40,
                              width: width/7,
                              child: TextFormField(
                                enabled: false,
                                style: const TextStyle( fontSize: 15),
                                decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                  hintText: 'Address',
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black,
                                      width: 3,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),

        ///Table
        const Row(
          mainAxisSize: MainAxisSize.min,
          children: [

        ],),
      ],
    );
  }
}
