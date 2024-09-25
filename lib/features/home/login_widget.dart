import 'package:flutter/material.dart';
import '../../utill/color_resources.dart';
import '../login/login_screen.dart';
import 'home_cubit/home_cubit.dart';
import 'widgets/custom_asset_image.dart';

class LoginWidget extends StatelessWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8,right: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomAssetImage(
            imageUrl: 'assets/images/logout_2.png',
            fit: BoxFit.contain,
            height: MediaQuery.of(context).size.height*0.15,
            width: MediaQuery.of(context).size.height*0.5,
          ),
          const SizedBox(height: 15,),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(12),
                backgroundColor: ColorResources.apphighlightColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                ),
              ),
              icon: const Icon(Icons.login_rounded,color: Colors.white,),
              label: Text(
                HomeCubit.get(context).isArabic
                    ? "تسجيل دخول"
                    : "Login",
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white
                ),
              ),
              onPressed: ()  {
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen())); // Navigate back or to another screen

                // validateThenDoLogin(context);
                //login(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
