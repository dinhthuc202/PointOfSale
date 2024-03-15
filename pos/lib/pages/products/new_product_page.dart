import 'package:flutter/material.dart';
import 'package:pos/pages/products/widgets/form_product.dart';
import '../../constants/controllers.dart';
import '../../helpers/reponsiveness.dart';
import '../../widgets/custom_text.dart';

class NewProductPage extends StatefulWidget {
  const NewProductPage({super.key});

  @override
  State<NewProductPage> createState() => _NewProductPage();
}

class _NewProductPage extends State<NewProductPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
        FutureBuilder(
          future: productController.fetchData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.connectionState == ConnectionState.done) {
              return Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Container(
                  height: (width > 768 ? (height - 80) : height - 130),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[50],
                      border: Border.all(color: Colors.black12)),
                  child: const FormProduct(),
                ),
              );
            }
            return Container();
          },
        ),
      ],
    );
  }
}
