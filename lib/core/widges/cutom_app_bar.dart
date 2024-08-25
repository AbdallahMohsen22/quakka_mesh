import 'package:flutter/material.dart';

AppBar buildAppBar({final String? title}) {
  return AppBar(
    // leading: InkWell(
    //   child: Center(
    //     child: SvgPicture.asset(
    //       'assets/images/arrow.svg',
    //     ),
    //   ),
    // ),
    elevation: 0,
    backgroundColor: Colors.transparent,
    centerTitle: true,
    // title: Text(
    //   title ?? '',
    //   textAlign: TextAlign.center,
    //   style: TextStyle(
    //     color: Colors.black,
    //     fontSize: 25,
    //     fontFamily: 'Inter',
    //     fontWeight: FontWeight.w500,
    //     height: 0,
    //   ),
    // ),
  );
}
