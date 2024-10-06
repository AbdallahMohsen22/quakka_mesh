import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveIndicator extends StatelessWidget {

  final String os;
  const AdaptiveIndicator({super.key,
    required this.os});

  @override
  Widget build(BuildContext context) {
    if (os == 'android')
      return CircularProgressIndicator();

    return CupertinoActivityIndicator();
  }
}
