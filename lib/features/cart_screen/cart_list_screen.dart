import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_quakka/features/category/update_category/update_category_screen.dart';
import 'package:shimmer/shimmer.dart';

import '../../basic_constants.dart';
import '../../core/network/api_constants.dart';
import '../../utill/color_resources.dart';
import '../add_cart/add_cart_screen.dart';
import '../home/home_cubit/home_cubit.dart';
import '../home/home_screen.dart';
import '../home/login_widget_home.dart';
import '../send_cart/send_cart_screen.dart';
import 'cuibt.dart';


class CartListScreen extends StatelessWidget {
  final int categoryId;

  CartListScreen({required this.categoryId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCubit()..fetchCarts(categoryId),
      child: Scaffold(
        appBar: AppBar(
          title: Shimmer.fromColors(
            baseColor: ColorResources.apphighlightColor,
            highlightColor: ColorResources.apphighlightColor,
            child: Text(
              HomeCubit.get(context).isArabic
                  ? "الكروت"
                  : "Carts",
            ),
          ),
          leading: InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> const HomeScreen()));
            },
            child: const Icon(
                Icons.arrow_back),
          ),
          actions:
          [
            isAdmin == true ?
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateCategoryScreen(categoryId: categoryId)));
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 12),
                backgroundColor: ColorResources.apphighlightColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    30,
                  ),
                ),
              ),
              child: Text(
                HomeCubit.get(context).isArabic
                    ? "تحديث القسم"
                    : 'Update Category',
                style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white
                ),
            
              ),
            
            ) :
            const SizedBox(),
            // InkWell(
            //   onTap: (){
            //     print(categoryId);
            //     context.read<CartCubit>().deleteCategory(categoryId);
            //     //context.pop();
            //     },
            //   child: const Icon(
            //       Icons.delete),
            // ),
          ],
        ),
        body: BlocBuilder<CartCubit, CartState>(
          builder: (context, state) {
            print(" isSignIn >> $isSignIn");
            print(" isAdmin >> $isAdmin");
            print(" userId >> $userId");
            if (state is CartLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CartFailure) {
              return Center(child: Text(state.error));
            } else if (state is CartSuccess) {
              return Padding(
                padding: const EdgeInsets.all(10),

                child:  GridView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, // Number of columns in the grid
                    crossAxisSpacing: 2.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: 0.60, // Aspect ratio of the grid items
                  ),
                  itemCount: state.carts.length,
                  itemBuilder: (context, index) {
                    final cart = state.carts[index];
                    return InkWell(
                      onTap: (){
                        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => userId != null ?
                        SendCartScreen(userId: userId!, cartId: cart.id,categoryId: categoryId): 
                         Scaffold(
                          appBar: AppBar(

                            leading: InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>  CartListScreen(categoryId: categoryId)));
                              },
                              child: const Icon(
                                  Icons.arrow_back),
                            ),
                            actions:
                            [
                              isAdmin == true ?
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateCategoryScreen(categoryId: categoryId)));
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 12),
                                  backgroundColor: ColorResources.apphighlightColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      30,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  HomeCubit.get(context).isArabic
                                      ? "تحديث القسم"
                                      : 'Update Category',
                                  style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.white
                                  ),

                                ),

                              ) :
                              const SizedBox(),
                              // InkWell(
                              //   onTap: (){
                              //     print(categoryId);
                              //     context.read<CartCubit>().deleteCategory(categoryId);
                              //     //context.pop();
                              //     },
                              //   child: const Icon(
                              //       Icons.delete),
                              // ),
                            ],
                          ),
                            body: LoginWidgetHome())));
                        
                        print("CartId=====>>>> ${cart.id}");
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Stack(
                                children: [
                                  CachedNetworkImage(
                                    height: 400,
                                    width: 400,
                                    fit: BoxFit.cover,
                                    imageUrl: 'http://backend.quokka-mesh.com/${cart.imageDesign}',
                                    httpHeaders: const {
                                      ApiConstants.tokenTitle:
                                      ApiConstants.tokenBody
                                    },
                                  ),

                                  cart.isPremium ?
                                  Positioned(
                                    top: 5,
                                    left: 5,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.5),
                                        borderRadius: BorderRadius.circular(10),
                                      ),

                                      child: Image.asset(
                                          "assets/images/tag.png",
                                        height: 20,
                                        width: 20,

                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ) : Container(),

                                ]
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                  cart.title,
                                  style: const TextStyle(
                                    color: ColorResources.appColor,
                                    fontSize: 14,
                                  )
                              ),
                            ),


                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            } else {
              return const Center(child: Text('No carts found.'));
            }
          },
        ),



        floatingActionButton:
            isAdmin ==true ?
        FloatingActionButton(
          foregroundColor: ColorResources.appColor,
          backgroundColor: ColorResources.appColor,
          child:  Shimmer.fromColors(
              baseColor: ColorResources.white,
              highlightColor: ColorResources.apphighlightColor,
              child: const Icon(Icons.add,size: 30,)),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>  AddCartScreen(categoryId: categoryId,)));
              print("categoryId=== $categoryId");
            }
        ) : const SizedBox(),
      ),
    );
  }
}
