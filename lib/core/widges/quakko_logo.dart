import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuakkoLogo extends StatelessWidget {
  const QuakkoLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        Container(
          /*
          foregroundDecoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Colors.white,
              Colors.white.withOpacity(0.0)
            ],
            begin: Alignment.bottomCenter,
            end:  Alignment.topCenter,
            stops: const [0.14,0.8]
            )
          ),
          */
          child: Image.asset(
            'assets/images/logo_with_name.png',
            width: 300.w,
            height: 200.h,
          ),
        ),

        const Spacer(),
      ],
    );
  }
}

class QuakkoAppBarLogo extends StatelessWidget {
  const QuakkoAppBarLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return
    //   TextButton(
    //     onPressed: (){
    //       Constants.signOut(context);
    //
    // },
    //     child:Text( "LogOut",style: TextStyle(color: Colors.green),));


      Image.asset(
      "assets/images/logo_with_name.png",
      height: 55.h,
      width: 115.w,
    );
    /*
      sharedPref!.getString("lang")=='en'?
      Image.asset("assets/images/en_logo.png",
      height: 55,
      width: 130,
    ):Image.asset("assets/images/ar_logo.png",
        height: 55,
        width: 130,
      );
      */
  }
}
