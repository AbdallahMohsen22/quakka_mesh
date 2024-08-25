import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogUtils{
  static void showLoading(BuildContext context , String message , {bool isDismissible= true}){
    showDialog(context: context,
        builder: (buildContext){
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),

            content: Row(
              children: [

                Text(message),
                const SizedBox( width: 20.0,),
                const Spacer(),
                const CircularProgressIndicator(),

              ],
            ),
          );
        },
        barrierDismissible: false

    );
  }


  static void showMessage (BuildContext context , String message ,{
    String? posActionTitle ,
    VoidCallback ? posAction,
    String? negActionTitle ,
    VoidCallback ? negAction ,
    bool isDismissible= true
  }){
    List<Widget> actions=[];
    if (posActionTitle !=null){
      actions.add(TextButton(onPressed: (){
        Navigator.pop(context);
        if(posAction!=null) posAction();

      },
          child: Text(
            posActionTitle,
            style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: Colors.black
            ),

          )));
    }

    if (negActionTitle !=null){
      actions.add(TextButton(onPressed: (){
        Navigator.pop(context);
        if(posAction!=null) negAction!();

      },
          child: Text(negActionTitle,
            style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: Colors.black
            ),

          )));
    }


    showDialog(context: context,
        builder: (buildContext){
          return CupertinoAlertDialog(
            /*
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),

             */
            content: Text(message,
              style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold
              ),
            ),
            actions: actions,

          );
        },
        barrierDismissible: false

    );

  }


  static void showWidget (BuildContext context , Widget widget ,{
    String? posActionTitle ,
    VoidCallback ? posAction,
    String? negActionTitle ,
    VoidCallback ? negAction ,
    bool isDismissible= true
  }){
    List<Widget> actions=[];
    if (posActionTitle !=null){
      actions.add(TextButton(onPressed: (){
        Navigator.pop(context);
        if(posAction!=null) posAction();

      },
          child: Text(
            posActionTitle,
            style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: Colors.black
            ),

          )));
    }

    if (negActionTitle !=null){
      actions.add(TextButton(onPressed: (){
        Navigator.pop(context);
        if(posAction!=null) negAction!();

      },
          child: Text(negActionTitle,
            style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: Colors.black
            ),

          )));
    }


    showDialog(context: context,
        builder: (buildContext){
          return CupertinoAlertDialog(
            /*
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),

             */
            content: widget,
            actions: actions,

          );
        },
        barrierDismissible: false

    );

  }

  static void hideLoading(BuildContext context){
    Navigator.pop(context);
  }


  static void showButton(BuildContext context , String buttonName,IconData icon ,Function() onTab, {bool isDismissible= false}){
    showDialog(context: context,
        builder: (buildContext){
          return CupertinoAlertDialog(
            /*shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),

             */

            content: InkWell(
              onTap:(){
                onTab();

              },

              child: Row(
                children: [

                  Text(buttonName),
                  Spacer(),
                  const SizedBox( width: 20.0,),
                  Icon(
                      icon
                  ),

                ],
              ),
            ),
          );
        },
        barrierDismissible: true

    );
  }

}

