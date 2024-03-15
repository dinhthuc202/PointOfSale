import 'package:flutter/material.dart';
import 'package:pos/helpers/local_navigator.dart';
import 'package:pos/helpers/reponsiveness.dart';
import 'package:pos/widgets/large_screen.dart';
import 'package:pos/widgets/side_menu.dart';
import 'widgets/top_nav.dart';

class SiteLayout extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  SiteLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: topNavigationBar(context, scaffoldKey),
      drawer: const Drawer(
          child: SideMenu(),
      ),
      body: ResponsiveWidget(
          largeScreen: const LargeScreen(),
          smallScreen: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: localNavigator(),
          )),
    );
  }
}
