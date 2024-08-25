import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import '../core/widges/title_text_widget.dart';
import 'cache_helper.dart';


String? uId='';
bool checkArabic() {
  return Intl.getCurrentLocale() == 'ar';
}

class Constants {
  static void showErrorDialog(
      {required BuildContext context, required String msg}) {
    showDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: Text(
            msg,
            style: const TextStyle(color: Colors.black, fontSize: 16),
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                style: TextButton.styleFrom(
                  //primary: Colors.black,
                  textStyle: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                ),
                child: const Text("Ok"))
          ],
        ));
  }

  static void showToast({
    required String msg,
    required Color color,
    ToastGravity? gravity,
  }) {
    Fluttertoast.showToast(
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: color,
        gravity: gravity ?? ToastGravity.BOTTOM,
        msg: msg);
  }


  static Future<void> imagePickerDialog({
    required BuildContext context,
    required Function cameraFCT,
    required Function galleryFCT,
    required Function removeFCT,
  }) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Center(
              child: TitlesTextWidget(
                label: "Choose option",
              ),
            ),
            content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        cameraFCT();
                        if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        }
                      },
                      icon: const Icon(Icons.camera),
                      label: const Text(
                        "Camera",
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        galleryFCT();
                        if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        }
                      },
                      icon: const Icon(Icons.image),
                      label: const Text(
                        "Gallery",
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        removeFCT();
                        if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        }
                      },
                      icon: const Icon(Icons.remove),
                      label: const Text(
                        "Remove",
                      ),
                    ),
                  ],
                )),
          );
        });
  }

  static void signOut(context) {
    CacheHelper.removeData(key: 'uId').then((value){
      if(value==true){
      }
    });
  }



}