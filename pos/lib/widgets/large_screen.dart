import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pos/helpers/local_navigator.dart';
import 'package:pos/widgets/side_menu.dart';


class LargeScreen extends StatelessWidget {
  const LargeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Expanded(child: SideMenu()),
        Expanded(
          flex: 5,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: localNavigator(),
          ),
        )
      ],
    );
  }
}
