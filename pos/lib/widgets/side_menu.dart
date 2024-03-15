import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos/helpers/reponsiveness.dart';
import 'package:pos/widgets/custom_text.dart';
import '../constants/controllers.dart';
import '../constants/style.dart';
import '../routing/routes.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      color: light,
      child: ListView(
        children: [
          //Nếu màn hình nhỏ thì menu sẽ hiện icon và tên
          if (ResponsiveWidget.isSmallScreen(context))
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    SizedBox(width: width / 48),
                    Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Image.asset("assets/icons/logo.png"),
                    ),
                    const Flexible(
                      child: CustomText(
                        text: nameApp,
                        size: 20,
                        weight: FontWeight.bold,
                        color: active,
                      ),
                    ),
                    SizedBox(width: width / 48),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          Divider(
            color: lightGrey.withOpacity(.1),
          ),
          //-----------
          Column(
            mainAxisSize: MainAxisSize.min,
            children: listButtonMenu
                .map((i) => Column(
                      children: [
                        i.name == "Home"
                            ? InkWell(
                                child: ExpansionTile(
                                  leading: Container(
                                    constraints: const BoxConstraints(
                                      maxWidth: 25,
                                      maxHeight: 25,
                                    ),
                                    child: i.ic,
                                  ),
                                  title: CustomText(
                                    text: i.name,
                                  ),
                                  enabled: false,
                                ),
                                onTap: () {
                                  if (!menuController.isActive(i.itm[0].name)) {
                                    menuController
                                        .changeActiveItemTo(i.itm[0].name);
                                    if (ResponsiveWidget.isSmallScreen(
                                        context)) {
                                      Get.back();
                                    }
                                    navigationController
                                        .navigateTo(i.itm[0].route);
                                  }
                                },
                              )
                            : ExpansionTile(
                                leading: Container(
                                  constraints: const BoxConstraints(
                                    maxWidth: 25,
                                    maxHeight: 25,
                                  ),
                                  child: i.ic,
                                ),
                                title: CustomText(
                                  text: i.name,
                                ),
                                children: i.itm
                                    .map((e) => Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20.0),
                                          child: ListTile(
                                            title: Text(e.name),
                                            onTap: () {
                                              if (e.route ==
                                                  authenticationPageRoute) {
                                                Get.offAllNamed(
                                                    authenticationPageRoute);
                                                menuController
                                                    .changeActiveItemTo(
                                                        homePageDisplayName);
                                              }
                                              if (!menuController
                                                  .isActive(e.name)) {
                                                menuController
                                                    .changeActiveItemTo(e.name);
                                                if (ResponsiveWidget
                                                    .isSmallScreen(context)) {
                                                  Get.back();
                                                }
                                                navigationController
                                                    .navigateTo(e.route);
                                              }
                                            },
                                          ),
                                        ))
                                    .toList(),
                              ),
                        Container(
                          height: 1,
                          color: Colors.grey,
                        ),
                      ],
                    ))
                .toList(),
          )
        ],
      ),
    );
  }
}
