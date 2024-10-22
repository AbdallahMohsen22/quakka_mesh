import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:new_quakka/utill/color_resources.dart';

import '../../core/helpers/adaptive_indecator.dart';
import '../../core/network/api_constants.dart';
import '../../utill/constant.dart';
import '../cart_screen/cart_list_screen.dart';
import '../category/category_model.dart';
import '../category/cuibt.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(

      create: (BuildContext context) => CategoryCubit()..fetchCategories(),
      child: BlocBuilder<CategoryCubit, CategoryState>(
        builder: (context, state) {
           if (state is CategoryLoading) {
            return  Center(child: AdaptiveIndicator(os: getOS()));
          } else if (state is CategoryLoaded) {
            return GridView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns in the grid
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                childAspectRatio: 0.75, // Aspect ratio of the grid items
              ),
              itemCount: state.categories.length,
              itemBuilder: (context, index) {
                final category = state.categories[index];
                return CategoryCard(category: category);
              },
            );
          } else if (state is CategoryError) {
            return const Center(child: Text("Check your connection"));
          }
          return Container();
        },
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final Category category;

  CategoryCard({required this.category});

  @override
  Widget build(BuildContext context) {

    return InkWell(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // Rounded corners for the card
        ),
        elevation: 8,
        shadowColor: Colors.grey.withOpacity(0.3),
        color: ColorResources.apphighlightColor,
        child: Stack(

          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20), // Same borderRadius as card
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: 'http://backend.quokka-mesh.com/${category.image}',
                httpHeaders: const {
                  ApiConstants.tokenTitle: ApiConstants.tokenBody,
                },
                placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Icon(Icons.error),
                 width: 500.w,
                height: 500.h,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), // Rounded corners for overlay
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.grey.withOpacity(0.1), // Light fade at the top
                    Colors.black.withOpacity(0.1), // Darker fade at the bottom
                  ],
                ),
              ),
            ),

            // Category title text
            // Positioned(
            //   bottom: 10,
            //   left: 10,
            //   right: 10,
            //   child: Text(
            //     category.titel,
            //     style: AppTextStyles.categoryTextStyle.copyWith(
            //       color: Colors.white,
            //       fontWeight: FontWeight.bold,
            //       fontSize: 18,
            //     ),
            //     overflow: TextOverflow.ellipsis,
            //     maxLines: 2,
            //   ),
            // ),
          ],
        ),

      ),
      onTap: () {
        print("category_id= ${category.id}");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CartListScreen(categoryId: category.id),
          ),
        );
      },
    );
  }
}
