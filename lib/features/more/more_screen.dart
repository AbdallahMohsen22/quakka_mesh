import 'package:flutter/material.dart';

import '../../localization/language_constrants.dart';
import '../../provider/theme_provider.dart';
import '../../utill/dimensions.dart';
import '../basewidget/custom_themes.dart';
import '../category/all_category_screen.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  late bool isGuestMode;




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [

                  ]),
            ),
          );



  }
}


