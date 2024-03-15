import 'package:flutter/material.dart';
import 'package:pos/helpers/reponsiveness.dart';
import 'package:pos/vertical_menu_item.dart';
import 'package:pos/widgets/horizontal_menu_item.dart';

class MenuDauMuc extends StatelessWidget {
  final String itemName;
  final Function() onTap;

  const MenuDauMuc({super.key, required this.itemName, required this.onTap});

  @override
  Widget build(BuildContext context) {
    if (ResponsiveWidget.isCustomSize(context)) {
      return VerticalMenuItem(
        itemName: itemName,
        onTap: onTap,
      );
    } else {
      return HorizontalMenuItem(
        itemName: itemName,
        onTap: onTap,
      );
    }
  }
}
