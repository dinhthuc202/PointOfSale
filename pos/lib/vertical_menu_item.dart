import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/constants/controllers.dart';
import 'package:pos/constants/style.dart';

import 'widgets/custom_text.dart';

class VerticalMenuItem extends StatelessWidget {
  final String itemName;
  final Function()? onTap;

  const VerticalMenuItem({super.key, required this.itemName, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        onHover: (value) {
          value
              ? menuController.onHover(itemName)
              : menuController.onHover("not hovering");
        },
        child: Obx(() => Container(
              color: menuController.isHovering(itemName)
                  ? lightGrey.withOpacity(.1)
                  : Colors.transparent,
              child: Column(
                children: [
                  Row(
                    children: [
                      Visibility(
                        visible: menuController.isHovering(itemName) ||
                            menuController.isActive(itemName),
                        maintainSize: true,
                        maintainAnimation: true,
                        maintainState: true,
                        child: Container(
                          width: 3,
                          height: 72,
                          color: Colors.white,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(16),
                              //child: menuController.returnIconFor(itemName),
                            ),
                            if (!menuController.isActive(itemName))
                              Flexible(
                                  child: CustomText(
                                text: itemName,
                                color: menuController.isHovering(itemName)
                                    ? Colors.black
                                    : lightGrey,
                              ))
                            else
                              Flexible(
                                  child: CustomText(
                                text: itemName,
                                color: Colors.black,
                                size: 18,
                                weight: FontWeight.bold,
                              ))
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 1,
                    color: Colors.grey,
                  ),
                ],
              ),
            )));
  }
}
