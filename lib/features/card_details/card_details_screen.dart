
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../basewidget/custom_textfield.dart';

class ImageModel{
final String image;

  ImageModel(this.image);
}
class CardDetailsScreen extends StatelessWidget {
    CardDetailsScreen({super.key, required this.image});

   final TextEditingController receiverController=TextEditingController();
   final TextEditingController senderController=TextEditingController();
   final TextEditingController contentController=TextEditingController();
final  String image;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20,),
              Container(
                padding: const EdgeInsets.all(8),
                height: 500,
                decoration:  BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage(image)
                    )
                ),
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(width: double.infinity,),

                    const SizedBox(height:436,),
                    SizedBox(width: 10,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: CustomTextField(
                        hintText: "Enter your name",

                      ),
                    ),
                    // Center(child: Text(DateTime.now().toString()))
                  ],
                ),
              ),

          
          

          
            ],
          ),
        )
      ),
    );
  }
}

class BuildTeamWorkItem extends StatelessWidget {
  const BuildTeamWorkItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  const Column(
      children: [
        CircleAvatar(

          child: CircleAvatar(
            radius: 52,
            backgroundImage: NetworkImage("https://images.rawpixel.com/image_png_800/cHJpdmF0ZS9sci9pbWFnZXMvd2Vic2l0ZS8yMDIyLTA4L2pvYjEwMzQtZWxlbWVudC0wNy00MDMucG5n.png"),


          ) ,radius:55 ,backgroundColor: Colors.black,
        ),

        SizedBox(
          width: 130,
          child: Text(
            "ahmed tarek ahmed tarek ahmed tarek",
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(
          width: 120,
          child: Text(
            "ahmed tarek ahmed tarek",
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 15,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
