import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_quakka/utill/color_resources.dart';

import '../../core/network/api_constants.dart';
import '../../core/theming/text_styles.dart';
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
            return const Center(child: CircularProgressIndicator());
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

        elevation: 20,
        color: ColorResources.apphighlightColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: 'http://backend.quokka-mesh.com/${category.image}',
                httpHeaders: const {
                  ApiConstants.tokenTitle:
                  ApiConstants.tokenBody
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    category.titel,
                    style: AppTextStyles.categoryTextStyle,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),

                ],
              ),
            ),
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
