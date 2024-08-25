import 'package:flutter/material.dart';

import '../../../../../utill/color_resources.dart';

class TotalPrice extends StatelessWidget {
  const TotalPrice({super.key, required this.title, required this.value});

  final String title, value;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: ColorResources.apphighlightColor
          ),
        ),
        const Spacer(),
        Text(
          value,
          textAlign: TextAlign.center,
          style:TextStyle(
              color: ColorResources.apphighlightColor
          ),
        )
      ],
    );
  }
}
