// import 'package:flutter/material.dart';
// import 'package:quokka_mesh/features/auth/login_screen.dart';
// import 'package:quokka_mesh/features/home/home_screen.dart';
//
// import '../../utill/app_assets.dart';
//
//
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({Key? key}) : super(key: key);
//
//
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
//
//
// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     Future.delayed(const Duration(seconds: 3), () {
//       // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
//       //   // bool? onBoarding = CacheNetwork.getData(key: "onBoarding");
//       //
//       //   if (user != null) {
//       //       return RootScreen();
//       //   } else {
//       //     return const LoginScreen();
//       //   }
//       // }
//       Navigator.pushReplacement(context, MaterialPageRoute(builder:
//           (context) => const LoginScreen(),));
//     });
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body:Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: const BoxDecoration(
//           image: DecorationImage(fit:BoxFit.fill,image: AssetImage(AppAssets.splash_icon,),)
//         ),
//       )
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:new_quakka/features/splash/splash_body.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return SplashBody();
  }

}

