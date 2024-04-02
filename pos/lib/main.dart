import 'package:flutter/material.dart';
import 'package:pos/controllers/menu_controller.dart' as menu_controller;
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pos/constants/style.dart';
import 'package:pos/controllers/navigation_controller.dart';
import 'package:pos/controllers/user_controller.dart';
import 'package:pos/layout.dart';
import 'package:pos/pages/404/error.dart';
import 'package:pos/pages/authentication/authentication.dart';
import 'controllers/product_controller.dart';
import 'controllers/sale_order_controller.dart';
import 'routing/routes.dart';

void main() {
  Get.put(menu_controller.MenuController());
  Get.put(NavigationController());
  Get.lazyPut(() => ProductController());
  Get.lazyPut(() => UserController());
  Get.lazyPut(() => SaleOrderController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      //navigatorKey: navigationController.navigatorKey,
      initialRoute: rootRoute,
      //initialRoute: authenticationPageRoute,

      unknownRoute: GetPage(
        name: '/not-found',
        page: () => const PageNotFound(),
        transition: Transition.fadeIn,
      ),
      getPages: [
        GetPage(
            name: rootRoute,
            page: () {
              return SiteLayout();
            }),
        GetPage(
            name: authenticationPageRoute,
            page: () => const AuthenticationPage()),
      ],
      debugShowCheckedModeBanner: false,
      title: 'Dashboard',
      theme: ThemeData(
        scaffoldBackgroundColor: light,
        textTheme: GoogleFonts.mulishTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.black),
        pageTransitionsTheme: const PageTransitionsTheme(builders: {
          TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
        }),
        primarySwatch: Colors.blue,
      ),
      // home: AuthenticationPage(),
    );
  }
}
