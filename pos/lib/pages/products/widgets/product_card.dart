import 'package:flutter/material.dart';
import 'package:pos/models/product.dart';
import '../../../widgets/custom_text.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0, 3), // X, Y offset
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Row(
            children: [
              const CustomText(
                text: 'Id: ',
                weight: FontWeight.w500,
              ),
              SizedBox(
                  width: 100,
                  child: CustomText(
                    text: product.id.toString(),
                  )),
              const CustomText(
                text: 'Name: ',
                weight: FontWeight.w500,
              ),
              CustomText(
                text: product.name,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
