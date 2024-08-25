import 'dart:async';
import 'package:flutter/material.dart';

import '../../core/routing/routes.dart';
import '../../utill/app_assets.dart';


class SplashBody extends StatefulWidget {
  const SplashBody({Key? key}) : super(key: key);

  @override
  _SplashBodyState createState() => _SplashBodyState();
}

class _SplashBodyState extends State<SplashBody> with SingleTickerProviderStateMixin{

  late Timer _timer;

  _goNext() => Navigator.pushReplacementNamed(context, Routes.loginScreen);
  _startDelay() {
    _timer = Timer(const Duration(milliseconds: 6000), () => _goNext());
  }
  @override
  void initState() {
    super.initState();
    _startDelay();
  }
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
              image: DecorationImage(fit:BoxFit.fill,image: AssetImage(AppAssets.splash_icon,),)
          ),
        )
    );
  }

}
