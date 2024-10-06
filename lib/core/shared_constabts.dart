
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utill/cache_helper.dart';
import 'theming/colors.dart';


String? uId = '';

Future<void> launchCustomUrl(context,String? url)async {

  if (url !=null) {
    Uri uri= Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }else{
      customSnackBar(context, "Cannot launch $url");
    }
  }
}
// Future<void> _launchUrl() async {
//   if (!await launchUrl(_url)) {
//     throw Exception('Could not launch $_url');
//   }
// }
void customSnackBar(context, String url) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text("Cannot launch $url")),);
}


class Constants {
  static void showErrorDialog(
      {required BuildContext context, required String msg}) {
    showDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
              title: Text(
                msg,
                style:  TextStyle(color: Colors.black, fontSize: 16.sp),
              ),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    style: TextButton.styleFrom(
                      //primary: Colors.black,
                      textStyle:  TextStyle(
                          fontSize: 14.sp, fontWeight: FontWeight.bold),
                    ),
                    child: const Text("Ok"))
              ],
            ));
  }

  static void showToast({
    required String msg,
    Color? color,
    ToastGravity? gravity,
  }) {
    Fluttertoast.showToast(
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: color ?? ColorsManager.mainBlue,
        gravity: gravity ?? ToastGravity.BOTTOM,
        msg: msg);
  }


  static void signOut(context) {
    CacheHelper.removeData(key: 'uId').then((value){
      if(value==true){
      }
    });
  }



}


class ValidationUtils{
  static bool isValidEmail (String email ){

   return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
}
