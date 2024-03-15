import 'package:flutter/material.dart';
import '../constants/style.dart';
import 'custom_text.dart';

class CustomButton extends StatelessWidget {
final String text;
final double? width;
final double? height;
final Color? color;
final Color? colorButton;
final CallbackAction? onPressed;

const CustomButton({super.key,required this.text,this.color, this.width, this.height, this.onPressed, this.colorButton});


@override
Widget build(BuildContext context) {

  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          onPressed: () {
            onPressed;
          },
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(200, 50),
            backgroundColor:color?? active,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: CustomText(
            text: text,
            color:colorButton ?? light,
          ),
        ),
      ],
    ),
  );
}
}

