
import 'package:flutter/material.dart';
import 'package:new_quakka/basic_constants.dart';
import 'package:new_quakka/core/network/message.dart';
import '../../../utill/color_resources.dart';
import '../../banner/banners_view.dart';
import '../../basewidget/drawer.dart';
import '../../category/category_model.dart';
import '../category_screen.dart';
import '../home_cubit/home_cubit.dart';


class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}
  Category? category;

class _HomePageScreenState extends State<HomePageScreen> {
  @override
  Widget build(BuildContext context) {



    return Scaffold(
      resizeToAvoidBottomInset: false,
      body:  SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              // expandedHeight: 200.0,
              floating: false,
              pinned: true,
              elevation: 0,
              centerTitle: false,
              automaticallyImplyLeading: false,
              backgroundColor: ColorResources.apphighlightColor,
              title: Image.asset('assets/images/logo_with_name.png', height: 50), actions:  [
                InkWell(
                  child: const Icon(Icons.notifications,color: Colors.white,size: 25,),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const Message() ));  //Notification Screen from Firebase
                    // context.pushNamed(Routes.notificationScreen);
                  },
                ),
              // SizedBox(width:15,),
              // InkWell(
              //   child: Icon(Icons.search,color: Colors.white,size: 25,),
              //   onTap: (){},
              // ),
              const SizedBox(width:15,),
              userId != null ?
              InkWell(
                child: const Icon(Icons.settings,color: Colors.white,size: 25,),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (c)=>MainDrawer()));
                },
              ) : const SizedBox(),
              const SizedBox(width:15,),
            ],),


            SliverToBoxAdapter(
              child: Column(
                children:
                [

                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                    child: BannerView(),
                  ),

                  const SizedBox(height: 20,),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 7),
                    child: Row(
                      children: [
                        Text(
                          HomeCubit.get(context).isArabic?
                          "الاقسام":"Categoreis",
                          style: const TextStyle(color: ColorResources.apphighlightColor,fontSize: 20),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20,),
                  //Categories
                  const CategoryView(),


                ],
              ),
            ),


          ],
        ),
      ),
    );
  }
}
