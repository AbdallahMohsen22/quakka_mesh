import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends  StatelessWidget {
  const CustomButton({super.key,
    this.wide=double.infinity,
    this.background=Colors.deepPurple,
    required this.function,
    required this.text,

  });
  final double wide ;
  final Color background ;
  final VoidCallback function;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: wide,
       color: background,
      child: MaterialButton(
        // color: background,
        onPressed: function,

        child: Text(
          text,
          style:  TextStyle(color: Colors.white, fontSize: 15.sp),
        ),
      ),
    );
  }
}
